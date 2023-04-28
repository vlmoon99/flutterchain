// ignore_for_file: depend_on_referenced_packages

import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'near_blockchain_data.g.dart';

@JsonSerializable()
class NearBlockChainData extends BlockChainData {
  NearBlockChainData({
    //Standard near ed25519 public key
    required String publicKey,
    //Base 64 encoded
    required String privateKey,
    required DerivationPath derivationPath,
    required String passphrase,
  }) : super(
          publicKey: publicKey,
          privateKey: privateKey,
          derivationPath: derivationPath,
          passphrase: passphrase,
        );

  factory NearBlockChainData.fromJson(Map<String, dynamic> json) =>
      _$NearBlockChainDataFromJson(json);

  Map<String, dynamic> toJson() => _$NearBlockChainDataToJson(this);

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }
}
