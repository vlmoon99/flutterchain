// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_blockchain_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearBlockChainData _$NearBlockChainDataFromJson(Map<String, dynamic> json) =>
    NearBlockChainData(
      accountId: json['accountId'] as String?,
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
      derivationPath: DerivationPath.fromJson(
          json['derivationPath'] as Map<String, dynamic>),
      passphrase: json['passphrase'] as String,
      identifier: json['identifier'] as String? ?? BlockChains.near,
    );

Map<String, dynamic> _$NearBlockChainDataToJson(NearBlockChainData instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
      'derivationPath': instance.derivationPath,
      'passphrase': instance.passphrase,
      'accountId': instance.accountId,
    };
