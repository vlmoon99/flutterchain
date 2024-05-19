import 'package:json_annotation/json_annotation.dart';

part 'evm_transaction_info.g.dart';

@JsonSerializable()
class EVMTransactionInfo {
  final int nonce;
  final int gasPrice;
  final int? maxPriorityFeePerGas;
  final int gasLimit;

  EVMTransactionInfo({
    required this.nonce,
    required this.gasPrice,
    this.maxPriorityFeePerGas,
    required this.gasLimit,
  });

  factory EVMTransactionInfo.fromJson(Map<String, dynamic> json) =>
      _$EVMTransactionInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EVMTransactionInfoToJson(this);

  @override
  String toString() =>
      'EVMTransactionInfo(nonce: $nonce, gasPrice: $gasPrice, maxPriorityFeePerGas: $maxPriorityFeePerGas, gasLimit: $gasLimit)';
}
