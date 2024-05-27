class BlockChains {
  static const near = "NEAR";
  static const bitcoin = "BITCOIN";
  static const ethereum = "ETHEREUM";
  static const bnb = "BNB";
  static const aurora = "AURORA";
  static const xrp = "XRP";
  static const polygon = "POLYGON";
  static const List<String> supportedBlockChains = [near, bitcoin];
  static const List<String> supportedBlockChainsForNearMPC = [
    ethereum,
    bitcoin,
    bnb,
    aurora,
    polygon,
    xrp
  ];
}
