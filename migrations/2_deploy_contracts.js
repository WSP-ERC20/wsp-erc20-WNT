var WispNetworkToken = artifacts.require("./WispNetworkToken.sol");

module.exports = function(deployer) {
  deployer.deploy(WispNetworkToken);
};
