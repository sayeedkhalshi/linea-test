require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const { PRIVATE_KEY } = process.env;

module.exports = {
    solidity: "0.8.17",
    networks: {
        linea: {
            url: `https://rpc.goerli.linea.build/`,
            accounts: [PRIVATE_KEY],
        },
    },
};
