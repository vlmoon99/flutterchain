import 'dart:convert';

import 'package:bs58/bs58.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/concordium_grpc/protos/generated/types.pb.dart';
import 'package:hex/hex.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/concordium/concordium_blockchain_js_runner.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/concordium/concordium_blockchain_js_runner_interface.dart';

class ConcordiumUtils {
  final ConcordiumBlockchainJsRunner jsRunner = getConcordiumJsRunner();

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
    final value =
        await jsRunner.accountInfoFromProtoFormat(jsonEncodedAccountInfo);
    return jsonDecode(value);
  }

  Future<Map<String, dynamic>> cryptographicParametersFromProtoFormat(
      String jsonEncodedCryptographicParameters) async {
    final value = await jsRunner.cryptographicParametersFromProtoFormat(
        jsonEncodedCryptographicParameters);
    return jsonDecode(value);
  }

  Future<String> transactionHashFromProtoFormat(List<int> rawTxHash) async {
    final param = jsonEncode(rawTxHash);
    final value = await jsRunner.transactionHashFromProtoFormat(param);
    return value;
  }
}
