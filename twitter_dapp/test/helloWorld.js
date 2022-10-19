const TwitterdApp = artifacts.require("twitterdApp");

contract("twitterdApp", () => {
    it("Testing", async () => {
        const instance = await TwitterdApp.deployed();
        await instance.setMassage("Hello World");
        const message = await instance.message();
        assert (message === "Hello World");
    });

});