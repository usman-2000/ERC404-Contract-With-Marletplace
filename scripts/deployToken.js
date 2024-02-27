const { ethers } = require("hardhat");
const fs = require("fs");

async function main() {
  const [deployer] = await ethers.getSigners();
  const name = "USMAN RAHIM KASHMIRI";
  const symbol = "URK";
  const maxSupply = ethers.parseEther("50");
  const initialTokenSupply = ethers.parseEther("0");
  const publicPrice = ethers.parseEther("0")
  const signer = deployer.address;

  const argumentsArray = [
    name,
    symbol,
    maxSupply.toString(),
    publicPrice.toString(),
    initialTokenSupply.toString(),
    signer,
  ];
  const content =
    "module.exports = " + JSON.stringify(argumentsArray, null, 2) + ";";

  fs.writeFileSync("./arguments.js", content);

  console.log("arguments.js file generated successfully.");

  console.log("Deploying contracts with the account:", deployer.address);

  const Token = await ethers.getContractFactory("NFTMintDN404");
  const token = await Token.deploy(
    name,
    symbol,
    maxSupply,
    publicPrice,
    initialTokenSupply,
    signer
  );
  console.log("Fractionalized NFT deployed to:", await token.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });
