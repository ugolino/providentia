
const Providentia = artifacts.require('./Providentia.sol');
const StudentToken = artifacts.require("./StudentToken");
var BigNumber = require('bignumber.js')
const truffleAssert = require('truffle-assertions');

contract('Token', async function(accounts) {
  let token

  before(done => {
    ;
    (async () => {
      try {
        var totalGas = new BigNumber(0)

        // Deploy StudentToken.sol
        tokenERC1155 = await StudentToken.new()
        var tx = await web3.eth.getTransactionReceipt(tokenERC1155.transactionHash)
        totalGas = totalGas.plus(tx.gasUsed)
        tokenERC1155 = await StudentToken.deployed()
        //console.log(_ + tx.gasUsed + ' - Deploy tokenERC20')
        totalGas = totalGas.plus(tx.gasUsed)
        providentia = await Providentia.new("0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359", tokenERC1155.address);
        var tx = await web3.eth.getTransactionReceipt(providentia.transactionHash)
        totalGas = totalGas.plus(tx.gasUsed)
        providentia = await Providentia.deployed();
        //console.log(_ + tx.gasUsed + ' - Deploy tokenERC20')

        //console.log(msg.sender)
        done()
      } catch (error) {
        console.error(error)
        done(false)
      }
    })()
  })

  describe('addStudent', function() {
    it('should add a Student ', async function() {
      await providentia.addStudent("Mark", 18, "Canada",
            "https://github.com/Solexplorer", "RandomUni", "");

      var personalData = await providentia.addressToData(accounts[0]);
      assert( personalData.name == "Mark");
    })
    it("shouldn't create a Student", async function(){

      await truffleAssert.reverts(
        providentia.addStudent("Rob", 18, "France",
        "https://github.com/Ugolino", "NewUni", "", {from: accounts[0]}),
        "An address can only have one Student associated"
      )


    })

    })

    describe('requestLoan', function() {
      it('should request a Loan', async function() {
        await providentia.requestLoan(4);

        var loan = await providentia.addressToLoan(accounts[0]);
        assert(loan.amountDAI == "50000");

      })
    it('should not create a loan request', async function() {

      //Try to request a loan with an address not registered

      await truffleAssert.reverts(
         providentia.requestLoan(4, { from: accounts[1]}), "Student hasn't been added yet"
      )

      //Try to request a Loan with an address that has already requesteed the loan
      await truffleAssert .reverts(
         providentia.requestLoan(4, {from: accounts[0]}),
         "User has already initiated a Loan process"
      )


    })
    })

  /*describe('acceptLoan', function() {
    it('should'n let the student accept the loan', async function() {

      await providentia.acceptLoan({from: accounts[0]});
    })*/
})