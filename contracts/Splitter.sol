pragma solidity ^0.4.19;

contract Splitter {
    address public owner; 

    function Splitter() public payable {
        owner = msg.sender; 
    }
   
    function transferSharedEther (address  recipient1, address  recipient2) public payable {
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

