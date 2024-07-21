// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleWallet {
   
    address public owner;
    string public str;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"You don't have access");
        _;
    }
   
    /**Contract related functions**/
    function transferToContract() external payable  {
       str="Amount transferred to the contract";
    }

    function transferToUserViaContract(address payable _to, uint _weiAmount) external onlyOwner {
        require(address(this).balance>=_weiAmount,"Insufficient Balance");
        _to.transfer(_weiAmount);
    }

    function withdrawFromContract(uint _weiAmount) external onlyOwner {
       require(address(this).balance >= _weiAmount, "Insuffficient balance");
       payable (owner).transfer(_weiAmount);
    }

    function getContractBalanceInWei() external view returns (uint) {
         return address(this).balance; //msg.sender Contract balance
    }
   
     /**User related functions**/
    function transferToUserViaMsgValue(address payable  _to) external payable {
       require(address(this).balance>=msg.value,"Insufficient Balance");
       _to.transfer(msg.value);
    }

    function receiveFromUser() external payable  {
        require(msg.value > 0, "Wei amount must be greater than 0");
        payable (owner).transfer(msg.value);
    }

    function getOwnerBalanceInWei() external view returns(uint){
       return owner.balance;
    }

    receive() external payable {
       
    }

    fallback() external payable {
       
    }
}
