class XRPTransactionInfo {
  final int lastLedgerSequence;
  final String fee;
  final int sequence;
  final int networkId;

  XRPTransactionInfo({
    required this.lastLedgerSequence,
    required this.fee,
    required this.sequence,
    required this.networkId,
  });

  @override
  String toString() {
    return 'XRPTransactionInfo(lastLedgerSequence: $lastLedgerSequence, fee: $fee, sequence: $sequence, networkId: $networkId)';
  }
}
