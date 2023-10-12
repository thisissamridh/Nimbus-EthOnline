//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface INFTWarranty {
    function getSellerNFTs(uint256 sellerId)
        external
        view
        returns (uint256[] memory);

    function getSellers() external view returns (uint256[] memory);

    function getExpiry(uint256 sellerId, uint256 tokenId)
        external
        view
        returns (uint256 expiry);

    function getCreation(uint256 sellerId, uint256 tokenId)
        external
        view
        returns (uint256 creation);

    function getStatus(uint256 sellerId, uint256 tokenId)
        external
        view
        returns (uint256 stat);
        function getSellerNFT(uint256 sellerId,uint256 Index)external view returns(uint256);
        function getSellerNFTSize(uint256 sellerId)external view returns(uint256);

    function burn(uint256 tokenId) external;
}