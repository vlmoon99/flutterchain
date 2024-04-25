import 'package:json_annotation/json_annotation.dart';

part 'bitcoin_transaction_info.g.dart';

@JsonSerializable()
class BitcoinTransactionInfoModel {
  final List<dynamic> data;

  BitcoinTransactionInfoModel({required this.data});

  factory BitcoinTransactionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BitcoinTransactionInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$BitcoinTransactionInfoModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BitcoinTransactionInfoModel &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;

  @override
  String toString() {
    return "{data $data }";
  }
}
