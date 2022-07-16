// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract mintNFT is ERC721, Ownable {
    uint256 totalSupply;                                // Total Supply of the NFT
    uint256 maxSupply;                                  // Maximum Supply of the NFT
    mapping (address => uint256) public mintOwners;     // A mapping from address of NFT owner to total number of NFTs they have minted

    /*
        Constructor from ERC721 token Standard.
        Called once the contract is deployed.
    */
    constructor() payable ERC721('MintNFT', 'MNFT') {
        maxSupply = 10;
    }

    /*
        Function to change the max supply of the contract.
        Can only be called by the owner.

        @params:
        uint256 _maxSupply: The new value for maxSupply.
    */
    function changeMaxSupply(uint256 _maxSupply) external onlyOwner {
        maxSupply = _maxSupply;
    }


    /*
        The function to mint an NFT.
        Internally calls the _safeMint function from ERC721
        which checks whether the tokenID already exists or
        not and if not, then mints the NFT and gives the
        ownership to the address of the message.sender.
    */
    function mint(address to) external payable {
        require(mintOwners[to] < 2, 'Max mints per wallet are 2.');                 // Check for max mints per wallet.
        require(maxSupply > totalSupply, 'NFT has been sold out.');                 // Check for the maxSupply.

        mintOwners[to]++;
        totalSupply++;
        uint256 tokenID = totalSupply;

        _safeMint(msg.sender, tokenID);
    }
}