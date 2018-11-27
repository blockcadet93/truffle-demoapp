pragma solidity 0.4.24;

contract DigitalIdentity {

    //to do: 
    //1. getinfo only partners, user
    //2. school name => address => send notification (Gov. ids)
    //3. mapping inside educ
    //4. self update visible private
    
    struct userDetails {
        string name;
        string gender;
        uint dob;
        
        //updatable information
        string home_address;
    }
    
    struct educationalBackground {
        string sch_name;
        uint yr;
        string course;
        bool status;
    }

    address acctOwner;

    mapping(address => userDetails) uInfo;
    
    mapping(address => educationalBackground) educBackground;
    
    function setInfo(address _userAddress, 
                    string _name, 
                    string _gender, 
                    uint _dob, 
                    string _home_address, 
                    string _sch_name,
                    uint _yr,
                    string _course) public {
                        
        acctOwner = _userAddress;
        
        userDetails memory newUserDetails = uInfo[_userAddress]; 
        // fixed info
        newUserDetails.name = _name;
        newUserDetails.gender = _gender;
        newUserDetails.dob = _dob;
        // updatable
        newUserDetails.home_address = _home_address;
        
        educationalBackground memory newEducationalBackground = educBackground[_userAddress];
        newEducationalBackground.sch_name = _sch_name;
        newEducationalBackground.yr = _yr;
        newEducationalBackground.course = _course;
        
        uInfo[_userAddress] = newUserDetails;
        educBackground[_userAddress] = newEducationalBackground;
    }
    
    
    
    function getInfo(address _userAddress) public view returns(string, string, uint, string, string, string, bool) {
        //require(uInfo[_userAddress].status == true, "User Unverified");
        
        return (uInfo[_userAddress].name,
                uInfo[_userAddress].gender,
                uInfo[_userAddress].dob,
                uInfo[_userAddress].home_address,
                educBackground[_userAddress].sch_name,
                educBackground[_userAddress].course,
                educBackground[_userAddress].status
                );
    }
    
    function updateInfo(string _home_address) public {
        
        userDetails memory newUserDetails = uInfo[acctOwner]; 
        newUserDetails.home_address = _home_address;
        
        uInfo[acctOwner] = newUserDetails;
    }
    
    function userVerify() public {
        educationalBackground memory newEducationalBackground = educBackground[acctOwner];
        
        newEducationalBackground.status = true;
        educBackground[acctOwner] = newEducationalBackground;
    }
}