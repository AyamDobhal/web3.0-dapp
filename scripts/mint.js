const { task } = require("hardhat/config");
const { getContract } = require("./helpers");

task("mint", "Mints from the mintNFT contract")
.addParam("address", "The address to receive a token")
.setAction(async function (taskArguments, hre) {
    const contract = await getContract("mintNFT", hre);
    const transactionResponse = await contract.mint(taskArguments.address, {
        gasLimit: 500_000,
    });
    console.log(`Transaction Hash: ${transactionResponse.hash}`);
});