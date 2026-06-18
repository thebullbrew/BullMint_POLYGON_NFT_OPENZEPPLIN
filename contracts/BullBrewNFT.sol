
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract BullBrewNFT is ERC721URIStorage, Ownable, ReentrancyGuard {

    uint256 public mintPrice;
    uint256 public maxSupply;
    uint256 public totalMinted;

    bool public publicMintEnabled;

    constructor(
        string memory collectionName,
        string memory collectionSymbol,
        uint256 supplyLimit,
        uint256 initialMintPrice
    )
        ERC721(collectionName, collectionSymbol)
        Ownable(msg.sender)
    {
        maxSupply = supplyLimit;
        mintPrice = initialMintPrice;
    }

    modifier supplyAvailable() {
        require(
            totalMinted < maxSupply,
            "Max supply reached"
        );
        _;
    }

    function togglePublicMint(bool enabled)
        external
        onlyOwner
    {
        publicMintEnabled = enabled;
    }

    function updateMintPrice(uint256 newPrice)
        external
        onlyOwner
    {
        mintPrice = newPrice;
    }

    function publicMint(
        string memory metadataURI
    )
        external
        payable
        supplyAvailable
        nonReentrant
    {
        require(
            publicMintEnabled,
            "Public mint disabled"
        );

        require(
            msg.value >= mintPrice,
            "Insufficient payment"
        );

        uint256 tokenId = totalMinted + 1;

        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, metadataURI);

        totalMinted++;
    }

    function ownerMint(
        address recipient,
        string memory metadataURI
    )
        external
        onlyOwner
        supplyAvailable
    {
        uint256 tokenId = totalMinted + 1;

        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, metadataURI);

        totalMinted++;
    }

    function withdraw()
        external
        onlyOwner
        nonReentrant
    {
        uint256 balance = address(this).balance;

        require(balance > 0, "No funds");

        (bool success, ) = payable(owner()).call{
            value: balance
        }("");

        require(success, "Withdraw failed");
    }

    function remainingSupply()
        external
        view
        returns (uint256)
    {
        return maxSupply - totalMinted;
    }
}



// scripts/deploy.js | Configured for your collection:


const hre = require("hardhat");

async function main() {

    const NFT = await hre.ethers.getContractFactory(
        "BullBrewNFT"
    );

    const nft = await NFT.deploy(
        "TheBullBrewCollection",
        "BRW",
        1000,
        hre.ethers.parseEther("0.01")
    );

    await nft.waitForDeployment();

    console.log(
        "Contract deployed to:",
        await nft.getAddress()
    );
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});


// hardhat.config.js

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {

    solidity: "0.8.24",

    networks: {

        amoy: {
            url: process.env.POLYGON_AMOY_RPC_URL,
            accounts: [process.env.PRIVATE_KEY]
        },

        polygon: {
            url: process.env.POLYGON_MAINNET_RPC_URL,
            accounts: [process.env.PRIVATE_KEY]
        }
    }
};


// .env


PRIVATE_KEY=

POLYGON_AMOY_RPC_URL=
POLYGON_MAINNET_RPC_URL=


// .gitignore

node_modules

.env

artifacts

cache


// package.json

{
  "name": "polygon-nft-template",
  "version": "1.0.0",
  "description": "Deploy NFT Collections to Polygon in Minutes",
  "scripts": {
    "compile": "hardhat compile",
    "deploy:testnet": "hardhat run scripts/deploy.js --network amoy",
    "deploy:mainnet": "hardhat run scripts/deploy.js --network polygon"
  },
  "dependencies": {
    "@openzeppelin/contracts": "^5.0.2"
  },
  "devDependencies": {
    "@nomicfoundation/hardhat-toolbox": "^5.0.0",
    "dotenv": "^16.4.5",
    "hardhat": "^2.22.0"
  }
}
