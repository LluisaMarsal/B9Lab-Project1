var Splitter = artifacts.require("./Splitter.sol");

contract('Splitter', function(accounts) {
  it("should put 10000 Ether in the first account", function() {
    return MetaCoin.deployed().then(function(instance) {
      return instance.getBalance.call(accounts[0]);
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 10000, "10000 wasn't in the first account");
    });
  });
  it("should call a function that depends on a linked library", function() {
    var splitter;
    var splitterBalance;
    var splitterEthBalance;

    return Splitter.deployed().then(function(instance) {
      splitter = instance;
      return splitter.getBalance.call(accounts[0]);
    }).then(function(outEthBalance) {
      splitterBalance = outEthBalance.toNumber();
      return splitter.getBalanceInEth.call(accounts[0]);
    }).then(function(outSplitterBalanceEth) {
      SplitterEthBalance = outEthBalanceEth.toNumber();
    }).then(function() {
      assert.equal(SplitterEthBalance, 2 * splitterBalance, "Library function returned unexpected function, linkage may be broken");
    });
  });
  it("should send eth correctly", function() {
    var splitter;

    // Get initial balances of first and second account.
    var account_one = accounts[0];
    var account_two = accounts[1];

    var account_one_starting_balance;
    var account_two_starting_balance;
    var account_one_ending_balance;
    var account_two_ending_balance;

    var amount = 10;

    return Splitter.deployed().then(function(instance) {
      splitter = instance;
      return splitter.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return splitter.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return splitter.sendCoin(account_two, amount, {from: account_one});
    }).then(function() {
      return splitter.getBalance.call(account_one);
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber();
      return splitter.getBalance.call(account_two);
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber();

      assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender");
      assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver");
    });
  });
});
