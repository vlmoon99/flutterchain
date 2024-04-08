import 'package:json_annotation/json_annotation.dart';

part 'bitcoin_transaction_info.g.dart';

@JsonSerializable()
class BitcoinTransactionInfoModel {
  final String tx_hash;
  final String ref_balance;
  final int tx_output;

  BitcoinTransactionInfoModel({
    required this.tx_hash,
    required this.ref_balance,
    required this.tx_output,
  });

  factory BitcoinTransactionInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BitcoinTransactionInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$BitcoinTransactionInfoModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BitcoinTransactionInfoModel &&
          runtimeType == other.runtimeType &&
          tx_hash == other.tx_hash &&
          ref_balance == other.ref_balance;

  @override
  int get hashCode => tx_hash.hashCode ^ ref_balance.hashCode;

  @override
  String toString() {
    return "{nonce $tx_hash , blockHash $ref_balance }";
  }
}
