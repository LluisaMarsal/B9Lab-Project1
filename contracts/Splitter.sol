pragma solidity ^0.4.19;

contract Splitter {
    address public owner;
    mapping (address => uint) pendingWithdrawals; 

    function Splitter() private {
        owner = msg.sender; 
    }
   
    function withdraw() private { 
        uint amount = pendingWithdrawals[msg.sender];
        require (pendingWithdrawals[msg.sender] >= 0);
        msg.sender.transfer(amount);
    }

    function transferSharedEther(address  recipient1, address  recipient2) public payable {
        require (msg.value % 2 == 0);
        uint amountToSend = msg.value/2;
        pendingWithdrawals.recipient1(amountToSend);
        pendingWithdrawals.recipient2(amountToSend);
    } 

    function update(uint remainingBalance) private {
        pendingWithdrawals[msg.sender] = remainingBalance;
        remainingBalance != pendingWithdrawals;
        return remainingBalance;
    }

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

