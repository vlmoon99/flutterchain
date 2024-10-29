// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evm_transaction_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EVMTransactionInfo _$EVMTransactionInfoFromJson(Map<String, dynamic> json) =>
    EVMTransactionInfo(
      nonce: (json['nonce'] as num).toInt(),
      gasPrice: (json['gasPrice'] as num).toInt(),
      maxPriorityFeePerGas: (json['maxPriorityFeePerGas'] as num?)?.toInt(),
      gasLimit: (json['gasLimit'] as num).toInt(),
    );

Map<String, dynamic> _$EVMTransactionInfoToJson(EVMTransactionInfo instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'gasPrice': instance.gasPrice,
      'maxPriorityFeePerGas': instance.maxPriorityFeePerGas,
      'gasLimit': instance.gasLimit,
    };
