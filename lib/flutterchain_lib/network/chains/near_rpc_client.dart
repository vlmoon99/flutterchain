import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bs58/bs58.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';
import 'dart:async';
import 'package:hex/hex.dart';
import 'package:http_parser/http_parser.dart';

class NearRpcClient {
  final NearNetworkClient networkClient;

  factory NearRpcClient.defaultInstance() {
    return NearRpcClient(
      networkClient: NearNetworkClient(
        baseUrl: NearBlockChainNetworkUrls.listOfUrls.first,
        dio: Dio(),
      ),
    );
  }
  NearRpcClient({required this.networkClient});

  Future<NearTransactionInfoModel> getTransactionInfo(
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

  Future<BlockchainResponse> callViewMethod({
    required String contractId,
    required String method,
    Map<String, dynamic> args = const {},
  }) async {
    final res = await networkClient.postHTTP("", {
      'jsonrpc': '2.0',
      'id': 'dontcare',
      'method': 'query',
      'params': {
        'request_type': 'call_function',
        'finality': 'final',
        'account_id': contractId,
        'method_name': method,
        'args_base64': NearFormatter.argstobase64Args(args),
      },
    });

    if (res.isSuccess) {
      if (res.data['error'] != null || res.data['result']['error'] != null) {
        return BlockchainResponse(
          data: res.data['error'] ?? res.data['result']['error'],
          status: BlockchainResponses.error,
        );
      }

      final decodedResponse = NearFormatter.decodeViewCallResponse(
          List<int>.from(res.data['result']?['result']));

      return BlockchainResponse(
        data: {"response": decodedResponse},
        status: BlockchainResponses.success,
      );
    } else {
      return BlockchainResponse(
        data: {
          "error": res.data,
        },
        status: BlockchainResponses.error,
      );
    }
  }

  Future<BlockchainResponse> sendAsyncTx(List<String> params) async {
    final res = await networkClient.postHTTP('', {
      "jsonrpc": "2.0",
      "id": "dontcare",
      "method": "broadcast_tx_async",
      "params": params
    });
    if (res.data['error'] != null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    }

    String? transactionHash = res.data['result']['transaction']['hash'];
    String response = res.data['result']['status']['SuccessValue'] != null
        ? NearFormatter.decodeResultOfTransactionResponse(
            res.data['result']['status']['SuccessValue'].toString())
        : "no data in response";
    final String? functionCallError = res.data['result']['status']['Failure']
        ['ActionError']['kind']['FunctionCallError']['ExecutionError'];

    if (res.isSuccess && functionCallError == null) {
      return BlockchainResponse(
        data: {
          "txHash": transactionHash,
          "response": response,
        },
        status: BlockchainResponses.success,
      );
    } else {
      return BlockchainResponse(
        data: {
          "txHash": transactionHash,
          "error": functionCallError,
        },
        status: BlockchainResponses.error,
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
    if (res.data['error'] != null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    }

    String? transactionHash = res.data['result']['transaction']['hash'];
    String response = res.data['result']['status']['SuccessValue'] != null
        ? NearFormatter.decodeResultOfTransactionResponse(
            res.data['result']['status']['SuccessValue'].toString())
        : "no data in response";
    final String? functionCallError = res.data?['result']?['status']?['Failure']
        ?['ActionError']?['kind']?['FunctionCallError']?['ExecutionError'];
    final String? executionError = res.data?['result']?['status']?['Failure']
        ?['ActionError']?['kind']?['FunctionCallError']?['MethodResolveError'];

    if (res.isSuccess && functionCallError == null && executionError == null) {
      return BlockchainResponse(
        data: {
          "txHash": transactionHash,
          "success": response,
        },
        status: BlockchainResponses.success,
      );
    } else {
      return BlockchainResponse(
        data: {
          "txHash": transactionHash,
          "error": functionCallError ?? executionError,
        },
        status: BlockchainResponses.error,
      );
    }
  }

  Future<BlockchainResponse> mintBaseRPCInteractions(
      {required String query}) async {
    var uri = "";
    if (networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      uri = NearBlockChainNetworkUrls.listOfUrlsMintbase.first;
    } else {
      uri = NearBlockChainNetworkUrls.listOfUrlsMintbase.last;
    }

    final heders = {"mb-api-key": "anon", "content-type": "application/json"};

    final res = await networkClient.postHTTP(uri,
        {"query": query, "variables": {}, "operationName": "MyQuery"}, heders);

    if (res.data['error'] != null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    } else {
      return BlockchainResponse(
          data: res.data, status: BlockchainResponses.success);
    }
  }

  Future<BlockchainResponse> uploadFileToArweave({required File file}) async {
    int maxSize = 31457280;
    FormData formData;
    if (await file.length() > maxSize) {
      throw Exception("The file size should be up to 30MB");
    }

    String uri = 'https://ar.mintbase.xyz';

    Map<String, dynamic> heders = {"mb-api-key": "anon"};

    String fileFormat = checkFileFormat(filePath: file.path);

    switch (fileFormat) {
      case "pdf":
        formData = await createFormData(
            filePath: file.path, mediaType: "application/pdf");
      case "png":
        formData =
            await createFormData(filePath: file.path, mediaType: "image/png");
      case "jpg":
        formData =
            await createFormData(filePath: file.path, mediaType: "image/jpg");
      case "jpeg":
        formData =
            await createFormData(filePath: file.path, mediaType: "image/jpeg");
      case "gif":
        formData =
            await createFormData(filePath: file.path, mediaType: "image/gif");
      case "zip":
        formData = await createFormData(
            filePath: file.path, mediaType: "application/zip");
      case "ogg":
        formData =
            await createFormData(filePath: file.path, mediaType: "audio/ogg");
      case "mp3":
        formData =
            await createFormData(filePath: file.path, mediaType: "audio/mp3");
      case "mpeg":
        formData =
            await createFormData(filePath: file.path, mediaType: "audio/mpeg");
      case "webm":
        formData =
            await createFormData(filePath: file.path, mediaType: "video/webm");
      case "mp4":
        formData =
            await createFormData(filePath: file.path, mediaType: "video/mp4");
      case "gltf-binar":
        formData = await createFormData(
            filePath: file.path, mediaType: "model/gltf-binar");
      case "octet-stream":
        formData = await createFormData(
            filePath: file.path, mediaType: "application/octet-stream");
      default:
        throw Exception("This is format file doesn`t supported");
    }

    final res = await networkClient.postHTTP(uri, formData, heders);

    if (res.data['error'] != null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    } else {
      return BlockchainResponse(
          data: res.data, status: BlockchainResponses.success);
    }
  }

  Future<FormData> createFormData(
      {required String filePath, required String mediaType}) async {
    return FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath,
          contentType: MediaType.parse(mediaType), filename: "file"),
    });
  }

  String checkFileFormat({required String filePath}) {
    List<String> pathList =
        filePath.split("/").map((tag) => tag.trim()).toList();
    List<String> nameFormatFile =
        pathList.last.split(".").map((toch) => toch.trim()).toList();
    return nameFormatFile.last;
  }

  Future<BlockchainResponse> uploadReferenceToArweave(
      {required Map<String, dynamic> reference}) async {
    Map<String, dynamic> finalRefetence = {};
    reference.forEach((key, value) {
      if (value != null) {
        finalRefetence[key] = value;
      }
    });

    FormData formData = FormData.fromMap(finalRefetence);

    final uri = 'https://ar.mintbase.xyz/reference';

    Map<String, dynamic> heders = {"mb-api-key": "anon"};

    final res = await networkClient.postHTTP(uri, formData, heders);

    if (res.data['error'] != null) {
      return BlockchainResponse(
        data: res.data['error'],
        status: BlockchainResponses.error,
      );
    } else {
      return BlockchainResponse(
          data: res.data, status: BlockchainResponses.success);
    }
  }
}

class NearNetworkClient extends NetworkClient {
  NearNetworkClient({required super.baseUrl, required super.dio}) {
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
