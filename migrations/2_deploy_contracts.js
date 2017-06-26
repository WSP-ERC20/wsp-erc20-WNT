var WispNetworkToken = artifacts.require("./WispNetworkToken.sol");
var GoldWispGenerator = artifacts.require("./GoldWispGenerator.sol");

module.exports = function(deployer) {
  deployer.deploy(WispNetworkToken);
  deployer.deploy(GoldWispGenerator);
};
