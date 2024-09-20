import 'dart:developer' as dev;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/xrp_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/xrp_formatter.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/xrp/xrp_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';

class XRPRpcClient {
  final XRPNetworkClient networkClient;
  factory XRPRpcClient.defaultInstance() {
    return XRPRpcClient(
      networkClient: XRPNetworkClient(
        baseUrl: XRPBlockChainNetworkUrls.listOfUrls.first,
        dio: Dio(),
      ),
    );
  }
  XRPRpcClient({required this.networkClient});

  Future<Map<String, dynamic>> getAccountInfo(String address) async {
    final res = await networkClient.postHTTP('', {
      "method": "account_info",
      "params": [
        {
          "account": address,
          "strict": true,
          "ledger_index": "current",
          "queue": true
        }
      ],
      "id": "dontcare",
      "jsonrpc": "2.0",
    });
    if (res.isSuccess && res.data['result']['error'] == null) {
      return res.data['result'];
    } else {
      throw res.data;
    }
  }

  Future<String> getAccountBalance(
    String address,
  ) async {
    try {
      final accountData = await getAccountInfo(address);
      final amountInDrops = accountData['account_data']['Balance'] as String;
      final amountInXrp = XrpFormatter.dropsToXrp(int.parse(amountInDrops));
      return amountInXrp.toString();
    } catch (err) {
      if (err is Map) {
        if (err['result']['error'] == 'actNotFound') {
          return '0';
        } else {
          throw Exception(err['result']["error_message"]);
        }
      }
      rethrow;
    }
  }

  Future<XRPTransactionInfo> getTransactionInfo(
    String address,
  ) async {
    final serverInfoRequest = await networkClient.postHTTP('', {
      "method": "server_info",
      "params": [{}],
      "id": "dontcare",
      "jsonrpc": "2.0"
    });
    final serverInfo = serverInfoRequest.data['result']['info'] as Map;
    late Map<String, dynamic> accountData;
    try {
      accountData = await getAccountInfo(address);
    } catch (err) {
      if (err is Map) {
        throw Exception(err['result']["error_message"]);
      }
      rethrow;
    }

    final networkId = serverInfo['network_id'] as int;

    final sequence = accountData['account_data']['Sequence'] as int;

    //Fee calculation

    final baseFee = serverInfo["validated_ledger"]["base_fee_xrp"] as double;

    final serverLoadFactor = serverInfo["load_factor"] ?? 1;
    const feeCushion = 1.2;

    double fee = baseFee * serverLoadFactor * feeCushion;
    const maxFeeXRP = 2.0;

    fee = min(fee, maxFeeXRP);

    final String feeString =
        XrpFormatter.xrpToDrops(double.parse(fee.toStringAsFixed(6)))
            .toString();

    // LatestValidatedLedgerSequence calculation

    final ledgerSequenceRequest = await networkClient.postHTTP('', {
      "method": "ledger",
      "params": [
        {
          "ledger_index": "validated",
          "transactions": false,
          "expand": false,
          "owner_funds": false
        }
      ]
    });

    final ledgerIndex =
        ledgerSequenceRequest.data['result']['ledger_index'] as int;
    const ledgerOffset = 20;
    final lastLedgerSequence = ledgerIndex + ledgerOffset;

    return XRPTransactionInfo(
      lastLedgerSequence: lastLedgerSequence,
      fee: feeString,
      sequence: sequence,
      networkId: networkId,
    );
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
    final res = await networkClient.postHTTP('', {
      "method": "submit",
      "params": [
        {"tx_blob": txhex}
      ]
    });

    if (res.isSuccess) {
      return BlockchainResponse(
        data: {"txHash": res.data['result']['tx_json']['hash']},
        status: BlockchainResponses.success,
      );
    } else {
      return BlockchainResponse(
        data: res.data,
        status: BlockchainResponses.error,
      );
    }
  }
}

class XRPNetworkClient extends NetworkClient {
  XRPNetworkClient({required super.baseUrl, required super.dio}) {
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: dev.log,
        retries: 5,
        retryDelays: const [
          Duration(seconds: 2),
          Duration(seconds: 1),
          Duration(seconds: 1),
          Duration(seconds: 1),
          Duration(seconds: 1),
        ],
      ),
    );
  }
}
