// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorized.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authorized _$AuthorizedFromJson(Map<String, dynamic> json) => Authorized(
      json['accountId'] as String,
      json['secretKey'] as String,
      $enumDecode(_$NearNetworkTypeEnumMap, json['networkType']),
    );

Map<String, dynamic> _$AuthorizedToJson(Authorized instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'secretKey': instance.secretKey,
      'networkType': _$NearNetworkTypeEnumMap[instance.networkType]!,
    };

const _$NearNetworkTypeEnumMap = {
  NearNetworkType.testnet: 'testnet',
  NearNetworkType.mainnet: 'mainnet',
};
