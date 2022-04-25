const fs = require('fs');

const read = async (data)=>{
    try {
        const dataR = await fs.promises.readFile(data, "utf8");
        console.log("File content:", dataR);
        return dataR;
    } catch (err) {
        console.error(err);
        throw err
    }
}

const main = async (data) => {
    console.log("arg:", data)
    const content = await read(data);

    const MyContract = await ethers.getContractFactory("BS_EncodedNFT");
    const contract = await MyContract.attach(
        "0xbb9984d2b5FE5e5d795226Adc98802fce8289be0" // The deployed contract address
    );

    // Now you can call functions of the contract
    let txn = await contract.mintNFT(content);

    // Wait for it to be mined.
    await txn.wait()
    console.log("Minted NFT")

};

const runMain = async (data) => {
    try {
        await main(data);
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain("/home/afa/Documents/code/others/PROJECTS/web3_stuff/bs-nfts/resources/encoded.txt");