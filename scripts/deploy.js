const hre = require("hardhat");

async function main() {
  const CONTRACT_NAME = "BullBrewNFT";

  // ============================
  // COLLECTION CONFIG
  // ============================
  const COLLECTION_NAME = "TheBullBrewCollection";
  const SYMBOL = "BRW";

  const MAX_SUPPLY = 1000;
  const RESERVED_SUPPLY = 50;

  // 0.01 POL mint price
  const MINT_PRICE = hre.ethers.parseEther("0.01");

  // max public mints per wallet
  const MAX_MINT_PER_WALLET = 3;

  // IMPORTANT:
  // Replace this with your actual metadata folder URI
  // Example: ipfs://bafybeixxxxxxxxxxxxxxxxxxxxxxxxxxxxx/
  const BASE_URI = "ipfs://YOUR_METADATA_CID/";

  // Royalty config
  // 2000 = 20%
  const ROYALTY_RECEIVER = process.env.ROYALTY_RECEIVER || process.env.DEPLOYER_ADDRESS;
  const ROYALTY_FEE_NUMERATOR = 2000;

  const NFT = await hre.ethers.getContractFactory(CONTRACT_NAME);

  const nft = await NFT.deploy(
    COLLECTION_NAME,
    SYMBOL,
    MAX_SUPPLY,
    RESERVED_SUPPLY,
    MINT_PRICE,
    MAX_MINT_PER_WALLET,
    BASE_URI,
    ROYALTY_RECEIVER,
    ROYALTY_FEE_NUMERATOR
  );

  await nft.waitForDeployment();

  const contractAddress = await nft.getAddress();

  console.log("======================================");
  console.log("BullBrewNFT deployed successfully");
  console.log("Network:", hre.network.name);
  console.log("Contract address:", contractAddress);
  console.log("Collection:", COLLECTION_NAME);
  console.log("Symbol:", SYMBOL);
  console.log("Max supply:", MAX_SUPPLY.toString());
  console.log("Reserved supply:", RESERVED_SUPPLY.toString());
  console.log("Mint price:", hre.ethers.formatEther(MINT_PRICE), "POL");
  console.log("Max mint per wallet:", MAX_MINT_PER_WALLET.toString());
  console.log("Base URI:", BASE_URI);
  console.log("Royalty receiver:", ROYALTY_RECEIVER);
  console.log("Royalty bps:", ROYALTY_FEE_NUMERATOR.toString());
  console.log("======================================");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
