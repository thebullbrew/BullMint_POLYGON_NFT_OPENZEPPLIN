

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




# Deploy NFT Collections to Polygon in Minutes assuming all your dependencies are installed and configured properly:

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

# The Basics - Quick & Dirty:
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

## Contract Settings (At this point you will see your own contract settings - hopefully that's what you did.)

Collection Name:
TheBullBrewCollection

Symbol:
BRW

Maximum Supply:
1000 NFTs

Mint Price:
0.01 POL

## Security:

Never commit your .env file.
Never share your private key.
Always test on Polygon Amoy before deploying to mainnet.

## LEGAL DISCLAIMER:

This content is provided solely for educational and technical purposes - to discuss software development, blockchain infrastructure, and related programming concepts.
Digital assets, smart contracts, wallets, private keys, and blockchain transactions involve material risk. 
Transactions may be irreversible, code may contain vulnerabilities, and improper implementation or execution may result in the permanent loss of funds or digital assets.
You are solely responsible for conducting your own due diligence, reviewing and testing any code, securing your credentials, understanding the applicable risks, and verifying all transactions before execution. Any use, deployment, modification, or reliance on this content is undertaken at your own risk.
I make no representations or warranties regarding the accuracy, completeness, security, functionality, or suitability of any code, information, or material provided. I disclaim all liability for any losses, damages, failed transactions, software defects, security breaches, wallet compromises, or other consequences arising from the use of this content.

Nothing herein constitutes financial, investment, legal, tax, accounting, securities, or cybersecurity advice, nor does it constitute an offer, solicitation, recommendation, or endorsement to buy, sell, hold, or transact in any digital asset, security, or financial instrument.

















