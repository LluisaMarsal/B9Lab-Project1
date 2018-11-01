var ConvertLib = artifacts.require("./ConvertLib.sol");
var Splitter = artifacts.require("./Splitter.sol");
var Robust0a = artifacts.require("./Robust0a.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, Splitter);
  deployer.deploy(Splitter);
  deployer.link(ConvertLib, Robust0a);
  deployer.deploy(Robust0a);
};
