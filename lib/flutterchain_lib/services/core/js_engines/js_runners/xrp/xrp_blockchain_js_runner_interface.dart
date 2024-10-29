abstract class XrpBlockChainJSRunner {
  Future<String> createUnsignedTransaction(String txInJson);

  Future<String> signTransactionWithMPCSignatureForXRP({
    required String unsignedTx,
    required String signatureData,
  });
}
