pragma solidity ^0.4.19;

import "./Robust0a.sol";

contract Splitter {
    address public owner;
    mapping (address => uint) public pendingWithdrawals; 

    function Splitter() public {
        owner = msg.sender; 
    }
   
    function withdraw() public { 
        uint amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] >= 0;
        msg.sender.transfer(amount);
    }

    function transferSharedEther(address  recipient1, address  recipient2) public payable {
        require (msg.value % 2 == 0);
        uint amountToSend = msg.value/2;
        recipient1.pendingWithdrawals(amountToSend);
        recipient2.pendingWithdrawals(amountToSend);
    } 

    function update(uint remainingBalance) public {
        pendingWithdrawals[msg.sender] = remainingBalance;
    }

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

