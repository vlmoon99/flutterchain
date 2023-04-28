// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_blockchain_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearBlockChainData _$NearBlockChainDataFromJson(Map<String, dynamic> json) =>
    NearBlockChainData(
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
      derivationPath: DerivationPath.fromJson(
          json['derivationPath'] as Map<String, dynamic>),
      passphrase: json['passphrase'] as String,
    );

Map<String, dynamic> _$NearBlockChainDataToJson(NearBlockChainData instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
      'derivationPath': instance.derivationPath,
      'passphrase': instance.passphrase,
    };
