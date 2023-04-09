// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_transaction_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearTransactionInfoModel _$NearTransactionInfoModelFromJson(
        Map<String, dynamic> json) =>
    NearTransactionInfoModel(
      nonce: json['nonce'] as int,
      blockHash: json['blockHash'] as String,
    );

Map<String, dynamic> _$NearTransactionInfoModelToJson(
        NearTransactionInfoModel instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'blockHash': instance.blockHash,
    };
