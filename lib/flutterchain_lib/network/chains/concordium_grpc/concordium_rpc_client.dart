import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/concordium_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_network_type.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/concordium_grpc/protos/generated/service.pbgrpc.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/utils/concordium_utils.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'protos/generated/types.pb.dart' as grpcTypes;
import 'package:flutterchain/flutterchain_lib/services/core/grpc_engines/get_grpc_client_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/grpc_engines/get_grpc_client_io.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/grpc_engines/get_grpc_client_web.dart';

class ConcordiumRpcClient {
  final NetworkClient concordiumNetworkClient;
  final ConcordiumGrpcConnectionClient concordiumGrpcConnectionClient;
  final ConcordiumUtils _concordiumUtils = ConcordiumUtils();
  final String typeOfNetwork;

  late final QueriesClient _queriesClient;

  ConcordiumRpcClient({
    required this.concordiumGrpcConnectionClient,
    required this.concordiumNetworkClient,
    required this.typeOfNetwork,
  }) {
    _queriesClient = QueriesClient(concordiumGrpcConnectionClient.channel);
  }

  factory ConcordiumRpcClient.defaultInstance() {
    return ConcordiumRpcClient(
      concordiumGrpcConnectionClient: ConcordiumGrpcConnectionClient(
        baseUrl: ConcordiumBlockchainNetworkUrls.listOfUrls.first,
        port: 20000,
      ),
      concordiumNetworkClient: ConcordiumNetworkClient.defaultInstance(),
      typeOfNetwork: ConcordiumNetwork.testnet,
    );
  }

  Future<String> sendCredentialDeploymentTransaction(
      {required List<int> payload, required int expiryEpochSeconds}) async {
    final rawResponse = await _queriesClient.sendBlockItem(
      grpcTypes.SendBlockItemRequest(
        credentialDeployment: grpcTypes.CredentialDeployment(
            messageExpiry:
                grpcTypes.TransactionTime(value: Int64(expiryEpochSeconds)),
            rawPayload: payload),
      ),
    );
    final txHash = await _concordiumUtils
        .transactionHashFromProtoFormat(rawResponse.value);
    return txHash;
  }

  Future<List<Map<String, dynamic>>> getIdentityProviders() async {
    late String url;
    if (typeOfNetwork == ConcordiumNetwork.mainnet) {
      url = 'https://wallet-proxy.mainnet.concordium.software';
    } else {
      url = 'https://wallet-proxy.testnet.concordium.com';
    }
    final response =
        await concordiumNetworkClient.getRequest("$url/v1/ip_info");

    return List<Map<String, dynamic>>.from(response.data);
  }

  Future<Map<String, dynamic>> getCryptographicParameters(
      [String? blockHashHex]) async {
    final grpcTypes.BlockHashInput blockHashInput = blockHashHex == null
        ? grpcTypes.BlockHashInput(
            lastFinal: grpcTypes.Empty(),
          )
        : grpcTypes.BlockHashInput(
            given: await _concordiumUtils.getBlockHash(blockHashHex),
          );

    final response =
        await _queriesClient.getCryptographicParameters(blockHashInput);

    final rawJson = response.toProto3Json();
    final unTransformedMap =
        _convertBase64InMap(Map<String, dynamic>.from(rawJson as Map));

    final result = await _concordiumUtils
        .cryptographicParametersFromProtoFormat(jsonEncode(unTransformedMap));

    return result;
  }

  Future<Map<String, dynamic>> getAccountInfo(String base58Address,
      [String? blockHashHex]) async {
    final accountAddress =
        await _concordiumUtils.getAccountAddress(base58Address);

    final grpcTypes.AccountIdentifierInput accountIdentifierInput =
        grpcTypes.AccountIdentifierInput(address: accountAddress);

    final grpcTypes.BlockHashInput blockHashInput = blockHashHex == null
        ? grpcTypes.BlockHashInput(
            lastFinal: grpcTypes.Empty(),
          )
        : grpcTypes.BlockHashInput(
            given: await _concordiumUtils.getBlockHash(blockHashHex),
          );

    final grpcTypes.AccountInfo response =
        await _queriesClient.getAccountInfo(grpcTypes.AccountInfoRequest(
      accountIdentifier: accountIdentifierInput,
      blockHash: blockHashInput,
    ));

    final rawJson = response.toProto3Json();
    final unTransformedMap =
        _convertBase64InMap(Map<String, dynamic>.from(rawJson as Map));

    // hardcoded for non-standard values
    if (unTransformedMap["amount"]["value"] is List) {
      unTransformedMap["amount"]["value"] = "0"; // hardcoded to 0
    }
    if (unTransformedMap["sequenceNumber"]["value"] is List) {
      unTransformedMap["sequenceNumber"]["value"] = "1"; // hardcoded to 1
    }

    final result = await _concordiumUtils
        .accountInfoFromProtoFormat(jsonEncode(unTransformedMap));
    return result;
  }

