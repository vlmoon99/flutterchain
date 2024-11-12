abstract class EvmBlockChainJSRunner {
  Future<String> createUnsignedTransaction({
    required String receiver,
    required int weiAmount,
    required String chainInfo,
    required String txCreatingInfo,
    String? smartContractCallEncoded,
  });

  Future<String> getAbiEncodedSmartContractArgs(
      {required String functionSignature, required String parameters});

  Future<String> signTransactionWithMPCSignatureForEVMBlockchain({
    required String signatureData,
    required String serializedTransaction,
    required String sender,
    required String typeOfTransaction,
    required String chainInfo,
  });
}
