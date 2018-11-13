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
        pendingWithdrawals[msg.sender] = 0; 
        msg.sender.transfer(amount);
    }

    function transferSharedEther(address  recipient1, address  recipient2) public payable {
        require (msg.value % 2 == 0);
        uint amountToSend1 = msg.value/2;
        uint amountToSend2 = msg.value/2;
        pendingWithdrawals[recipient1] = amountToSend1;
        pendingWithdrawals[recipient2] = amountToSend2;
    } 

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

