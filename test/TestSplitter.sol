pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Splitter.sol";

contract TestSplitter {

  function testInitialBalanceUsingDeployedContract() public {
    Splitter splitter = Splitter(DeployedAddresses.Splitter());

    uint expected = 10000;

    Assert.equal(splitter.getBalance(tx.origin), expected, "Owner should have 10000 Eth initially");
  }

  function testInitialBalanceWithNewSplitter() public {
    Splitter splitter = new Splitter();

    uint expected = 10000;

    Assert.equal(splitter.getBalance(tx.origin), expected, "Owner should have 10000 Eth initially");
  }

}
