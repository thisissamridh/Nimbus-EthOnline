const HDWalletProvider = require("@truffle/hdwallet-provider");
const path = require("path");
const dotenv = require("dotenv")
dotenv.config()



const MNEMONIC = process.env.MNEMONIC;


module.exports = {
  contracts_build_directory: path.join(__dirname, "client/src/contracts"),
  networks: {
    testnet: {
      provider: () => new HDWalletProvider(MNEMONIC, 'https://sepolia-rpc.scroll.io/'),
      network_id: 534351,
      confirmations: 2,
      timeoutBlocks: 9999999,
      skipDryRun: true,
      networkCheckTimeout: 999999999
    }

  },
  compilers: {
    solc: {
      version: "^0.8.17"
    }
  },

};