// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTWarranty is ERC721URIStorage {
    //using Counters for Counters.Counter;
    //Counters.Counter private _tokenIds;

        constructor() ERC721("NFTDocketWarranty", "NFTDW") {}

     struct seller{
        uint256 id;
        uint256 itemCounter;
        address owner;
        uint256 [] allNFTs;
        //string tokenURI;
     
    }
     struct warrantyDetails{
        uint256 tokenId;
        bytes32 verifyHash;
        uint256 creationTime;
        string  productId;
        string imageURI;
        uint256 expiry;
        address[]buyers;
        uint256[]buyersDate;
        NFTStatus status;
    }
    //verify ownership
    enum NFTStatus{
        Pending,
        Verified,
        Active,
        Expired
    }
    