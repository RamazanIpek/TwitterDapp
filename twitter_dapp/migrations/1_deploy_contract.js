const twitterdAppDeploy = artifacts.require("twitterdApp");

module.exports = function(deployer) {
  deployer.deploy(twitterdAppDeploy);
}