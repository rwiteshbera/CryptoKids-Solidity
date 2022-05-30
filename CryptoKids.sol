// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.4.16 <0.9.0;


contract CryptoKids {
    // Owner DAD
    address owner_dad_address;

    constructor() {
        // Person who is making transaction in this smart contract will be the owner of this smart contract
        owner_dad_address = msg.sender;
    }

    // Define Kids
    struct Kid {
        address WalletAddress;
        string firstName;
        string lastName;
        uint releaseTime;
        uint amount;
        bool canWithdraw;
    }

    // Array of struct of kids
    Kid[] public kids;


    // Add kids to contract
    function addKid (address WalletAddress,string memory firstName, string memory lastName, uint releaseTime,uint amount, bool canWithdraw) public {
        kids.push(Kid(
            WalletAddress,
            firstName,
            lastName,
            releaseTime,
            amount,
            canWithdraw
        ));
    }

    // Deposit funds to contract, specially for a kid's contract
    function deposit (address WalletAddress) payable public {
        
    }

    // Kid checks if he/she can withdraw money

    // Withdraw money
}