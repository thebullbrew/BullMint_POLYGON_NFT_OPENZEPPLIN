// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BullBrewNFT is ERC721, ERC2981, Ownable, ReentrancyGuard {
    using Strings for uint256;

    uint256 public immutable maxSupply;
    uint256 public immutable reservedSupply;
    uint256 public mintPrice;
    uint256 public totalMinted;
    uint256 public maxMintPerWallet;

    bool public publicMintEnabled;

    string private baseTokenURI;

    mapping(address => uint256) public walletMints;

    error PublicMintDisabled();
    error MaxSupplyReached();
    error ExceedsWalletLimit();
    error InvalidMintQuantity();
    error InsufficientPayment();
    error ReserveExceeded();
    error NoFunds();

    event PublicMintToggled(bool enabled);
    event MintPriceUpdated(uint256 newPrice);
    event BaseURIUpdated(string newBaseURI);
    event RoyaltyUpdated(address receiver, uint96 feeNumerator);
    event MaxMintPerWalletUpdated(uint256 newLimit);
    event OwnerMint(address indexed recipient, uint256 quantity);
    event PublicMint(address indexed minter, uint256 quantity, uint256 totalPaid);
    event Withdraw(address indexed owner, uint256 amount);

    constructor(
        string memory collectionName,
        string memory collectionSymbol,
        uint256 supplyLimit,
        uint256 reserveAmount,
        uint256 initialMintPrice,
        uint256 walletLimit,
        string memory initialBaseURI,
        address royaltyReceiver,
        uint96 royaltyFeeNumerator
    ) ERC721(collectionName, collectionSymbol) Ownable(msg.sender) {
        require(supplyLimit > 0, "Supply must be > 0");
        require(reserveAmount <= supplyLimit, "Reserve exceeds supply");
        require(walletLimit > 0, "Wallet limit must be > 0");
        require(royaltyReceiver != address(0), "Invalid royalty receiver");
        require(bytes(initialBaseURI).length > 0, "Base URI required");

        maxSupply = supplyLimit;
        reservedSupply = reserveAmount;
        mintPrice = initialMintPrice;
        maxMintPerWallet = walletLimit;
        baseTokenURI = initialBaseURI;

        _setDefaultRoyalty(royaltyReceiver, royaltyFeeNumerator);
    }

    // =============================================================
    //                           MINTING
    // =============================================================

    function publicMint(uint256 quantity) external payable nonReentrant {
        if (!publicMintEnabled) revert PublicMintDisabled();
        if (quantity == 0) revert InvalidMintQuantity();

        uint256 publicSupply = maxSupply - reservedSupply;

        if (totalMinted + quantity > publicSupply) {
            revert MaxSupplyReached();
        }

        if (walletMints[msg.sender] + quantity > maxMintPerWallet) {
            revert ExceedsWalletLimit();
        }

        uint256 requiredPayment = mintPrice * quantity;
        if (msg.value < requiredPayment) revert InsufficientPayment();

        walletMints[msg.sender] += quantity;

        for (uint256 i = 0; i < quantity; i++) {
            _mintNext(msg.sender);
        }

        emit PublicMint(msg.sender, quantity, msg.value);
    }

    function ownerMint(address recipient, uint256 quantity) external onlyOwner {
        require(recipient != address(0), "Invalid recipient");
        if (quantity == 0) revert InvalidMintQuantity();

        if (totalMinted + quantity > maxSupply) {
            revert MaxSupplyReached();
        }

        // Ensure owner mints do not exceed reserved allocation while public supply is intended for public buyers.
        uint256 ownerMintedSoFar = totalMinted > (maxSupply - reservedSupply)
            ? totalMinted - (maxSupply - reservedSupply)
            : 0;

        if (ownerMintedSoFar + quantity > reservedSupply) {
            revert ReserveExceeded();
        }

        for (uint256 i = 0; i < quantity; i++) {
            _mintNext(recipient);
        }

        emit OwnerMint(recipient, quantity);
    }

    function _mintNext(address recipient) internal {
        uint256 tokenId = totalMinted + 1;
        totalMinted += 1;
        _safeMint(recipient, tokenId);
    }

    // =============================================================
    //                         OWNER CONTROLS
    // =============================================================

    function togglePublicMint(bool enabled) external onlyOwner {
        publicMintEnabled = enabled;
        emit PublicMintToggled(enabled);
    }

    function updateMintPrice(uint256 newPrice) external onlyOwner {
        mintPrice = newPrice;
        emit MintPriceUpdated(newPrice);
    }

    function updateMaxMintPerWallet(uint256 newLimit) external onlyOwner {
        require(newLimit > 0, "Limit must be > 0");
        maxMintPerWallet = newLimit;
        emit MaxMintPerWalletUpdated(newLimit);
    }

    function setBaseURI(string calldata newBaseURI) external onlyOwner {
        require(bytes(newBaseURI).length > 0, "Base URI required");
        baseTokenURI = newBaseURI;
        emit BaseURIUpdated(newBaseURI);
    }

    function setDefaultRoyalty(address receiver, uint96 feeNumerator) external onlyOwner {
        require(receiver != address(0), "Invalid royalty receiver");
        _setDefaultRoyalty(receiver, feeNumerator);
        emit RoyaltyUpdated(receiver, feeNumerator);
    }

    function deleteDefaultRoyalty() external onlyOwner {
        _deleteDefaultRoyalty();
    }

    // =============================================================
    //                          WITHDRAW
    // =============================================================

    function withdraw() external onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        if (balance == 0) revert NoFunds();

        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "Withdraw failed");

        emit Withdraw(owner(), balance);
    }

    // =============================================================
    //                          METADATA
    // =============================================================

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json"))
            : "";
    }

    // =============================================================
    //                          VIEWS
    // =============================================================

    function remainingSupply() external view returns (uint256) {
        return maxSupply - totalMinted;
    }

    function remainingPublicSupply() external view returns (uint256) {
        uint256 publicSupply = maxSupply - reservedSupply;

        if (totalMinted >= publicSupply) {
            return 0;
        }

        return publicSupply - totalMinted;
    }

    function getBaseURI() external view returns (string memory) {
        return baseTokenURI;
    }

    // =============================================================
    //                     INTERFACE SUPPORT
    // =============================================================

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC2981)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}


