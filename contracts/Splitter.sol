pragma solidity ^0.4.19;

contract Splitter {
    address public owner;
    mapping (address => uint) pendingWithdrawals; 

    function Splitter() public {
        owner = msg.sender; 
    }
   
    function withdraw() public { 
        uint amount = pendingWithdrawals[msg.sender];
        require (amount >= 0);
        msg.sender.transfer(amount);
    }

    function update(uint remainingBalance) private returns (uint) {
        pendingWithdrawals[msg.sender] = remainingBalance;
        return remainingBalance;
    }

    function transferSharedEther(address  recipient1, address  recipient2) public payable {
        require (msg.value % 2 == 0);
        uint amountToSend = msg.value/2;
        pendingWithdrawals[recipient1] = amountToSend;
        pendingWithdrawals[recipient2] = amountToSend;
    } 

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

