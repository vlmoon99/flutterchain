class BlockChains {
  static const near = "NEAR";
  static const bitcoin = "BITCOIN";
  static const ethereum = "ETHEREUM";
  static const bnb = "BNB";
  static const aurora = "AURORA";
  static const xrp = "XRP";
  static const polygon = "POLYGON";
  static const avalanche = "AVALANCHE";
  static const concordium = "CONCORDIUM";
  static const List<String> supportedBlockChains = [near, bitcoin, concordium];
  static const List<String> supportedBlockChainsForSmartContractCall = [near];
  static const List<String> supportedBlockChainsForNearMPC = [
    ethereum,
    bitcoin,
    bnb,
    aurora,
    polygon,
    avalanche,
    xrp
  ];
}
