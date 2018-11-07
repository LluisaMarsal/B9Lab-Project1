pragma solidity ^0.4.19;

contract Splitter {
    address public owner;
    mapping (address => uint) pendingWithdrawals; 

    function Splitter() public payable {
        owner = msg.sender; 
    }
   
    function withdraw() public payable { 
        uint amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }

    function transferSharedEther(address  recipient1, address  recipient2) public {
        require (msg.value % 2 == 0);
        uint amountToSend = msg.value/2;
        recipient1.transfer(amountToSend);
        recipient2.transfer(amountToSend);
    } 

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

