

NFT Template for Poly using OpenZepplin Contract 5.x - REC-721

# Basic ERC-721 Smart Contract for Ploygon's mainnet or Polygon Amoy Testnet




<img width="1280" height="640" alt="1" src="https://github.com/user-attachments/assets/41d899a1-1588-4914-856f-19f2c2bd137f" />










---

## Contract

Main contract file:

```text
contracts/BullBrewNFT.sol
```
# Description: 
This project contains a Polygon-ready ERC-721 NFT smart contract for the "Bull Brew NFT collection" (feel free to use your own designations in this template).
The contract uses OpenZeppelin’s ERC-721 standard and is designed for deployment on Polygon Mainnet or Polygon Amoy Testnet.

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




# Deploy NFT Collections to Polygon in Minutes

Production-ready ERC721 NFT contract built with OpenZeppelin and Hardhat.

## Features

- Public minting
- Owner minting
- Adjustable mint price
- Custom metadata URI support
- Max supply enforcement
- Withdrawal of mint proceeds
- OpenZeppelin security standards
- Polygon Amoy support
- Polygon Mainnet support

## Install

```bash
npm install
```

## Compile

```bash
npx hardhat compile
```

## Deploy to Polygon Amoy

```bash
npx hardhat run scripts/deploy.js --network amoy
```

## Deploy to Polygon Mainnet

```bash
npx hardhat run scripts/deploy.js --network polygon
```

## Contract Settings (You Must customize your own) 

Collection Name:
TheBullBrewCollection

Symbol:
BRW

Maximum Supply:
1000 NFTs

Mint Price:
0.01 POL

## Security

Never commit your .env file.
Never share your private key.
Always test on Polygon Amoy before deploying to mainnet.



















