import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet {
  final String id;
  final String name;
  final String mnemonic;
  final String? passphrase;
  final Map<String, List<BlockChainData>>? blockchainsData;
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
  final DerivationPath derivationPath;
  final String passphrase;

  BlockChainData({
    required this.publicKey,
    required this.privateKey,
    required this.derivationPath,
    required this.passphrase,
  });

  factory BlockChainData.fromJson(Map<String, dynamic> json) =>
      _$BlockChainDataFromJson(json);

  Map<String, dynamic> toJson() => _$BlockChainDataToJson(this);

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }
}

@JsonSerializable()
class DerivationPath {
  int accountNumber;
  int change;
  int address;

  DerivationPath({
    required this.accountNumber,
    required this.change,
    required this.address,
  });

  factory DerivationPath.fromJson(Map<String, dynamic> json) =>
      _$DerivationPathFromJson(json);

  Map<String, dynamic> toJson() => _$DerivationPathToJson(this);

  @override
  String toString() {
    return "{Account Number $accountNumber , Change $change, Address $address }";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DerivationPath &&
          runtimeType == other.runtimeType &&
          accountNumber == other.accountNumber &&
          change == other.change &&
          address == other.address;

  @override
  int get hashCode =>
      accountNumber.hashCode ^ change.hashCode ^ address.hashCode;
}
