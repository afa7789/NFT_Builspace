// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import {Base64} from "./Base64.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract BS_EncodedNFT is ERC721URIStorage {
    // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our NFTs token and its symbol.
    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        console.log("NFT Collection: %s, Symbol: %s", name, symbol);
    }

    // A function our user will hit to get their NFT.
    function mint(
        string memory name,
        string memory description,
        string memory image_link
    ) public {
        // Get the current tokenId, this starts at 0.
        uint256 newItemId = _tokenIds.current();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, newItemId);

        string toEncodeJson = '{"name":"' +
            name +
            '","description":"' +
            description +
            '","image_link":"' +
            image_link +
            '"}';
        
        string encoded = Base64.encode(bytes(finalSvg));
        string str_encoded = string(
            abi.encodePacked("data:application/json;base64,", "", encoded)
        );

        // Set the NFTs data.
        _setTokenURI(newItemId, str_encoded);

        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        console.log(
            "the NFT URI encoded is of length %s",
            bytes(encoded).length
        );
        // Increment the counter for when the next NFT is minted.
        _tokenIds.increment();
    }
}
