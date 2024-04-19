import 'dart:developer';
import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bitcoin_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/bitcoin_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';
import 'dart:async';
import 'package:hex/hex.dart';

class BitcoinRpcClient {
  final BitcoinNetworkClient networkClient;

  factory BitcoinRpcClient.defaultInstance() {
    return BitcoinRpcClient(
      networkClient: BitcoinNetworkClient(
        baseUrl: BitcoinBlockChainNetworkUrls.listOfUrls.first,
        dio: Dio(),
      ),
    );
  }
  BitcoinRpcClient({required this.networkClient});

  Future<BitcoinTransactionInfoModel> getTransactionInfo(
    String accountID,
  ) async {
    final res = await networkClient.getRequest(
      BitcoinBlockChainNetworkUrls.listOfUrls.first +
          '/addrs/$accountID?unspentOnly=true',
    );
    if (res.isSuccess) {
      final tx_hash = res.data['txrefs'][0]['tx_hash'].toString();
      final ref_balance = res.data['txrefs'][0]['ref_balance'].toString();
      final tx_output =
          int.tryParse(res.data['txrefs'][0]['tx_output_n'].toString()) ?? 0;
      return BitcoinTransactionInfoModel(
          tx_hash: tx_hash, ref_balance: ref_balance, tx_output: tx_output);
    } else {
      return BitcoinTransactionInfoModel(
          tx_hash: '', ref_balance: '', tx_output: 0);
    }
  }

  Future<String> getAccountBalance(
    String adressId,
  ) async {
    final res = await networkClient.getRequest(
      BitcoinBlockChainNetworkUrls.listOfUrls.first +
          '/addrs/$adressId/balance',
    );
    if (res.isSuccess) {
      final amount = res.data['balance'].toString();
      if (int.parse(amount) == 0) {
        return amount;
      }
      final bitcoinAmount = BitcoinFormatter.satoshiToBitcoin(amount);
      return bitcoinAmount;
    } else {
      return "Error while getting balance";
    }
  }

  Future<BlockchainResponse> sendTransferNativeCoinTest(String txhex) async {
    final res = await networkClient.postHTTP(
        BitcoinBlockChainNetworkUrls.listOfUrls.first + '/txs/decode',
        {'tx': txhex});
    if (res.data['error'] != null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    }
    return BlockchainResponse(
      data: {"data": res.data},
      status: BlockchainResponses.success,
    );
  }

  Future<BlockchainResponse> getActualPricesFeeSAll() async {
    final res = await networkClient
        .getRequest('https://mempool.space/api/v1/fees/recommended');
    if (res.data['error'] != null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    }
    return BlockchainResponse(
      data: {"data": res.data},
      status: BlockchainResponses.success,
    );
  }

  Future<int> getActualPricesFeeSHigher() async {
    final res = await networkClient
        .getRequest('https://mempool.space/api/v1/fees/recommended');
    if (res.isSuccess) {
      final tx_hash = res.data['fastestFee'] + 7;
      return tx_hash!;
    } else {
      return 0;
    }
  }

  Future<BlockchainResponse> sendTransferNativeCoin(String txhex) async {
    final res = await networkClient.postHTTP(
        BitcoinBlockChainNetworkUrls.listOfUrls.first + '/txs/push',
        {'tx': txhex});
    print(res.data);
    if (res.data['error'] != null || res.data == null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    }
    return BlockchainResponse(
      data: {"data": res.data},
      status: BlockchainResponses.success,
    );
  }
}

class BitcoinNetworkClient extends NetworkClient {
  BitcoinNetworkClient({required super.baseUrl, required super.dio}) {
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: log,
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
