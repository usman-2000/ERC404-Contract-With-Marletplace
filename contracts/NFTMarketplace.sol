// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4; // compiler version has some issues and on the notes it is 20

import "./Interface/IDN404.sol";
import "@openzeppelin/contracts/utils/Context.sol";

error PriceNotMet(address nftAddress, uint256 price);
error ItemNotForSale(address nftAddress);
error NotListed(address nftAddress);
error AlreadyListed(address nftAddress);
error NoProceeds();
error NotOwner();
error NotApprovedForMarketplace();
error PriceMustBeAboveZero();
error NotApproved();

contract NFTMarketplace is Context {
    uint256 private counter;

    struct Listing {
        uint256 price;
        address seller;
    }

    event LogItemListed(
        address indexed seller,
        address indexed nftAddress,
        uint256 price
    );

    event LogItemCanceled(address indexed seller, address indexed nftAddress);

    event LogItemBought(
        address indexed buyer,
        address indexed nftAddress,
        uint256 price,
        uint256 fraction
    );

    mapping(address => Listing) private s_listings;
    mapping(address => uint256) private s_proceeds;

    modifier isListed(address nftAddress) {
        Listing memory listing = s_listings[nftAddress];
        require(listing.price > 0, "Not listed");
        _;
    }

    modifier notListed(address nftAddress) {
        Listing memory listing = s_listings[nftAddress];
        require(listing.price == 0, "Already listed");
        _;
    }

    modifier isOwner(address nftAddress, address spender) {
        IDN404 nft = IDN404(nftAddress);
        require(nft.balanceOf(spender) > 0, "Not owner");
        _;
    }
}
