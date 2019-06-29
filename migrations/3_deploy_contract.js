var Providentia = artifacts.require("./Providentia");
var StudentToken = artifacts.require("./StudentToken.sol");

module.exports = (deployer, network, [owner]) => deployer
  .then(() => deployMarketplace(deployer))

function deployMarketplace(deployer){
  return deployer.deploy(
      Providentia,
      "0x89d24a6b4ccb1b6faa2625fe562bdd9a23260359",
      StudentToken.address,
    );
}
