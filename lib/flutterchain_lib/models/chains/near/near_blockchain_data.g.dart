// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_blockchain_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearBlockChainData _$NearBlockChainDataFromJson(Map<String, dynamic> json) =>
    NearBlockChainData(
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
    );

Map<String, dynamic> _$NearBlockChainDataToJson(NearBlockChainData instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
    };
