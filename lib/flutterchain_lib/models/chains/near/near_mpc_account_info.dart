class MPCAccountInfo {
  final String adress;
  final String publicKey;

  MPCAccountInfo({required this.adress, required this.publicKey});

  @override
  String toString() {
    return 'MPCAccountInfo(adress: $adress, publicKey: $publicKey)';
  }
}