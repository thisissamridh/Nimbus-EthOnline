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
    

uint256 [] public totalSellers;
    mapping (address=>uint256) public addressToSellerId;
    mapping(uint256=>seller) public allSellers;
    mapping(uint256=>mapping(uint256=>warrantyDetails)) public sellerWarrantyDetails;
    mapping(uint256=>mapping(uint256=>string)) public tokenURIList;
    mapping (address=>uint256[]) public buyersCollection;
    mapping (address=>uint256) public buyersCount;

    function verifyOwnership(string memory productId,uint256 sellerId,uint256 tokenId)public returns(bool){
        //require(sellerWarrantyDetails[sellerId][tokenId].verifyHash!=bytes32(0x0),"Item doesn't Exist");
        
        if(sellerWarrantyDetails[sellerId][tokenId].verifyHash==keccak256(abi.encode(msg.sender,productId))){
            sellerWarrantyDetails[sellerId][tokenId].status = NFTStatus.Verified;
            return true;
            
        }
        else return false;
    }
    function claimNMint(uint256 sellerId,uint256 tokenId)public {
        require(sellerWarrantyDetails[sellerId][tokenId].status == NFTStatus.Verified);
        _mint(msg.sender,tokenId);
        _setTokenURI(tokenId,tokenURIList[sellerId][tokenId]); 
        sellerWarrantyDetails[sellerId][tokenId].status =  NFTStatus.Active;
 

    }
    function createSeller(uint256 sellerId) public{
        require(allSellers[sellerId].owner==address(0x0),"Seller Already exist");
         seller memory newSeller;
         newSeller.id = sellerId;
         newSeller.owner = msg.sender;
         newSeller.itemCounter = 0;
         allSellers[sellerId] = newSeller;
         totalSellers.push(sellerId);
         addressToSellerId[msg.sender] = sellerId;

    }
    function createNFT(string memory tokenURI,uint256 sellerId,string memory productId,address customer,uint256 expiry,string memory imageURI)public{
      //require(tokenURIList[sellerId][allSellers[sellerId].itemCounter].length==0,"");

      require(msg.sender== allSellers[sellerId].owner,"Must be owner");
      warrantyDetails memory newNFT;

      newNFT.creationTime = block.timestamp;
      newNFT.verifyHash = keccak256(abi.encode(customer,productId));
      newNFT.expiry =  newNFT.creationTime + expiry;
        
      uint256 Id = allSellers[sellerId].id*1000000+allSellers[sellerId].itemCounter;
       sellerWarrantyDetails[sellerId][Id]=newNFT;
        sellerWarrantyDetails[sellerId][Id].productId = productId;
      allSellers[sellerId].allNFTs.push(Id);
      sellerWarrantyDetails[sellerId][Id].tokenId = Id;
      sellerWarrantyDetails[sellerId][Id].verifyHash = keccak256(abi.encode(customer,productId));
      sellerWarrantyDetails[sellerId][Id].imageURI = imageURI;
      sellerWarrantyDetails[sellerId][Id].buyers.push(customer);
      sellerWarrantyDetails[sellerId][Id].status =  NFTStatus.Pending;
      sellerWarrantyDetails[sellerId][Id].buyersDate.push(newNFT.creationTime);
      allSellers[sellerId].itemCounter++;
      buyersCollection[customer].push(Id);
      buyersCount[customer]++;

      tokenURIList[sellerId][Id]=tokenURI;
        
    }