var encoded_big_string = require('../resources/big_const_7_sins.js');

const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('BS_EncodedNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
    console.log("encoded_big_string:", encoded_big_string);
    // Call the function.
    let txn = await nftContract.mintNFT(encoded_big_string,{gasLimit:9000000})
    // Wait for it to be mined.
    await txn.wait()
    console.log("Minted NFT")

};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();