// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bitcoin_transaction_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BitcoinTransactionInfoModel _$BitcoinTransactionInfoModelFromJson(
        Map<String, dynamic> json) =>
    BitcoinTransactionInfoModel(
      tx_hash: json['tx_hash'] as String,
      ref_balance: json['ref_balance'] as String,
      tx_output: json['tx_output'] as int,
    );

Map<String, dynamic> _$BitcoinTransactionInfoModelToJson(
        BitcoinTransactionInfoModel instance) =>
    <String, dynamic>{
      'tx_hash': instance.tx_hash,
      'ref_balance': instance.ref_balance,
      'tx_output': instance.tx_output,
    };
