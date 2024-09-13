import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/avalanche_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/ethereum_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/ethereum_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/evm_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';

/// Avalanche C-Chain BlockChain Service
class AvalancheBlockChainService implements BlockChainService {
  final JsVMService jsVMService;
  final EVMRpcClient avalancheRpcClient;

  AvalancheBlockChainService({
    required this.jsVMService,
    required this.avalancheRpcClient,
  });

  factory AvalancheBlockChainService.defaultInstance() {
    return AvalancheBlockChainService(
      jsVMService: getJsVM(),
      avalancheRpcClient: EVMRpcClient(
        networkClient: EVMNetworkClient(
          baseUrl: AvalancheBlockChainNetworkUrls.listOfUrls.first,
          dio: Dio(),
        ),
      ),
    );
  }

  Future<EVMTransactionInfo> getTransactionInfo({
    required String from,
    String? to,
    String? data,
    double? amountInAvax,
  }) async {
    final res = await avalancheRpcClient.getTransactionInfo(
      from: from,
      to: to,
      data: data,
      amountInEth: amountInAvax,
    );
    return res;
  }

  @override
  Future<BlockchainResponse> callSmartContractFunction(
      TransferRequest transferRequest) {
    throw UnimplementedError('callSmartContractFunction does not exist.');
  }

  @override
  Future<BlockChainData> getBlockChainData({
    required String mnemonic,
    String? passphrase,
    DerivationPathData? derivationPath,
  }) {
    // TODO: implement getBlockChainData
    throw UnimplementedError();
  }

  @override
  Future<String> getBlockchainNetworkEnvironment() {
    // TODO: implement getBlockchainNetworkEnvironment
    throw UnimplementedError();
  }

  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return EthereumBlockChainNetworkUrls.listOfUrls;
  }

  @override
  Future<String> getWalletBalance(TransferRequest transferRequest) {
    return avalancheRpcClient.getAccountBalance(transferRequest.accountID!);
  }

  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) {
    // TODO: implement sendTransferNativeCoin
    throw UnimplementedError();
  }

  @override
  Future<void> setBlockchainNetworkEnvironment({required String newUrl}) async {
    avalancheRpcClient.networkClient.setUrl(newUrl);
  }

  //MPC Feature

  /// Create payload for Near MPC using Ethereum data
  ///
  /// The receiver address is the address of the recipient of the transaction.
  /// The amount is the amount of ETH to send.
  /// The transaction info is the necessary information to create an unsigned transaction.
  /// The smart contract call encoded is the encoded smart contract call.
  /// The type of network is the network type (testnet or mainnet).
  Future<MpcTransactionInfo> createPayloadForNearMPC({
    required String receiverAddress,
    required double amount,
    required EVMTransactionInfo transactionInfo,
    String? smartContractCallEncoded,
    String typeOfNetwork = "testnet",
  }) async {
    final amountInWei = EthereumFormater.convertEthToWei(amount);
    final chainId = typeOfNetwork == "testnet" ? 43113 : 43114;
    final Map<String, dynamic> chainInfo = {
      "name": "avalanche",
      "chainId": chainId,
    };

    final unsignedTransactionData = await jsVMService.callJS(
      """window.EVMUtils.createUnsignedTransaction('$receiverAddress', $amountInWei, 
      '${jsonEncode(chainInfo)}', '${jsonEncode(transactionInfo)}', 
       ${smartContractCallEncoded != null ? """'$smartContractCallEncoded'""" : 'undefined'} )""",
    );

    final unsignedTransaction =
        json.decode(unsignedTransactionData) as Map<String, dynamic>;
    return MpcTransactionInfo(transactionInfo: unsignedTransaction);
  }

  /// Encode the smart contract call using the ABI (Application Binary Interface)
  ///
  /// The function signature is a string that represents the function name and its parameters.
  /// For example: 'transfer(address,uint256)'
  ///
  /// The parameters are list of values that are passed to the function.
  /// For example: ['0x1234567890', 100]
  ///
  /// Returns a string that is the encoded smart contract call
  Future<String> encodeSmartContractCall({
    required String functionSignature,
    List<dynamic> parameters = const [],
  }) async {
    final cleanedFunctionSignature = functionSignature.replaceAll(' ', '');
    return await jsVMService.callJS(
        """window.EVMUtils.getAbiEncodedSmartContractArgs('$cleanedFunctionSignature', '${jsonEncode(parameters)}' )""");
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
    final res = await avalancheRpcClient.sendTransaction(txhex);
    return res;
  }
}
