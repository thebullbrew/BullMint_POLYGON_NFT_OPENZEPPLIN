# BullMint_POLYGON_NFT_OPENZEPPLIN
NFT Template for Poly using OpenZepplin Contract 5.x - REC-721

# @thebullbrew Poly NFT — Polygon ERC-721 Smart Contract

This repository contains a Polygon-ready ERC-721 NFT smart contract for the Bull Brew NFT collection.
The contract uses OpenZeppelin’s ERC-721 standard and is designed for deployment on Polygon Mainnet or Polygon Amoy Testnet.


<img width="1280" height="640" alt="1" src="https://github.com/user-attachments/assets/41d899a1-1588-4914-856f-19f2c2bd137f" />



<img width="1280" height="640" alt="2" src="https://github.com/user-attachments/assets/4aa07ac0-cc79-44e8-a4c0-a66b15587f38" />








---

## Contract

Main contract file:

```text
contracts/BullBrewNFT.sol
```




# What This Contract Does:

The contract allows:
* Public minting when the owner opens minting
* Owner-only minting
* Custom metadata URI for each NFT
* Adjustable mint price
* Withdrawal of mint proceeds by the owner
* Total minted supply tracking

Requirements

# Install the following: 

* Node.js
* Git
* MetaMask wallet
* MATIC test tokens for Polygon Amoy
* Hardhat
* OpenZeppelin Contracts


# Setup Instructions:

# 1) Clone the repository:

git clone YOUR_REPOSITORY_URL
cd template_NFT_polygon_network


# 2) Install dependencies:

npm install


# 3) Install Hardhat:

npm install --save-dev hardhat


# 4) Install OpenZeppelin:

npm install @openzeppelin/contracts


# 5) Create a Hardhat project:

npx hardhat init


# 6) Choose:

Create a JavaScript project


# 7) Deployment Script:

Create this file:
scripts/deploy.js



# 8) Paste:

const hre = require("hardhat");

async function main() {
  const BullBrewNFT = await hre.ethers.getContractFactory("BullBrewNFT");

  const contract = await BullBrewNFT.deploy();

  await contract.waitForDeployment();

  console.log("BullBrewNFT deployed to:", await contract.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


# 9) Hardhat Config:

In:

hardhat.config.js


Use:

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: "0.8.24",
  networks: {
    amoy: {
      url: process.env.POLYGON_AMOY_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
    polygon: {
      url: process.env.POLYGON_MAINNET_RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};



# 10) Install required packages:

npm install --save-dev @nomicfoundation/hardhat-toolbox dotenv


# 11) Environment Variables:

Create a file named:
.env


# 12) Add:

PRIVATE_KEY=your_wallet_private_key_here
POLYGON_AMOY_RPC_URL=your_polygon_amoy_rpc_url_here
POLYGON_MAINNET_RPC_URL=your_polygon_mainnet_rpc_url_here

(Important: never upload your .env file to GitHub.)


# 13) Create a .gitignore file and add:

node_modules
.env
artifacts
cache


# 14) Compile the Contract:

Run:
npx hardhat compile


# 15) Deploy to Polygon Amoy Testnet:

Run:
npx hardhat run scripts/deploy.js --network amoy


# 16) Deploy to Polygon Mainnet:

Note: only deploy to mainnet after testing.

npx hardhat run scripts/deploy.js --network polygon

After Deployment:
Copy the contract address.


# You can use it to:

* View the contract on PolygonScan
* Verify the contract
* Mint NFTs
* Connect it to a minting website
* Add metadata through IPFS
* List NFTs on OpenSea



# Security Notes:

- Do not share your private key.
- Do not commit .env to GitHub.
- Test on Polygon Amoy before deploying to mainnet.
- Use a fresh wallet for development when possible.














