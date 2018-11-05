pragma solidity ^0.4.19;


contract Splitter {
    address owner; 
    address recipient1; 
    address recipient2; 

    function Splitter() public payable {
        owner = 0x89063abe69934a06e1a8f636d448725fc8d57cbf;  
        recipient1 = 0x0ca374e9226edfda1bb47ba22cd679c8f2fd150d;
        recipient2 = 0xb1004fb128ee03ed57e1104285363ac2d46fcd24;
    }
   
    function send (address _recipient1, address _recipient2) public payable {
     _recipient1.transfer(msg.value/2);
     _recipient2.transfer(msg.value/2);
    } 

    function killMe() public returns (bool) {
        require(msg.sender == owner);
        require(msg.value % 2 == 0);
        selfdestruct(owner);
        return true;
    }
} 

