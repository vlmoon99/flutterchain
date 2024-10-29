// ignore_for_file: depend_on_referenced_packages

import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bitcoin_blockchain_data.g.dart';

@JsonSerializable()
class BitcoinBlockChainData extends BlockChainData {
  String? accountId;
  final String passphrase;
  BitcoinBlockChainData({
    // Standard bitcoin SegWit address
    this.accountId,
    //Standard bitcoin Base 58 encoded public key
    required super.publicKey,
    //Base 58 encoded
    required super.privateKey,
    required DerivationPath super.derivationPath,
    required this.passphrase,
    super.identifier = BlockChains.bitcoin,
  });

  factory BitcoinBlockChainData.fromJson(Map<String, dynamic> json) =>
      _$BitcoinBlockChainDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BitcoinBlockChainDataToJson(this);

  @override
  String toString() {
    return "{publicKey $publicKey , privateKey $privateKey }";
  }

  String get() {
    return accountId!;
  }
}
