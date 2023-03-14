pragma solidity >=0.7 <0.9.0;

contract Upload{
    //0xqwerty
    struct Access{
        address user;
        bool access; //true or false
    }



    // OWNERSHIP OF THE USER
    mapping(address=> string[]) value;
    mapping(address=> mapping(address => bool)) ownership;
    mapping(address => Access[]) accessList;
    mapping(address => mapping(address => bool)) previousData;
    
    function add(address _user,string memory url) external {
        value[_user].push(url);
    }
    function allow(address user) external { //def
        ownership[msg.sender][user] = true;
        if(previousData[msg.sender][user]){
            for(uint i = 0 ; i<accessList[msg.sender].length; i++){
                if(accessList[msg.sender][i].user == user){
                    accessList[msg.sender][i].access = true;
                }
            }
        }else{
            accessList[msg.sender].push(Access(user,true));  //def.access = true
            previousData[msg.sender][user] =true; //true
        }

    }
    function disallow(address user) public{
        ownership[msg.sender][user] = false;
        for(uint i = 0 ;i<accessList[msg.sender].length;i++){
            if(accessList[msg.sender][i].user == user){  //0xdef -false
                accessList[msg.sender][i].access = false; // def.access = false
                
            }
        }

    }
    function display(address _user) external view returns(string[] memory){
        require(_user ==msg.sender || ownership[_user][msg.sender],"You don't have access");
        return value[_user];
    }
    function shareAccess() public view returns(Access[] memory){
        return accessList[msg.sender];
    }

}
