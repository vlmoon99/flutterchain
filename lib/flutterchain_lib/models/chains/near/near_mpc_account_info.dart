class MPCAccountInfo {
  final String address;
  final String publicKey;

  MPCAccountInfo({required this.address, required this.publicKey});

  @override
  String toString() {
    return 'MPCAccountInfo(address: $address, publicKey: $publicKey)';
  }
}