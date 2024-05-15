import 'dart:convert';
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
      String accountID, String transferAmount, int actuelFees) async {
    final res = await networkClient.getRequest(
      BitcoinBlockChainNetworkUrls.listOfUrls.first +
          '/addrs/$accountID?unspentOnly=true',
    );
    if (res.isSuccess) {
      num currentSum = 0;
      var indexWhithBigestSum = 0;
      List<dynamic> listWithTXrefs = res.data['txrefs'];
      for (int i = 0; i < listWithTXrefs.length; i++) {
        if (currentSum < listWithTXrefs[i]['value']) {
          currentSum = listWithTXrefs[i]['value'];
          indexWhithBigestSum = i;
        }
      }
      if (currentSum > num.parse(transferAmount) + actuelFees * 200) {
        final tx_hash =
            listWithTXrefs[indexWhithBigestSum]['tx_hash'].toString();
        final ref_balance =
            listWithTXrefs[indexWhithBigestSum]['value'].toString();
        final tx_output = int.tryParse(listWithTXrefs[indexWhithBigestSum]
                    ['tx_output_n']
                .toString()) ??
            0;
        final data = {
          "tx_hash": tx_hash,
          "ref_balance": num.parse(ref_balance),
          "tx_output": tx_output
        };
        List<dynamic> listData = [data];
        return BitcoinTransactionInfoModel(data: listData);
      } else {
        List<dynamic> listData = [];
        for (int i = 0; i < listWithTXrefs.length; i++) {
          final tx_hash = listWithTXrefs[i]['tx_hash'].toString();
          final ref_balance = listWithTXrefs[i]['value'].toString();
          final tx_output =
              int.tryParse(listWithTXrefs[i]['tx_output_n'].toString()) ?? 0;
          final data = {
            "tx_hash": tx_hash,
            "ref_balance": num.parse(ref_balance),
            "tx_output": tx_output
          };
          listData.add(data);
        }
        return BitcoinTransactionInfoModel(data: listData);
      }
    } else {
      return BitcoinTransactionInfoModel(data: [
        {'tx_hash': '', 'ref_balance': '', 'tx_output': 0}
      ]);
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

  Future<String> getAccountBalanceWithAdress(String adress,
      [bool testNetwork = true]) async {
    final utxos = await getUTXOs(address: adress, testNetwork: testNetwork);
    int satoshis = 0;

    for (var utxo in utxos) {
      satoshis += utxo["value"] as int;
    }

    final bitcoinAmount =
        BitcoinFormatter.satoshiToBitcoin(satoshis.toString());
    return bitcoinAmount;
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

  Future<List<Map<String, dynamic>>> getUTXOs(
      {required String address, bool testNetwork = true}) async {
    final res = await networkClient.getRequest(
        "https://blockstream.info${testNetwork ? '/testnet' : ''}/api/address/$address/utxo");

    if (res.isSuccess) {
      return List<Map<String, dynamic>>.from(res.data);
    } else {
      throw Exception(res.data);
    }
  }

  Future<double> getFeeRate({bool testNetwork = true}) async {
    final res = await networkClient.getRequest(
        'https://blockstream.info${testNetwork ? '/testnet' : ''}/api/fee-estimates');
    if (res.isSuccess) {
      return res.data['6'];
    } else {
      throw Exception(res.data);
    }
  }

  Future<Map<String, dynamic>> getExecutedTxData(
      {required String txHash, bool testNetwork = true}) async {
    final res = await networkClient.getRequest(
        "https://blockstream.info${testNetwork ? '/testnet' : ''}/api/tx/$txHash");
    if (res.isSuccess) {
      return res.data;
    } else {
      throw Exception(res.data);
    }
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
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
