import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/ethereum_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/ethereum_formater.dart';
import 'package:flutterchain/flutterchain_lib/formaters/hex_convertor.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';

class EVMRpcClient {
  final EVMNetworkClient networkClient;
  factory EVMRpcClient.defaultInstance() {
    return EVMRpcClient(
      networkClient: EVMNetworkClient(
        baseUrl: EthereumBlockChainNetworkUrls.listOfUrls.first,
        dio: Dio(),
      ),
    );
  }
  EVMRpcClient({required this.networkClient});

  Future<String> getAccountBalance(
    String adress,
  ) async {
    final res = await networkClient.postHTTP('', {
      'jsonrpc': '2.0',
      'id': 'dontcare',
      'method': 'eth_getBalance',
      'params': [adress, 'latest']
    });
    if (res.isSuccess) {
      final hexAmount = res.data['result'].toString();
      if (hexAmount == '0x0') {
        return '0.0';
      }
      final eth = EthereumFormater.convertWeiToEth(
        convertHexToDecimal(
          hexAmount.substring(2),
        ),
      );
      return eth.toString();
    } else {
      return "Error while getting balance";
    }
  }

  Future<EVMTransactionInfo> getTransactionInfo({
    required String from,
    String? to,
    String? data,
    double? amountInEth,
  }) async {
    try {
      final nonceRequest = await networkClient.postHTTP('', {
        'jsonrpc': '2.0',
        'id': 'dontcare',
        'method': 'eth_getTransactionCount',
        'params': [from, 'latest']
      });
      if (!nonceRequest.isSuccess) throw Exception('Nonce request error');

      final nonce = convertHexToDecimal(
        nonceRequest.data['result'].toString().substring(2),
      );

      final gasRequest = await networkClient.postHTTP('', {
        "jsonrpc": "2.0",
        "id": "dontcare",
        "method": "eth_gasPrice",
        "params": [],
      });

      if (!gasRequest.isSuccess) throw Exception('Gas request error');

      final gasPrice = convertHexToDecimal(
        gasRequest.data['result'].toString().substring(2),
      );

      int? maxPriorityFeePerGas;

      await networkClient.postHTTP('', {
        "jsonrpc": "2.0",
        "id": "dontcare",
        "method": "eth_maxPriorityFeePerGas",
        "params": [],
      }).then(
        (maxPriorityFeePerGasRequest) {
          if (maxPriorityFeePerGasRequest.isSuccess) {
            maxPriorityFeePerGas = convertHexToDecimal(
              maxPriorityFeePerGasRequest.data['result']
                  .toString()
                  .substring(2),
            );
          }
        },
      ).onError((error, stackTrace) {
        log("Legacy transaction will be used");
      });

      late int gasLimit;

      if (data != null) {
        final gasLimitRequest = await networkClient.postHTTP('', {
          "jsonrpc": "2.0",
          "method": "eth_estimateGas",
          "params": [
            {
              "from": from,
              "to": to,
              "data": data,
              if (amountInEth != null)
                "value": "0x" +
                    EthereumFormater.convertEthToWei(amountInEth)
                        .toRadixString(16),
            }
          ],
          "id": "dontcare"
        });

        if (!gasLimitRequest.isSuccess) {
          throw Exception('Gas limit request error');
        }

        if (gasLimitRequest.data['error'] != null) {
          throw Exception(gasLimitRequest.data['error']['message']);
        }

        gasLimit = convertHexToDecimal(
          gasLimitRequest.data['result'].toString().substring(2),
        );
      } else {
        gasLimit = 21000;
      }

      return EVMTransactionInfo(
        nonce: nonce,
        gasPrice: gasPrice,
        maxPriorityFeePerGas: maxPriorityFeePerGas,
        gasLimit: gasLimit,
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
    final res = await networkClient.postHTTP('', {
      "jsonrpc": "2.0",
      "method": "eth_sendRawTransaction",
      "params": [txhex],
      "id": "dontcare"
    });

    if (res.isSuccess) {
      if (res.data['error'] != null) {
        return BlockchainResponse(
          data: res.data['error'],
          status: BlockchainResponses.error,
        );
      }
      return BlockchainResponse(
        data: {"txHash": res.data['result']},
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

class EVMNetworkClient extends NetworkClient {
  EVMNetworkClient({required super.baseUrl, required super.dio}) {
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
