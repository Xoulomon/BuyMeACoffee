// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Xoulomon
contract BuyMeACoffe {
     // Event to emit  when a memo is created
     event newMemo(
        address indexed from,
        uint timestamp,
        string name,
        string message
     );

    // Memo struct
     struct Memo {
        address from;
        uint timestamp;
        string name;
        string message;
     }

    // Array of memos received
     Memo[] memos;

    //Address of deployer
     address payable owner;

    //Constructor login
     constructor(){
        owner = payable(msg.sender);
     }

    /**
    * @dev function to buy Coffe for contract owner
    * @param _name name of who bought coffe
    * @param _message message of coffe buyer 
    */
    function buyCoffe(string memory _name, string memory _message)  public payable {
        require(msg.value > 0,"Donation can not be 0 eth");
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
         ));

         emit newMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
         );
    }

    /**
    * @dev function to withdraw tips to contract owner account
    */
    function withdrawTips() public{
        require(msg.sender == owner, "Caller of function is not owner");
        owner.transfer(address(this).balance);
    }

    /**
    * @dev function to get list of all memos 
    */
    function getMemos() public view returns(Memo[] memory){
        return memos;
    }

    /**
    * @dev function to get the total of tips in the contract
    */
    function getTipsBalance() public view returns(uint){
        return address(this).balance;
    }

   /**
    * @dev function to change owner so a different address can withdraw tips
    * @param _addr new address assigned to owner
    */
    function changeOwner(address _addr) external{
        require(msg.sender == owner, "Caller of function is not owner");
        owner = payable(_addr);
    }
}
