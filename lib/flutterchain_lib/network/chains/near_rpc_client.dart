import 'dart:developer';
import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/network/network_core.dart';
import 'dart:async';

import 'package:hex/hex.dart';

class NearRpcClient {
  final NearNetworkClient networkClient;

  NearRpcClient({required this.networkClient});

  Future<NearTransactionInfoModel> getNonceAndBlockHashInfo(
    String accountId,
    String publicKey,
  ) async {
    Uint8List hash = HEX.decode(publicKey) as Uint8List;

    final res = await networkClient.postHTTP('', {
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "query",
      "params": {
        "request_type": "view_access_key",
        "finality": "final",
        "account_id": accountId,
        "public_key": "ed25519:${base58.encode(hash)}"
      }
    });
    if (res.isSuccess) {
      final nonce = int.tryParse(res.data['result']['nonce'].toString()) ?? 0;
      final blockHash = res.data['result']['block_hash'].toString();
      return NearTransactionInfoModel(blockHash: blockHash, nonce: nonce);
    } else {
      return NearTransactionInfoModel(blockHash: '', nonce: 0);
    }
  }

  Future<String> getAccountBalance(
    String accountId,
  ) async {
    final res = await networkClient.postHTTP(
      '',
      {
        "jsonrpc": "2.0",
        "id": "dontcare",
        "method": "query",
        "params": {
          "request_type": "view_account",
          "finality": "final",
          "account_id": accountId
        }
      },
    );
    if (res.isSuccess) {
      final decodedRes = res.data['result']['amount'].toString();
      final nearAmount = NearFormatter.yoctoNearToNear(
        decodedRes,
      );
      return nearAmount;
    } else {
      return "Error while getting balance";
    }
  }

  Future<BlockchainResponse> sendAsyncTx(List<String> params) async {
    final res = await networkClient.postHTTP('', {
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "broadcast_tx_async",
      "params": params
    });
    if (res.isSuccess) {
      return BlockchainResponse(
        data: res.data['result'],
        status: 'success',
      );
    } else {
      return BlockchainResponse(
        data: {
          "error": "'Error while sending transaction'",
        },
        status: 'error',
      );
    }
  }

  Future<BlockchainResponse> sendSyncTx(List<String> params) async {
    final res = await networkClient.postHTTP('', {
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "broadcast_tx_commit",
      "params": params
    });
    if (res.isSuccess) {
      return BlockchainResponse(
        data: res.data['result'],
        status: 'success',
      );
    } else {
      return BlockchainResponse(
        data: {
          "error": "'Error while sending transaction'",
        },
        status: 'error',
      );
    }
  }
}

class NearNetworkClient extends NetworkClient {
  NearNetworkClient({required super.baseUrl, required super.dio}) {
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      logPrint: log,
      retries: 5,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 1),
        Duration(seconds: 1),
        Duration(seconds: 1),
        Duration(seconds: 1),
      ],
    ));
  }
}
