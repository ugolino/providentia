pragma solidity ^0.5.0;

import "./Ownable.sol";
import "./ERC20.sol";
import "./ERC1155MixedFungibleMintable.sol";
import "./TimeHelper.sol";


contract Providentia is Ownable, ERC20, ERC1155MixedFungibleMintable{
  using TimeHelper for uint;

    mapping( address => StudentData ) addressToData;
    mapping( address => StudentLoan) addressToLoan;
    // student balance
    mapping( address => uint) addressToBalance;
    mapping( address => bool ) studentHasLoan;
    //mapping( uint => uint)  // One NFT MUST have 100 FT attached
    // address =>( idNFT => idFT )
    mapping( address => mapping( uint => uint)) ownerToTypes;
    // idNFT => amountTokens
    mapping( address => mapping(uint => uint) ) tokensToValue;

    //TODO: Create the ERC1155 associated

    event studentCreated(
        string _name,
        uint8 _age,
        string _country,
        string _profAccount,
        string _university
        );

    struct StudentData{
        string name;
        uint8 age;
        string country;
        string university;
        string profAccount;
        uint idNFT;
    }

    struct StudentLoan{
        uint amountDAI;
        uint interestLoan;
        uint amountFunded;
        uint startDate;
        uint endDate;
        bool loanFunded;
    }

    struct FunderTokens{
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

    //Function used to upgrade the contract address of DAI in case it changes
    function setStableCoinAddress(address _addressCoin) public onlyOwner{
        stableCoinAddress = _addressCoin;
    }

    function addStudent(string memory _name,
                        uint8 _age,
                        string memory _country,
                        string memory _profAccount,
                        string memory _university,
                        string memory _uri
                        ) public {

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

        emit studentCreated(_name, _age, _country, _profAccount, _university);
    }

    function requestLoan(uint _amountDAI, uint _durationLoan, uint _interestLoan, uint _startDate, uint _endDate) public{
        require( addressToLoan[msg.sender].amountDAI == 0);
        addressToLoan[msg.sender] = StudentLoan(10000, _interestLoan, 0, _startDate, _endDate, false);
        Loans.push(StudentLoan(10000, _interestLoan, 0, _startDate, _endDate, false ));
    }

    function addMoneyPool(address _addressToFund) public {
      ERC20 stableCoinContract = ERC20(stableCoinAddress);
      uint tokenAmount = stableCoinContract.allowance(msg.sender, address(this));
      //2 different error handling for explaining the error
      require(tokenAmount > (addressToLoan[_addressToFund].amountDAI / 100) && ( tokenAmount % 100 ) == 0 );
      tokensToValue[msg.sender][addressToData[_addressToFund].idNFT] = tokenAmount / 100;
      Investors.push(FunderTokens(msg.sender, tokenAmount / 100, _addressToFund, addressToData[_addressToFund].idNFT));
      stableCoinContract.transferFrom(msg.sender, address(this), tokenAmount);
    }


    function withdrawLoan(uint _amount) public{
      require(_amount < addressToBalance[msg.sender] || addressToBalance[msg.sender] != 0);
      ERC20 stableCoinContract = ERC20(stableCoinAddress);
      stableCoinContract.transfer(msg.sender, _amount);
    }

    function releaseTokens(address _addressFunded) public onlyOwner{

      //Best to loop Investors array
// check user has 10K
        require( addressToBalance[_addressFunded] == 10000);
        //Check user has at least one token
        uint amountStake = tokensToValue[msg.sender][addressToData[_addressFunded].idNFT];
        require( amountStake != 0);

        _token.safeTransferFrom(address(this), msg.sender, ownerToTypes[msg.sender][addressToData[_addressFunded].idNFT], amountStake, "onERC1155Received" );
    }


    //First you need to call an approve transaction
    function repayLoan() public{
        require(studentHasLoan[msg.sender] == true, "This address doesn't have a loan associated");
        ERC20 stableCoinContract = ERC20(stableCoinAddress);
        uint tokenAmount = stableCoinContract.allowance(msg.sender, address(this));
        bool isTransferred = stableCoinContract.transferFrom(msg.sender, address(this), tokenAmount);

    }




}
