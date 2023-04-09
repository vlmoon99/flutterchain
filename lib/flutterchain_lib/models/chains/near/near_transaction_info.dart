import 'package:json_annotation/json_annotation.dart';

part 'near_transaction_info.g.dart';

@JsonSerializable()
class NearTransactionInfoModel {
  final int nonce;
  final String blockHash;

  NearTransactionInfoModel({
    required this.nonce,
    required this.blockHash,
  });

  factory NearTransactionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$NearTransactionInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$NearTransactionInfoModelToJson(this);

  @override
  String toString() {
    return "{nonce $nonce , blockHash $blockHash }";
  }
}
