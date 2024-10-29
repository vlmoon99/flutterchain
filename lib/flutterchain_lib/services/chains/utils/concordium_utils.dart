import 'dart:convert';

import 'package:bs58/bs58.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/concordium_grpc/protos/generated/types.pb.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:hex/hex.dart';

class ConcordiumUtils {
  late final JsVMService _jsVMService;

  ConcordiumUtils() {
    _jsVMService = getJsVM();
  }

  Future<AccountAddress> getAccountAddress(String base58Address) async {
    final decodedBase58Address = base58.decode(base58Address).sublist(1, 33);
    return AccountAddress(value: List<int>.from(decodedBase58Address));
  }

  Future<BlockHash> getBlockHash(String blockHash) async {
    return BlockHash(value: const HexDecoder().convert(blockHash));
  }

  Future<TransactionHash> getTransactionHash(String txHash) async {
    return TransactionHash(value: const HexDecoder().convert(txHash));
  }

  Future<Map<String, dynamic>> accountInfoFromProtoFormat(
      String jsonEncodedAccountInfo) async {
    final param = jsonEncode(jsonEncodedAccountInfo);
    final value = await _jsVMService.callJS(
        '''window.ConcordiumBlockchain.accountInfoFromProtoFormat($param)''');
    return jsonDecode(value);
  }

  Future<Map<String, dynamic>> cryptographicParametersFromProtoFormat(
      String jsonEncodedCryptographicParameters) async {
    final param = jsonEncode(jsonEncodedCryptographicParameters);
    final value = await _jsVMService.callJS(
        '''window.ConcordiumBlockchain.cryptographicParametersFromProtoFormat($param)''');
    return jsonDecode(value);
  }

  Future<String> transactionHashFromProtoFormat(List<int> rawTxHash) async {
    final param = jsonEncode(rawTxHash);
    final value = await _jsVMService.callJS(
        "window.ConcordiumBlockchain.transactionHashFromProtoFormat('$param')");
    return value;
  }
}
