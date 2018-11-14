pragma solidity ^0.4.19;

contract Splitter {
    address public owner;
    address onlyOwner = owner;
    mapping (address => uint) pendingWithdrawals; 

    event LogWithdrawl(address indexed owner, uint amount);
    event LogTransferSharedEther(address indexed recipient1, address indexed recipient2, uint amountToSend1, uint amountToSend2);
    
    function Splitter() public {
        owner = msg.sender; 
    }
   
    function withdraw() public { 
        uint amount = pendingWithdrawals[msg.sender];
        require (amount >= 0);
        pendingWithdrawals[msg.sender] = 0; 
        LogWithdrawl(msg.sender, amount);
        msg.sender.transfer(amount);
    }

    function transferSharedEther(address  recipient1, address  recipient2) public payable {
        require (msg.value % 2 == 0);
        uint amountToSend1 = msg.value/2;
        uint amountToSend2 = msg.value/2;
        pendingWithdrawals[recipient1] += amountToSend1;
        pendingWithdrawals[recipient2] += amountToSend2;
        LogTransferSharedEther(recipient1, recipient2, amountToSend1, amountToSend2);
    } 
    
    function changeOwner(address newOwner) public onlyOwner {
        if onlyOwner = owner;
        owner = newOwner;
    }

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

