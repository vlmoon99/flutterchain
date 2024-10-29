import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bnb_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/ethereum_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/evm_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/evm/evm_blockchain_js_runner.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/evm/evm_blockchain_js_runner_interface.dart';

class BNBBlockChainService implements BlockChainService {
  final EvmBlockChainJSRunner jsRunner = getEVMJsRunner();
  final EVMRpcClient bnbRpcClient;

  BNBBlockChainService({
    required this.bnbRpcClient,
  });

  factory BNBBlockChainService.defaultInstance() {
    return BNBBlockChainService(
      bnbRpcClient: EVMRpcClient(
        networkClient: EVMNetworkClient(
          baseUrl: BNBBlockChainNetworkUrls.listOfUrls.first,
          dio: Dio(),
        ),
      ),
    );
  }

  Future<EVMTransactionInfo> getTransactionInfo({
    required String from,
    String? to,
    String? data,
    double? amountInEth,
  }) async {
    final res = await bnbRpcClient.getTransactionInfo(
      from: from,
      to: to,
      data: data,
      amountInEth: amountInEth,
    );
    return res;
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
  Future<BlockChainNetworkEnvironmentSettings>
      getBlockchainNetworkEnvironment() {
    // TODO: implement getBlockchainNetworkEnvironment
    throw UnimplementedError();
  }

  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return BNBBlockChainNetworkUrls.listOfUrls;
  }

  @override
  Future<String> getWalletBalance(AccountInfoRequest accountInfoRequest) {
    if (accountInfoRequest is! EvmAccountInfoRequest) {
      throw ArgumentError(
          "Invalid accountInfoRequest type. Expected: `EvmAccountInfoRequest`");
    }
    return bnbRpcClient.getAccountBalance(accountInfoRequest.accountId);
  }

  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) {
    // TODO: implement sendTransferNativeCoin
    throw UnimplementedError();
  }

  @override
  Future<void> setBlockchainNetworkEnvironment(
      BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings) async {
    if (blockChainNetworkEnvironmentSettings
        is! EvmNetworkEnvironmentSettings) {
      throw ArgumentError(
          "Invalid blockChainNetworkEnvironmentSettings type. Expected: `EvmNetworkEnvironmentSettings`");
    }
    bnbRpcClient.networkClient
        .setUrl(blockChainNetworkEnvironmentSettings.chainUrl);
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
    final chainId = typeOfNetwork == "testnet" ? 97 : 56;
    final Map<String, dynamic> chainInfo = {
      "name": "bnb",
      "chainId": chainId,
    };
    final unsignedTransactionData = await jsRunner.createUnsignedTransaction(
      receiver: receiverAddress,
      weiAmount: amountInWei,
      chainInfo: jsonEncode(chainInfo),
      txCreatingInfo: jsonEncode(transactionInfo),
      smartContractCallEncoded: smartContractCallEncoded,
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
    return jsRunner.getAbiEncodedSmartContractArgs(
      functionSignature: cleanedFunctionSignature,
      parameters: jsonEncode(parameters),
    );
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
    final res = await bnbRpcClient.sendTransaction(txhex);
    return res;
  }
}
