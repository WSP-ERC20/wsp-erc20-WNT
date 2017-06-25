var WispNetworkToken = artifacts.require("./WispNetworkToken.sol");
//var WispAsset = artifacts.require("./WispAsset.sol");

module.exports = function(deployer) {
  deployer.deploy(WispNetworkToken);
//  deployer.deploy(WispAsset);
};
