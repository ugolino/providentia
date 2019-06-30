
const Providentia = artifacts.require('./Providentia.sol');
const StudentToken = artifacts.require("./StudentToken");
var BigNumber = require('bignumber.js')

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

  describe('Providentia.sol', function() {
    it('should add a Student ', async function() {
      await providentia.addStudent("Mark", "18", "Canada",
            "https://github.com/Solexplorer", "RandomUni", "");

      var name = await providentia.addressToData(accounts[0]);
      assert( name.name == "Mark");
    })
  })
})
