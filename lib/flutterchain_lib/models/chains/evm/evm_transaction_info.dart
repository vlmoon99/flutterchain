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

  @override
  String toString() =>
      'EVMTransactionInfo(nonce: $nonce, gasPrice: $gasPrice, maxPriorityFeePerGas: $maxPriorityFeePerGas, gasLimit: $gasLimit)';
}
