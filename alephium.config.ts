const Configuration = require('@alephium/cli')
const Number256 = require('@alephium/web3')

const dotenv = require('dotenv');
dotenv.config()

let config: typeof Configuration;

export type Settings = {
  commissionRate: number // basis point. e.g. 200: 2%
}

export function loadSettings(network: 'devnet' | 'testnet' | 'mainnet'): { commissionRate: number } {
  return {
    commissionRate: 100, // 1%
  }
}

const configuration: typeof config = {
  deploymentScriptDir: 'scripts/faucet',
  skipRecompile: false,
  compilerOptions: {
    ignoreUnusedConstantsWarnings: true,
    ignoreUnusedVariablesWarnings: true,
    ignoreUnusedFieldsWarnings: true,
    ignoreUnusedPrivateFunctionsWarnings: true,
    ignoreUpdateFieldsCheckWarnings: true,
    ignoreCheckExternalCallerWarnings: true,
    errorOnWarnings: false,
  },

  networks: {
    devnet: {
      networkId: 2,
      nodeUrl: 'http://localhost:22973',
      privateKeys: [
        'a642942e67258589cd2b1822c631506632db5a12aabcf413604e785300d762a5'
      ],
      confirmations: 1,
      settings: loadSettings('devnet')
    },

    testnet: {
      nodeUrl: process.env.NODE_URL as string ?? 'https://node.testnet.alephium.org',
      privateKeys: process.env.testkey === undefined ? [] : process.env.testkey.split(','),
      confirmations: 2,
      settings: loadSettings('testnet')
    },

    mainnet: {
      networkId: 0,
      nodeUrl: process.env.NODE_URL as string ?? 'https://node.mainnet.alephium.org',
      privateKeys: process.env.prodkey === undefined ? [] : process.env.prodkey.split(','),
      confirmations: 2,
      settings: loadSettings('mainnet')
    }
  }
}

export default configuration
