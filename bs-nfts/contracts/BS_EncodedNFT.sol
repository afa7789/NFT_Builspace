// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract BS_EncodedNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // We need to pass the name of our NFTs token and its symbol.
  constructor() ERC721 ("Buildspace_NFT", "BS_NFT") {
    console.log("NFT Collection Buildspace_NFT");
  }

  // A function our user will hit to get their NFT.
  function mintNFT(string memory encoded) public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);
    
    // Set the NFTs data.
    _setTokenURI(newItemId,string(abi.encodePacked("data:application/json;base64,",'',encoded)));
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    console.log("the NFT URI encoded is of length %s", bytes(encoded).length);
    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
  }
  
}