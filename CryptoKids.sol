// SPDX-License-Identifier: Unlicensed
pragma solidity >=0.4.16 <0.9.0;


contract CryptoKids {
    // Owner DAD
    address owner_dad_address;

    event kidsFundingRecieved(address addr, uint amount, uint contractBalance);

    constructor() {
        // Person who is making transaction in this smart contract will be the owner of this smart contract
        owner_dad_address = msg.sender;
    }

    // Define Kids
    struct Kid {
        address payable WalletAddress;
        string firstName;
        string lastName;
        uint releaseTime;
        uint amount;
        bool canWithdraw;
    }

    // Array of struct of kids
    Kid[] public kids;


    // Add kids to contract
    function addKid (address payable WalletAddress,string memory firstName, string memory lastName, uint releaseTime,uint amount, bool canWithdraw) public {
        kids.push(Kid(
            WalletAddress,
            firstName,
            lastName,
            releaseTime,
            amount,
            canWithdraw
        ));
    }

    //Balance
    function balanceOf() public view returns (uint) {
        return address(this).balance;
    }

    // Deposit funds to contract, specially for a kid's contract
    function deposit (address WalletAddress) payable public {
        addToKidsBalance(WalletAddress);
    }

    function addToKidsBalance(address walletAddress) private {
        // Only owner can add kids, not any random person
        require(msg.sender == owner_dad_address, "Only the owner can add kids.");

        for (uint i = 0; i < kids.length; i++) {
            if(kids[i].WalletAddress == walletAddress) {
                kids[i].amount += msg.value;
                emit kidsFundingRecieved(walletAddress, msg.value, balanceOf());
            }
        }
    }

    // Get index of the kid
    function getIndex(address walletAddress) private view returns(uint) {
        for (uint i = 0 ; i < kids.length; i++) {
            if(kids[i].WalletAddress == walletAddress) {
                return i;
            }
        }
        return 0;
    }

    // Kid checks if he/she can withdraw money
    // Money can be withdrawn when current epoch time > releaseTime
    function availabeToWithdraw (address walletAddress) public returns(bool) {
        uint index = getIndex(walletAddress);
        require(block.timestamp > kids[index].releaseTime, "You are not able to withdraw at this time.");
        if(block.timestamp > kids[index].releaseTime) {
            kids[index].canWithdraw = true;
            return true;
        } else {
            return false;
        }
    }

    // Withdraw money
    function withdraw(address payable walletAddress) payable public {
        uint index = getIndex(walletAddress);
        require(msg.sender == kids[index].WalletAddress, "You must be the kid to withdraw");
        require(kids[index].canWithdraw == true, "You are not able to withdraw at this time.");
        kids[index].WalletAddress.transfer(kids[index].amount);
    }
}