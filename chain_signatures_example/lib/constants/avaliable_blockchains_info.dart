import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';

class AvaliableBlockchainsInfo {
  static const List<String> availableChains = [
    BlockChains.ethereum,
    BlockChains.bnb,
    BlockChains.polygon,
    BlockChains.avalanche,
    BlockChains.aurora,
    BlockChains.bitcoin,
    BlockChains.xrp,
  ];

  static const Map<String, dynamic> chainsLogos = {
    BlockChains.ethereum: "assets/ethereum-eth-logo.svg",
    BlockChains.bnb: "assets/bnb-bnb-logo.svg",
    BlockChains.polygon: "assets/polygon-matic-logo.svg",
    BlockChains.avalanche: "assets/avalanche-avax-logo.svg",
    BlockChains.aurora: "assets/aurora-aoa-logo.svg",
    BlockChains.bitcoin: "assets/bitcoin-btc-logo.svg",
    BlockChains.xrp: "assets/xrp-xrp-logo.svg",
  };

  static const Map<String, dynamic> chainsCurrencyNames = {
    BlockChains.ethereum: "ETH",
    BlockChains.bnb: "BNB",
    BlockChains.polygon: "MATIC",
    BlockChains.avalanche: "AVAX",
    BlockChains.aurora: "AOA",
    BlockChains.bitcoin: "BTC",
    BlockChains.xrp: "XRP",
  };

  static const List<String> evmChains = [
    BlockChains.ethereum,
    BlockChains.bnb,
    BlockChains.polygon,
    BlockChains.avalanche,
    BlockChains.aurora,
  ];

  static const Map<String, dynamic> explorerUrls = {
    BlockChains.ethereum: {
      "testnet": "https://sepolia.etherscan.io/",
      "mainnet": "https://etherscan.io/",
    },
    BlockChains.bnb: {
      "testnet": "https://testnet.bscscan.com/",
      "mainnet": "https://bscscan.com/"
    },
    BlockChains.polygon: {
      "testnet": "https://amoy.polygonscan.com/",
      "mainnet": "https://polygonscan.com/"
    },
    BlockChains.avalanche: {
      "testnet": "https://subnets-test.avax.network/c-chain/",
      "mainnet": "https://subnets.avax.network/c-chain/"
    },
    BlockChains.aurora: {
      "testnet": "https://testnet.aurorascan.dev/",
      "mainnet": "https://aurorascan.dev/"
    },
    BlockChains.bitcoin: {
      "testnet": "https://live.blockcypher.com/btc-testnet/",
      "mainnet": "https://live.blockcypher.com/btc/"
    },
    BlockChains.xrp: {
      "testnet": "https://test.bithomp.com/explorer/",
      "mainnet": "https://bithomp.com/explorer/"
    }
  };

  static String getExplorerUrlToTx({
    required String blockchainType,
    required String txHash,
    required String networkType,
  }) {
    if (blockchainType == BlockChains.xrp) {
      return explorerUrls[blockchainType][networkType]! + txHash;
    } else {
      return explorerUrls[blockchainType][networkType]! + "tx/" + txHash;
    }
  }
}
