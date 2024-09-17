import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'near_blockchain_data.g.dart';

@JsonSerializable()
class NearBlockChainData extends BlockChainData {
  String? accountId;
  final String passphrase;
  NearBlockChainData({
    this.accountId,
    //Standard near ed25519 public key
    required super.publicKey,
    //Base 64 encoded
    required super.privateKey,
    required DerivationPath super.derivationPath,
    required this.passphrase,
    super.identifier = BlockChains.near,
  });

  factory NearBlockChainData.fromJson(Map<String, dynamic> json) =>
      _$NearBlockChainDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NearBlockChainDataToJson(this);

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }
}
