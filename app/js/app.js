const Web3 = require("web3");
const Promise = require("bluebird");
const truffleContract = require("truffle-contract");
const $ = require("jquery");
// Not to forget our built contract
const splitterJson = require("../../build/contracts/Splitter.json");
// Supports Mist, and other wallets that provide 'web3'.
if (typeof web3 !== 'undefined') {
    // Use the Mist/wallet/Metamask provider.
    window.web3 = new Web3(web3.currentProvider);
} else {
    // Your preferred fallback.
    window.web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545')); 
}
Promise.promisifyAll(web3.eth, { suffix: "Promise" });
Promise.promisifyAll(web3.version, { suffix: "Promise" });
const Splitter = truffleContract(splitterJson);
Splitter.setProvider(web3.currentProvider);
window.addEventListener('load', function() {
    return web3.eth.getAccountsPromise()
        .then(accounts => {
            if (accounts.length == 0) {
                $("#balance").html("N/A");
                throw new Error("No account with which to transact");
            }
            window.account = accounts[0];
            // console.log("Account:", window.account);
            return web3.version.getNetworkPromise();
        })
        .then(network => {
            console.log("Network:", network.toString(10));
            return Splitter.deployed();
        })
        .then(deployed => deployed.getBalance.call(window.account))
        // Notice how the conversion to a string is done at the very last moment.
        .then(balance => $("#balance").html(balance.toString(10)))
        // Never let an error go unlogged.
        .then(() => $("#send").click(sendEther))
        // Never let an error go unlogged.
        .catch(console.error);
});
require("file-loader?name=../index.html!../index.html");
const sendEther = function() {
    // Sometimes you have to force the gas amount to a value you know is enough because
    // `web3.eth.estimateGas` may get it wrong.
    const gas = 300000; let deployed;
    // We return the whole promise chain so that other parts of the UI can be informed when
    // it is done.
    return Splitter.deployed()
        .then(_deployed => {
            deployed = _deployed;
            // We simulate the real call and see whether this is likely to work.
            // No point in wasting gas if we have a likely failure.
            return _deployed.sendEther.call(
                $("input[name='recipient1']").val(),
                $("input[name='recipient2']").val(),
                // Giving a string is fine
                $("input[name='amount']").val(),
                { from: window.account, gas: gas });
        })
        .then(success => {
            if (!success) {
                throw new Error("The transaction will fail anyway, not sending");
            }
            // Ok, we move onto the proper action.
            // .sendTransaction so that we get the txHash immediately while it 
            // is mined, as, in real life scenarios, that can take time of 
            // course.
            return deployed.sendEther.sendTransaction(
                $("input[name='recipient1']").val(),
                $("input[name='recipient2']").val(),
                // Giving a string is fine
                $("input[name='amount']").val(),
                { from: window.account, gas: gas });
        })
        // We would have a proper `txObject` if we had not added `.sendTransaction` above.
        // Oh well, more work is needed here for our user to have a nice UI.
        .then(txHash => {
            $("#status").html("Transaction on the way " + txHash);
            // Now we wait for the tx to be mined. Typically, you would take this into another
            // module, as in https://gist.github.com/xavierlepretre/88682e871f4ad07be4534ae560692ee6
            const tryAgain = () => web3.eth.getTransactionReceiptPromise(txHash)
                .then(receipt => receipt !== null ?
                    receipt :
                    // Let's hope we don't hit any max call stack depth
                    Promise.delay(1000).then(tryAgain));
            return tryAgain();
        })
        .then(receipt => {
            if (parseInt(receipt.status) != 1) {
                console.error("Wrong status");
                console.error(receipt);
                $("#status").html("There was an error in the tx execution, status not 1");
            } else if (receipt.logs.length == 0) {
                console.error("Empty logs");
                console.error(receipt);
                $("#status").html("There was an error in the tx execution");
            } else {
                // Format the event nicely.
                console.log(deployed.Transfer().formatter(receipt.logs[0]).args);
                $("#status").html("Transfer executed");
            }
            // Make sure we update the UI.
            return deployed.getBalance.call(window.account);
        })
        .then(balance => $("#balance").html(balance.toString(10)))
        .catch(e => {
            $("#status").html(e.toString());
            console.error(e);
        });
};

