import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet {
  final String id;
  final String name;
  final String mnemonic;
  final String? passphrase;
  final Map<String, Set<BlockChainData>>? blockchainsData;
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockChainData &&
          // runtimeType == other.runtimeType &&
          publicKey == other.publicKey &&
          privateKey == other.privateKey &&
          derivationPath == other.derivationPath &&
          passphrase == other.passphrase;

  @override
  int get hashCode =>
      publicKey.hashCode ^
      privateKey.hashCode ^
      derivationPath.hashCode ^
      passphrase.hashCode;

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }
}

@JsonSerializable()
class DerivationPath {
  // m’ / purpose’ / coin_type’ / accountNumber / change / address
  final String purpose;
  final String coinType;
  final String accountNumber;
  final String change;
  final String address;

  const DerivationPath({
    required this.purpose,
    required this.coinType,
    required this.accountNumber,
    required this.change,
    required this.address,
  });

  factory DerivationPath.fromJson(Map<String, dynamic> json) =>
      _$DerivationPathFromJson(json);

  Map<String, dynamic> toJson() => _$DerivationPathToJson(this);

  @override
  String toString() {
    return "m'/$purpose'/$coinType'/$accountNumber'/$change'/$address'";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DerivationPath &&
          runtimeType == other.runtimeType &&
          purpose == other.purpose &&
          coinType == other.coinType &&
          accountNumber == other.accountNumber &&
          change == other.change &&
          address == other.address;

  @override
  int get hashCode =>
      purpose.hashCode ^
      coinType.hashCode ^
      accountNumber.hashCode ^
      change.hashCode ^
      address.hashCode;
}
