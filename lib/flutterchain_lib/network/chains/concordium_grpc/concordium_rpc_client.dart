import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/concordium_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/concordium_grpc/protos/generated/service.pbgrpc.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/utils/concordium_utils.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:hex/hex.dart';
import 'protos/generated/types.pb.dart';
import 'package:flutterchain/flutterchain_lib/services/core/grpc_engines/get_grpc_client_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/grpc_engines/get_grpc_client_io.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/grpc_engines/get_grpc_client_web.dart';

class ConcordiumRpcClient {
  final ConcordiumNetworkClient concordiumNetworkClient;
  final ConcordiumUtils _concordiumUtils = ConcordiumUtils();

  late final QueriesClient _queriesClient;

  ConcordiumRpcClient({required this.concordiumNetworkClient}) {
    _queriesClient = QueriesClient(concordiumNetworkClient.channel);
  }

  factory ConcordiumRpcClient.defaultInstance() {
    return ConcordiumRpcClient(
      concordiumNetworkClient: ConcordiumNetworkClient(
        baseUrl: ConcordiumBlockchainNetworkUrls.listOfUrls.first,
        port: 20000,
        dio: Dio(),
      ),
    );
  }

  Future<String> sendCredentialDeploymentTransaction(
      {required List<int> payload, required int expiryEpochSeconds}) async {
    final rawResponse = await _queriesClient.sendBlockItem(
      SendBlockItemRequest(
        credentialDeployment: CredentialDeployment(
            messageExpiry: TransactionTime(value: Int64(expiryEpochSeconds)),
            rawPayload: payload),
      ),
    );
    final txHash = await _concordiumUtils
        .transactionHashFromProtoFormat(rawResponse.value);
    return txHash;
  }

  Future<List<Map<String, dynamic>>> getIdentityProviders(
      [String network = "Testnet"]) async {
    late String url;
    if (network == "Mainnet") {
      url = 'https://wallet-proxy.mainnet.concordium.software';
    } else {
      url = 'https://wallet-proxy.testnet.concordium.com';
    }
    final respose = await concordiumNetworkClient.dio.get("$url/v1/ip_info");

    return List<Map<String, dynamic>>.from(respose.data);
  }

  Future<Map<String, dynamic>> getCryptographicParameters(
      [String? blockHashHex]) async {
    final BlockHashInput blockHashInput = blockHashHex == null
        ? BlockHashInput(
            lastFinal: Empty(),
          )
        : BlockHashInput(
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

    final AccountIdentifierInput accountIdentifierInput =
        AccountIdentifierInput(address: accountAddress);

    final BlockHashInput blockHashInput = blockHashHex == null
        ? BlockHashInput(
            lastFinal: Empty(),
          )
        : BlockHashInput(
            given: await _concordiumUtils.getBlockHash(blockHashHex),
          );

    final AccountInfo response =
        await _queriesClient.getAccountInfo(AccountInfoRequest(
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
    final request = await concordiumNetworkClient.dio.get(url);
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
    Map<int, AccountSignatureMap> convertSignatures(Map input) {
      return input.map((key, value) {
        return MapEntry(
          int.parse(key),
          AccountSignatureMap(
            signatures:
                Map.from(value['signatures'] ?? {}).map((innerKey, innerValue) {
              return MapEntry(
                int.parse(innerKey),
                Signature(
                  value: List<int>.from(innerValue['value']!),
                ),
              );
            }),
          ),
        );
      });
    }

    final blockItem = SendBlockItemRequest(
      accountTransaction: AccountTransaction(
        header: AccountTransactionHeader(
          sender: AccountAddress(
              value: List<int>.from(
                  accountTransactionParams["header"]["sender"]["value"])),
          sequenceNumber: SequenceNumber(
              value: Int64(accountTransactionParams["header"]["sequenceNumber"]
                  ["value"])),
          energyAmount: Energy(
              value: Int64(
                  accountTransactionParams["header"]["energyAmount"]["value"])),
          expiry: TransactionTime(
              value:
                  Int64(accountTransactionParams["header"]["expiry"]["value"])),
        ),
        signature: AccountTransactionSignature(
          signatures: convertSignatures(
              Map.from(accountTransactionParams["signature"]["signatures"])),
        ),
        payload: AccountTransactionPayload(
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

class ConcordiumNetworkClient {
  late final ClientChannelBase channel;
  final String baseUrl;
  final int port;
  final ChannelOptions? options;
  final Dio dio;

  ConcordiumNetworkClient({
    required this.baseUrl,
    required this.port,
    this.options,
    required this.dio,
  }) {
    channel = getGrpcClient(baseUrl: baseUrl, port: port, options: options);
    channel.createConnection();
  }
}
