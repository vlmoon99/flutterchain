// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evm_transaction_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EVMTransactionInfo _$EVMTransactionInfoFromJson(Map<String, dynamic> json) =>
    EVMTransactionInfo(
      nonce: json['nonce'] as int,
      gasPrice: json['gasPrice'] as int,
      maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as int?,
      gasLimit: json['gasLimit'] as int,
    );

Map<String, dynamic> _$EVMTransactionInfoToJson(EVMTransactionInfo instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'gasPrice': instance.gasPrice,
      'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
      'gasLimit': instance.gasLimit,
    };
