
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract user_Admin{
    address public admin;
    struct User{
        uint aadhar;
        string name;
        uint age;
        address wallet;
    }
    mapping (address=>User) users;

    constructor(){
        admin = msg.sender;
    }
    modifier onlyAdmin(){
        require(msg.sender == admin,"Only admin can call this function");
        _;
    }
    function addUser(address userAddress,string memory name,uint age,uint aadhar) public onlyAdmin{
        require(aadhar >= 1e11 && aadhar < 1e12, "Aadhar number must be a 12-digit number");
        User memory newUser= User({
            aadhar : aadhar,
            name : name,
            age : age,
            wallet : userAddress
        });
        users[userAddress] = newUser;
    }
    function getUser() public view returns (string memory,uint,uint,address) {
        User storage user = users[msg.sender];
        if (bytes(user.name).length == 0){
            return("UserInfo not fount",0,0,address(0));
        }else{
            return (user.name,user.aadhar,user.age,user.wallet);
        }
        
    }
}