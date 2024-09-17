import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
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
  final String identifier;
  final String publicKey;
  final String privateKey;
  final DerivationPathData derivationPath;

  BlockChainData({
    required this.identifier,
    required this.publicKey,
    required this.privateKey,
    required this.derivationPath,
  });

  // factory BlockChainData.fromJson(Map<String, dynamic> json) =>
  //     _$BlockChainDataFromJson(json);
  factory BlockChainData.fromJson(Map<String, dynamic> json) {
    String identifier = json['identifier'] as String;
    switch (identifier) {
      case BlockChains.near:
        return NearBlockChainData.fromJson(json);
      case BlockChains.bitcoin:
        return BitcoinBlockChainData.fromJson(json);
      // Add more cases for other supported blockchains
      default:
        throw Exception('Unsupported blockchain data type');
    }
  }

  Map<String, dynamic> toJson() => _$BlockChainDataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockChainData &&
          // runtimeType == other.runtimeType &&
          publicKey == other.publicKey &&
          privateKey == other.privateKey &&
          derivationPath == other.derivationPath;

  @override
  int get hashCode =>
      publicKey.hashCode ^ privateKey.hashCode ^ derivationPath.hashCode;

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }
}

@JsonSerializable()
class DerivationPathData {
  DerivationPathData();

  factory DerivationPathData.fromJson(Map<String, dynamic> json) {
    final purpose = json['coinType'] as String?;
    if (purpose != null) {
      return DerivationPath.fromJson(json);
    } else {
      throw Exception('Invalid derivation path data');
    }
  }

  Map<String, dynamic> toJson() => _$DerivationPathDataToJson(this);
}

@JsonSerializable()
class DerivationPath implements DerivationPathData {
  // m / purpose’ / coin_type’ / accountNumber / change / address
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

  @override
  Map<String, dynamic> toJson() => _$DerivationPathToJson(this);

  @override
  String toString() {
    return "m/$purpose/$coinType/$accountNumber/$change/$address";
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
