


NFT Template for Poly using OpenZepplin Contract 5.x - REC-721

# Basic ERC-721 Smart Contract for Ploygon's mainnet or Polygon Amoy Testnet


<img width="1280" height="640" alt="GITHUB  BULLMINT NFTS_POLYGON" src="https://github.com/user-attachments/assets/612320b3-4c89-4ccf-b7ee-88a1e2a4463b" />












---


## Contract

Main contract file:

```text
contracts/BullBrewNFT.sol
```
# Description: 
Production-ready ERC-721 NFT collection for Polygon using Hardhat + OpenZeppelin.

# What This Contract Does:

The contract allows:
* Public minting when the owner opens minting
* Owner-only minting
* Custom metadata URI for each NFT
* Adjustable mint price
* Withdrawal of mint proceeds by the owner
* Total minted supply tracking


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

- ERC-721 NFT contract
- ERC-2981 royalty support
- Public mint with owner-controlled toggle
- Reserved supply for team / treasury / founder allocation
- Per-wallet mint limit
- Base URI metadata system
- Owner mint function
- Withdraw contract funds
- Polygon Amoy + Polygon Mainnet deployment support


# BREAKDOWN:

Collection name: TheBullBrewCollection

Symbol: BRW

Network: Polygon (Amoy testnet + Polygon mainnet)

Max supply: 1000

Reserved for owner/team: 50

Public supply: 950

Wallet limit: 3

Public mint: enabled by owner toggle

Royalty support: included via ERC-2981

Metadata: base URI model (better than passing a token URI on every mint)

Type: membership/pass NFT collection

# The Basics - Quick & Dirty:
## Install

```bash
npm install
```


## Configure Environment Variables

```bash
PRIVATE_KEY=YOUR_WALLET_PRIVATE_KEY
POLYGON_AMOY_RPC_URL=YOUR_AMOY_RPC_URL
POLYGON_MAINNET_RPC_URL=YOUR_POLYGON_MAINNET_RPC_URL
DEPLOYER_ADDRESS=YOUR_WALLET_ADDRESS
ROYALTY_RECEIVER=YOUR_ROYALTY_WALLET_ADDRESS
```

## Compile

```bash
npm run compile
```

## Deploy to Polygon Amoy

```bash
npm run deploy:amoy
```

## Deploy to Polygon Mainnet

```bash
npm run deploy:polygon
```


## Metadata format


```bash
The contract uses a base URI pattern:
ipfs://YOUR_METADATA_CID/1.json
ipfs://YOUR_METADATA_CID/2.json
ipfs://YOUR_METADATA_CID/3.json
```

```bash
That means if your base URI is: 
ipfs://bafybeixxxxxxxxxxxxxxxxxxxxxxxxxxxxx/

then token metadata resolves as:
ipfs://bafybeixxxxxxxxxxxxxxxxxxxxxxxxxxxxx/1.json
ipfs://bafybeixxxxxxxxxxxxxxxxxxxxxxxxxxxxx/2.json
ipfs://bafybeixxxxxxxxxxxxxxxxxxxxxxxxxxxxx/3.json
```


# Notes
- Update the BASE_URI in scripts/deploy.js before deploying.
- Update royalty receiver if you want royalties sent to a different wallet.
- Public mint is disabled by default after deployment. Enable it by calling togglePublicMint(true) from the owner wallet.


## Security:

Never commit your .env file.
Never share your private key.
Always test on Polygon Amoy before deploying to mainnet.

## LEGAL DISCLAIMER:

Digital assets, smart contracts, wallets, private keys, and blockchain transactions involve material risk. 
Transactions may be irreversible, code may contain vulnerabilities, and improper implementation or execution may result in the permanent loss of funds or digital assets.
You are solely responsible for conducting your own due diligence, reviewing and testing any code, securing your credentials, understanding the applicable risks, and verifying all transactions before execution. Any use, deployment, modification, or reliance on this content is undertaken at your own risk.
I make no representations or warranties regarding the accuracy, completeness, security, functionality, or suitability of any code, information, or material provided. I disclaim all liability for any losses, damages, failed transactions, software defects, security breaches, wallet compromises, or other consequences arising from the use of this content.
This content is provided solely for educational and technical purposes - to discuss software development, blockchain infrastructure, and related programming concepts.

Nothing herein constitutes financial, investment, legal, tax, accounting, securities, or cybersecurity advice, nor does it constitute an offer, solicitation, recommendation, or endorsement to buy, sell, hold, or transact in any digital asset, security, or financial instrument.

















