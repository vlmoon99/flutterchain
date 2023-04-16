// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_blockchain_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearReceiptOutcome _$NearReceiptOutcomeFromJson(Map<String, dynamic> json) =>
    NearReceiptOutcome(
      id: json['id'] as String,
      outcome: json['outcome'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$NearReceiptOutcomeToJson(NearReceiptOutcome instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outcome': instance.outcome,
    };

NearTransaction _$NearTransactionFromJson(Map<String, dynamic> json) =>
    NearTransaction(
      actions: json['actions'] as List<dynamic>,
      hash: json['hash'] as String,
      nonce: json['nonce'] as int,
      publicKey: json['publicKey'] as String,
      receiverId: json['receiverId'] as String,
      signature: json['signature'] as String,
      signerId: json['signerId'] as String,
    );

Map<String, dynamic> _$NearTransactionToJson(NearTransaction instance) =>
    <String, dynamic>{
      'actions': instance.actions,
      'hash': instance.hash,
      'nonce': instance.nonce,
      'publicKey': instance.publicKey,
      'receiverId': instance.receiverId,
      'signature': instance.signature,
      'signerId': instance.signerId,
    };

NearTransactionOutcome _$NearTransactionOutcomeFromJson(
        Map<String, dynamic> json) =>
    NearTransactionOutcome(
      id: json['id'] as String,
      outcome: json['outcome'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$NearTransactionOutcomeToJson(
        NearTransactionOutcome instance) =>
    <String, dynamic>{
      'id': instance.id,
      'outcome': instance.outcome,
    };
