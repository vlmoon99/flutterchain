// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concordium_blockchain_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConcordiumBlockChainData _$ConcordiumBlockChainDataFromJson(
        Map<String, dynamic> json) =>
    ConcordiumBlockChainData(
      accountAddress: json['accountAddress'] as String,
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
      derivationPath: ConcordiumDerivationPath.fromJson(
          json['derivationPath'] as Map<String, dynamic>),
      identifier: json['identifier'] as String? ?? BlockChains.concordium,
    );

Map<String, dynamic> _$ConcordiumBlockChainDataToJson(
        ConcordiumBlockChainData instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
      'derivationPath': instance.derivationPath,
      'accountAddress': instance.accountAddress,
    };
