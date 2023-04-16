// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blockchain_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockchainResponse _$BlockchainResponseFromJson(Map<String, dynamic> json) =>
    BlockchainResponse(
      status: json['status'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BlockchainResponseToJson(BlockchainResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
