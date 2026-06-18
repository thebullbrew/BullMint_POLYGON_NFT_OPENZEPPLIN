
pragma solidity ^0.8.24;

/*
    Bull Brew NFT Collection
    Polygon Network ERC-721 Contract
*/

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BullBrewNFT is ERC721URIStorage, Ownable {

    uint256 public nextTokenId;
    uint256 public constant MAX_SUPPLY = 777;

    uint256 public mintPrice = 5 ether;

    bool public publicMintOpen = false;

    string public collectionStatement =
        "Brewed on Wall Street for Asset Warlords.";

    constructor()
        ERC721("Bull Brew NFT", "BREW")
        Ownable(msg.sender)
    {}

    // PUBLIC MINT

    function mint(string memory metadataURI) external payable {

        require(publicMintOpen, "Mint is currently closed.");
        require(nextTokenId < MAX_SUPPLY, "Maximum supply reached.");
        require(msg.value >= mintPrice, "Insufficient MATIC sent.");

        uint256 tokenId = nextTokenId;

        nextTokenId++;

        _safeMint(msg.sender, tokenId);

        _setTokenURI(tokenId, metadataURI);
    }

    // OWNER MINT

    function ownerMint(
        address recipient,
        string memory metadataURI
    ) external onlyOwner {

        require(nextTokenId < MAX_SUPPLY, "Maximum supply reached.");

        uint256 tokenId = nextTokenId;

        nextTokenId++;

        _safeMint(recipient, tokenId);

        _setTokenURI(tokenId, metadataURI);
    }

    // OPEN OR CLOSE PUBLIC MINT

    function setPublicMint(bool status) external onlyOwner {

        publicMintOpen = status;
    }

    // CHANGE MINT PRICE

    function setMintPrice(uint256 newPrice) external onlyOwner {

        mintPrice = newPrice;
    }

    // WITHDRAW CONTRACT FUNDS

    function withdraw() external onlyOwner {

        payable(owner()).transfer(address(this).balance);
    }

    // VIEW CURRENT TOTAL SUPPLY

    function totalMinted() external view returns (uint256) {

        return nextTokenId;
    }
}
}

