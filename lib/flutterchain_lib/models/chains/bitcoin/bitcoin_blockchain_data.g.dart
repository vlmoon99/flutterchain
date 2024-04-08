// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bitcoin_blockchain_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BitcoinBlockChainData _$BitcoinBlockChainDataFromJson(
        Map<String, dynamic> json) =>
    BitcoinBlockChainData(
      accountId: json['accountId'] as String?,
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
      derivationPath: DerivationPath.fromJson(
          json['derivationPath'] as Map<String, dynamic>),
      passphrase: json['passphrase'] as String,
      identifier: json['identifier'] as String? ?? BlockChains.bitcoin,
    );

Map<String, dynamic> _$BitcoinBlockChainDataToJson(
        BitcoinBlockChainData instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
      'derivationPath': instance.derivationPath,
      'passphrase': instance.passphrase,
      'accountId': instance.accountId,
    };