  Future<Map<String, dynamic>> getIdentityInfo(String url) async {
    final request = await concordiumNetworkClient.getRequest(url);
    final response = await request.data;
    if (response["status"] == "error") {
      throw Exception(response["detail"]);
    } else {
      return response["token"]["identityObject"]["value"];
    }
  }

  Future<int> getNextAccountNonce(String accountId) async {
    final accountAddress = await _concordiumUtils.getAccountAddress(accountId);
    final rawSequenceNumber =
        (await _queriesClient.getNextAccountSequenceNumber(accountAddress))
            .sequenceNumber;
    return rawSequenceNumber.value.toInt();
  }

  Future<String> sendTransaction(
      {required Map<String, dynamic> accountTransactionParams}) async {
    Map<int, grpcTypes.AccountSignatureMap> convertSignatures(Map input) {
      return input.map((key, value) {
        return MapEntry(
          int.parse(key),
          grpcTypes.AccountSignatureMap(
            signatures:
                Map.from(value['signatures'] ?? {}).map((innerKey, innerValue) {
              return MapEntry(
                int.parse(innerKey),
                grpcTypes.Signature(
                  value: List<int>.from(innerValue['value']!),
                ),
              );
            }),
          ),
        );
      });
    }

    final blockItem = grpcTypes.SendBlockItemRequest(
      accountTransaction: grpcTypes.AccountTransaction(
        header: grpcTypes.AccountTransactionHeader(
          sender: grpcTypes.AccountAddress(
              value: List<int>.from(
                  accountTransactionParams["header"]["sender"]["value"])),
          sequenceNumber: grpcTypes.SequenceNumber(
              value: Int64(accountTransactionParams["header"]["sequenceNumber"]
                  ["value"])),
          energyAmount: grpcTypes.Energy(
              value: Int64(
                  accountTransactionParams["header"]["energyAmount"]["value"])),
          expiry: grpcTypes.TransactionTime(
              value:
                  Int64(accountTransactionParams["header"]["expiry"]["value"])),
        ),
        signature: grpcTypes.AccountTransactionSignature(
          signatures: convertSignatures(
              Map.from(accountTransactionParams["signature"]["signatures"])),
        ),
        payload: grpcTypes.AccountTransactionPayload(
          rawPayload:
              List.from(accountTransactionParams["payload"]["rawPayload"]),
        ),
      ),
    );

    final rawResponse = await _queriesClient.sendBlockItem(
      blockItem,
    );

    final txHash = await _concordiumUtils
        .transactionHashFromProtoFormat(rawResponse.value);

    return txHash;
  }

  Future<Map<String, dynamic>> getTransactionStatus(
      {required String transactionHash}) async {
    final rawResponse = await _queriesClient.getBlockItemStatus(
        await _concordiumUtils.getTransactionHash(transactionHash));
    final rawJson = rawResponse.toProto3Json();
    final unTransformedMap =
        _convertBase64InMap(Map<String, dynamic>.from(rawJson as Map));
    final outcome = unTransformedMap.values.first?["outcome"]?["outcome"] ?? {};
    return {
      "status": rawResponse.whichStatus().name,
      "data": Map<String, dynamic>.from(outcome)
    };
  }

  Map<String, dynamic> _convertBase64InMap(Map<String, dynamic> inputMap) {
    inputMap.forEach((key, value) {
      if (value is String) {
        try {
          // Attempt to decode the Base64 string
          List<int> decoded = base64Decode(value);
          inputMap[key] = decoded;
        } catch (e) {
          // If decoding fails, the value is not a Base64 string, leave it as is
        }
      } else if (value is Map<String, dynamic>) {
        // Recursively process nested maps
        _convertBase64InMap(value);
      } else if (value is List) {
        // Process lists within the map
        for (var element in value) {
          if (element is Map<String, dynamic>) {
            _convertBase64InMap(element);
          } else if (element is String) {
            try {
              // Attempt to decode the Base64 string
              List<int> decoded = base64Decode(element);
              value[value.indexOf(element)] = decoded;
            } catch (e) {
              // If decoding fails, the value is not a Base64 string, leave it as is
            }
          }
        }
      }
    });
    return inputMap;
  }
}

class ConcordiumGrpcConnectionClient {
  late final ClientChannelBase channel;
  final String baseUrl;
  final int port;
  final ChannelOptions? options;

  ConcordiumGrpcConnectionClient({
    required this.baseUrl,
    required this.port,
    this.options,
  }) {
    channel = getGrpcClient(baseUrl: baseUrl, port: port, options: options);
    channel.createConnection();
  }
}

class ConcordiumNetworkClient extends NetworkClient {
  ConcordiumNetworkClient({super.dio, required super.baseUrl}) {
    super.dio.interceptors.add(
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

  factory ConcordiumNetworkClient.defaultInstance() {
    return ConcordiumNetworkClient(
      baseUrl: '',
      dio: Dio(),
    );
  }
}
