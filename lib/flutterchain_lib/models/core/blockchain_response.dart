import 'package:json_annotation/json_annotation.dart';

part 'blockchain_response.g.dart';

@JsonSerializable()
class BlockchainResponse {
  BlockchainResponse({
    required this.status,
    required this.data,
  });

  final String status;
  final Map<String, dynamic> data;

  factory BlockchainResponse.fromJson(Map<String, dynamic> json) =>
      _$BlockchainResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BlockchainResponseToJson(this);
}
