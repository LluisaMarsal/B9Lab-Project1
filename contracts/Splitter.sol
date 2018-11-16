pragma solidity ^0.4.19;

contract Splitter {
    address public owner;
    mapping (address => uint) public pendingWithdrawals; 

    event LogWithdrawl(address indexed owner, uint amount);
    event LogTransferSharedEther(address sender, address recipient1, address recipient2, uint value);
    event LogOwnerChanged(address owner, address newOwner);
    
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
        if (msg.value % 2 != 0) {
            pendingWithdrawals[owner] += msg.value - half*2;
        }
        uint half = msg.value/2;
        pendingWithdrawals[recipient1] += half;
        pendingWithdrawals[recipient2] += half;
        LogTransferSharedEther(msg.sender, recipient1, recipient2, msg.value);
    } 
    
    function changeOwner(address newOwner) public {
        require(msg.sender == owner);
        owner = newOwner;
        LogOwnerChanged(owner, newOwner);
    }

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        selfdestruct(owner);
        return true;
    }
}

