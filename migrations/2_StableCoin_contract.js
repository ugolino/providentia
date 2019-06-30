var DaiToken = artifacts.require("./DaiToken");

module.exports = (deployer, network, [owner]) => deployer
  .then(() => deployToken(deployer))

function deployToken(deployer){
  return deployer.deploy(
      DaiToken,
      100000000,
      "DaiStableCoin",
      16,
      "DAI"
    );
}
