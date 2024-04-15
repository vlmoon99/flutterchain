// ignore_for_file: depend_on_referenced_packages

import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bitcoin_blockchain_data.g.dart';

@JsonSerializable()
class BitcoinBlockChainData extends BlockChainData {
  String? accountId;
  BitcoinBlockChainData({
    this.accountId,
    //Standard near ed25519 public key
    required String publicKey,
    //Base 64 encoded
    required String privateKey,
    required DerivationPath derivationPath,
    required String passphrase,
    String identifier = BlockChains.bitcoin,
  }) : super(
          identifier: identifier,
          publicKey: publicKey,
          privateKey: privateKey,
          derivationPath: derivationPath,
          passphrase: passphrase,
        );

  factory BitcoinBlockChainData.fromJson(Map<String, dynamic> json) =>
      _$BitcoinBlockChainDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BitcoinBlockChainDataToJson(this);

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }

  String get() {
    return this.accountId!;
  }
}
