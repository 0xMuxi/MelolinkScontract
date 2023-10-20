// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiNFT is ERC1155, Ownable {
    // Mapping from token ID to supply
    mapping(uint256 => uint256) public tokenSupply;

    constructor() ERC1155("https://myapi.com/api/token/{id}.json") Ownable(msg.sender) {
        // Mint initial supply of tokens
        mintToken(1, 100);
        mintToken(2, 200);
    }

    function mintToken(uint256 tokenId, uint256 amount) public onlyOwner {
        _mint(msg.sender, tokenId, amount, "");
        tokenSupply[tokenId] += amount;
    }

    function burnToken(uint256 tokenId, uint256 amount) public onlyOwner {
        require(balanceOf(msg.sender, tokenId) >= amount, "Insufficient balance");
        _burn(msg.sender, tokenId, amount);
        tokenSupply[tokenId] -= amount;
    }
}