# B9Lab-Project1
Splitter project 

GOAL
This exercise is aimed at practising with Geth along with Solidity and Truffle to create a small application that will split ehter into two different accounts. The application should also protect users and its contracts from villains.

SETTING
The application will be named "Splitter" whereby:
•	there are 3 people: Alice, Bob and Carol.
•	we can see the balance of the Splitter contract on the Web page.
•	whenever Alice sends ether to the contract for it to be split, half of it goes to Bob and the other half to Carol.
•	we can see the balances of Alice, Bob and Carol on the Web page.
•	Alice can use the Web page to split her ether.

LLUISA'S METHOD (V1= this version)
1. In preparation for testing the smart contracts on the web page (which I did not create yet), I created 1 additional Geth account (for the web tests, I will be reusing the 2 accounts previously created in other lessons)
2. On the web, Lluisa will be impersonating Alice in account[0], Bob will be account[1] and Carol will hold the newly created account[2]
    account[0]= 0x89063abe69934a06e1a8f636d448725fc8d57cbf
    account[1]= 0x0ca374e9226edfda1bb47ba22cd679c8f2fd150d
    account[2]= 0xb1004fb128ee03ed57e1104285363ac2d46fcd24
3. I created a new directory for the project named "splitter_project" and, using my Geth node, unboxed there the Metacoin project which I used as template. I deployed the Metacoin project on truffle's "development" network. 
4. Replaced the MetaCoin.sol contract by the Splitter.sol contract which, hopefully, will serve the purpose of splitting an initial amount in ehter into two equal amounts. (I reused Module3's Faucet contract for this)
4. Created a third script in the contracts folder, the "Robusta0a" contract, to prevent the Splitter application to be externally attacked and migrated contracts again. 
5. Deployed in the "development" network for the moment and will deploy on net42 and Ropsten after your initial assessment
