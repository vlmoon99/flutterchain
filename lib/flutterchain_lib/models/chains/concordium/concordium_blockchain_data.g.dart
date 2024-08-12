// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concordium_blockchain_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConcordiumBlockchainData _$ConcordiumBlockchainDataFromJson(
        Map<String, dynamic> json) =>
    ConcordiumBlockchainData(
      mnemonic: json['mnemonic'] as String,
      accountAddress: json['accountAddress'] as String,
      publicKey: json['publicKey'] as String,
      signingKey: json['signingKey'] as String,
      derivationPath: ConcordiumDerivationPath.fromJson(
          json['derivationPath'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConcordiumBlockchainDataToJson(
        ConcordiumBlockchainData instance) =>
    <String, dynamic>{
      'mnemonic': instance.mnemonic,
      'accountAddress': instance.accountAddress,
      'publicKey': instance.publicKey,
      'signingKey': instance.signingKey,
      'derivationPath': instance.derivationPath,
    };
