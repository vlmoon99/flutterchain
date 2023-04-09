import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet {
  final String id;
  final String name;
  final String mnemonic;
  final String? passphrase;
  final Map<String, BlockChainData>? blockchainsData;
  Wallet({
    required this.id,
    required this.name,
    required this.mnemonic,
    this.passphrase,
    this.blockchainsData,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);

  @override
  String toString() {
    return "{mnemonic $mnemonic , passphrase $passphrase, blockchainsData $blockchainsData}";
  }
}

@JsonSerializable()
class BlockChainData {
  final String publicKey;
  final String privateKey;

  BlockChainData({
    required this.publicKey,
    required this.privateKey,
  });

  factory BlockChainData.fromJson(Map<String, dynamic> json) =>
      _$BlockChainDataFromJson(json);

  Map<String, dynamic> toJson() => _$BlockChainDataToJson(this);

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }
}
