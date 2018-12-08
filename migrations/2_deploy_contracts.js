var Asset = artifacts.require("Asset");
var AssetFactory = artifacts.require("AssetFactory");
var NameRegistry = artifacts.require("NameRegistry");

module.exports = function(deployer) {
  deployer.deploy(NameRegistry).then(function() {
    return deployer.deploy(AssetFactory, NameRegistry.address);
  });
};
