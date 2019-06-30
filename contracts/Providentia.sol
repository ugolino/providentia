pragma solidity ^0.5.0;

import "./Ownable.sol";
import "./ERC20.sol";
import "./ERC1155MixedFungibleMintable.sol";
import "./TimeHelper.sol";

/**
    @title Providentia, providing students with loan
    @dev See { insert website }
    Note: Some values are hardcoded in order to represent a specific usecase
 */

contract Providentia is Ownable, ERC20, ERC1155MixedFungibleMintable{
  // @dev Library used to calculate time differences
  using BokkyPooBahsDateTimeLibrary for uint;

    // @dev Mapping used to store user data
    mapping( address => StudentData ) addressToData;
    // @dev Mappiing used to store the details of the Loan
    mapping( address => StudentLoan) addressToLoan;
    // @dev Mapping used to track the Loan of the student
    mapping( address => uint) addressToBalance;
    // @dev Mapping used to track the interest paid by the student
    mapping( address => uint) studentToInterest;
    // @dev Mapping to know if the user has an outstanding loan
    mapping( address => bool ) studentHasLoan;
    // @dev address =>( idNFT => idFT )
    mapping( address => mapping( uint => uint)) ownerToTypes;
    // idNFT => amountTokens
    // note: One NFT MUST have 100 FT attached, no more no less
    mapping( address => mapping(uint => uint) ) tokensToValue;

        /***********************************|
        |        Variables and Events       |
        |__________________________________*/

    event studentCreated (
        string _name,
        uint8 _age,
        string _country,
        string _profAccount,
        string _university
        );

    struct StudentData {
        string name;
        uint8 age;
        string country;
        string university;
        string profAccount;
        uint idNFT;
    }

    struct StudentLoan {
        uint amountDAI;
        uint interestLoan;
        uint amountFunded;
        uint startDate;
        uint endDate;
        bool loanFunded;
        bool loanAccepted;
    }

    struct FunderTokens {
      address _addressFunder;
      uint _amount;
      address _addressFunded;
      uint idNFT;
    }

    StudentLoan[] Loans;
    StudentData[] Datas;
    FunderTokens[] Investors;

    address[] sendTokens = [address(this)];

    uint[] valueSend = [100];

    address stableCoinAddress ;

    ERC1155MixedFungibleMintable _token;

    constructor(address _stableCoinAddress, ERC1155MixedFungibleMintable _tokenIERC1155) public{
        stableCoinAddress = _stableCoinAddress;
        _token = _tokenIERC1155;
    }

    /** @notice Function used to upgrade the contract address of DAI in case it changes
        @param _addressCoin Address of the StableCoin Contract
    */
    function setStableCoinAddress(address _addressCoin) public onlyOwner{
        stableCoinAddress = _addressCoin;
    }

    /**
      @notice Function used to add the Student
      @param _name Name of the Student
      @param _age Age of the Student
      @param _country Country of the Student
      @param _profAccount Github account of the Student
      @param _university University in which the Student is attending to
      @param _uri Used to store the JSON with the data of the Student
    */
    function addStudent(
      string memory _name,
      uint8 _age,
      string memory _country,
      string memory _profAccount,
      string memory _university,
      string memory _uri
    )
      public
    {

        require(bytes(addressToData[msg.sender].name).length == 0,
        "An address can only have one Student associated");



        uint _type = _token.create(_uri, true);
        _token.mintNonFungible(_type, sendTokens);
        uint _id = _token.create(_uri, false);
        _token.mintFungible(_id, sendTokens, valueSend );

        addressToData[msg.sender] = StudentData(_name, _age, _country, _university,
        _profAccount, _type);
        Datas.push(StudentData(_name, _age, _country, _university, _profAccount, _type));
        ownerToTypes[msg.sender][_type] = _id;

        emit studentCreated(
          _name,
          _age,
          _country,
          _profAccount,
          _university
          );
    }

    // TODO: Check loan has been funded and complete the flag
    function requestLoan(uint _amountDAI, uint _durationLoan, uint _interestLoan, uint _endDate) public{
        require( addressToLoan[msg.sender].amountDAI == 0);
        addressToLoan[msg.sender] = StudentLoan(50000, _interestLoan, 0, now, now.addYears(5), false, false);
        Loans.push(StudentLoan(50000, _interestLoan, 0, now, now.addYears(5), false, false ));
    }

    // Check maximum amount is 100 tokens
    function addMoneyPool(address _addressToFund) public {
      ERC20 stableCoinContract = ERC20(stableCoinAddress);
      uint tokenAmount = stableCoinContract.allowance(msg.sender, address(this));
      //2 different error handling for explaining the error
      require(tokenAmount > (addressToLoan[_addressToFund].amountDAI / 500) && ( tokenAmount % 500 ) == 0 );
      tokensToValue[msg.sender][addressToData[_addressToFund].idNFT] = tokenAmount / 500;
      Investors.push(FunderTokens(msg.sender, tokenAmount / 500, _addressToFund, addressToData[_addressToFund].idNFT));
      stableCoinContract.transferFrom(msg.sender, address(this), tokenAmount);
    }


    function withdrawLoan(uint _amount) public{
      require(_amount < addressToBalance[msg.sender] || addressToBalance[msg.sender] != 0);
      ERC20 stableCoinContract = ERC20(stableCoinAddress);
      //User can take only 20% each year

      stableCoinContract.transfer(msg.sender, _amount);
    }

    function acceptLoan() public{
      require(addressToLoan[msg.sender].loanFunded == true);
      addressToLoan[msg.sender].loanAccepted = true;
    }

    function releaseTokens(address _addressFunded) public onlyOwner{

      //Best to loop Investors array
// check user has 50K
        require( addressToBalance[_addressFunded] == 50000);
        //Check user has at least one token
        uint amountStake = tokensToValue[msg.sender][addressToData[_addressFunded].idNFT];
        require( amountStake != 0);

        _token.safeTransferFrom(address(this), msg.sender, ownerToTypes[msg.sender][addressToData[_addressFunded].idNFT], amountStake, "onERC1155Received" );
    }


    //First you need to call an approve transaction
    //Check the logic here as it's a bit flawed
    function repayLoan() public{
        require(studentHasLoan[msg.sender] == true, "This address doesn't have a loan associated");
        ERC20 stableCoinContract = ERC20(stableCoinAddress);
        uint tokenAmount = stableCoinContract.allowance(msg.sender, address(this));
        bool isTransferred = stableCoinContract.transferFrom(msg.sender, address(this), tokenAmount);
        require(isTransferred == true, "Error transferring the tokens");
        //Calculate Interest matured

        uint _interest = ( 50000  * (addressToLoan[msg.sender].interestLoan * 100) * now.diffDays(addressToLoan[msg.sender].startDate) ) / 36500;
        addressToBalance[msg.sender] -= tokenAmount - _interest;
        studentToInterest[msg.sender] += _interest;

    }

    function withdrawRepaidLoan(address _addressFunded) public{
        for(uint i = 0; i<Investors.length; i++){
          if(Investors[i]._addressFunded == _addressFunded){
            uint _tokenAmount = tokensToValue[msg.sender][Investors[i].idNFT];
            uint share = (addressToBalance[_addressFunded] + studentToInterest[_addressFunded]) * _tokenAmount/100;
            ERC20 stableCoinContract = ERC20(stableCoinAddress);
            stableCoinContract.transfer(msg.sender, share);
          }
        }
    }




}
