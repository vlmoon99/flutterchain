import 'dart:js_interop';

import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/evm/evm_blockchain_js_runner_interface.dart';

EvmBlockChainJSRunner getEVMJsRunner() => EvmBlockchainWebJsRunner();

class EvmBlockchainWebJsRunner implements EvmBlockChainJSRunner {
  @override
  Future<String> createUnsignedTransaction({
    required String receiver,
    required int weiAmount,
    required String chainInfo,
    required String txCreatingInfo,
    String? smartContractCallEncoded,
  }) async {
    if (smartContractCallEncoded != null) {
      return _createUnsignedTransaction(
        receiver.toJS,
        weiAmount.toJS,
        chainInfo.toJS,
        txCreatingInfo.toJS,
        smartContractCallEncoded.toJS,
      );
    } else {
      return _createUnsignedTransaction(
        receiver.toJS,
        weiAmount.toJS,
        chainInfo.toJS,
        txCreatingInfo.toJS,
      );
    }
  }

  @override
  Future<String> getAbiEncodedSmartContractArgs(
          {required String functionSignature,
          required String parameters}) async =>
      _getAbiEncodedSmartContractArgs(functionSignature, parameters);

  @override
  Future<String> signTransactionWithMPCSignatureForEVMBlockchain({
    required String signatureData,
    required String serializedTransaction,
    required String sender,
    required String typeOfTransaction,
    required String chainInfo,
  }) async {
    return _signTransactionWithMPCSignatureForEVMBlockchain(
      signatureData,
      serializedTransaction,
      sender,
      typeOfTransaction,
      chainInfo,
    );
  }
}

@JS('EVMUtils.createUnsignedTransaction')
external String _createUnsignedTransaction(JSString receiver,
    JSNumber weiAmount, JSString chainInfo, JSString txCreatingInfo,
    [JSString? data]);

@JS('EVMUtils.getAbiEncodedSmartContractArgs')
external String _getAbiEncodedSmartContractArgs(
    String functionSignature, String parameters);

@JS('EVMUtils.signTransactionWithMPCSignature')
external String _signTransactionWithMPCSignatureForEVMBlockchain(
  String signatureData,
  String serializedTransaction,
  String sender,
  String typeOfTransaction,
  String chainInfo,
);
