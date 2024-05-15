import 'dart:convert';
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

class EthereumBlockChainService implements BlockChainService {
  final JsVMService jsVMService;
  final EVMRpcClient ethereumRpcClient;

  EthereumBlockChainService({
    required this.jsVMService,
    required this.ethereumRpcClient,
  });

  factory EthereumBlockChainService.defaultInstance() {
    return EthereumBlockChainService(
      jsVMService: getJsVM(),
      ethereumRpcClient: EVMRpcClient.defaultInstance(),
    );
  }

  Future<EVMTransactionInfo> getTransactionInfo(String accountID) async {
    final res = await ethereumRpcClient.getTransactionInfo(accountID);
    return res;
  }

  @override
  Future<BlockchainResponse> callSmartContractFunction(
      TransferRequest transferRequest) {
    throw UnimplementedError('callSmartContractFunction does not exist.');
  }

  @override
  Future<BlockChainData> getBlockChainDataByDerivationPath(
      {required String mnemonic,
      required String? passphrase,
      required DerivationPath derivationPath}) {
    // TODO: implement getBlockChainDataByDerivationPath
    throw UnimplementedError();
  }

  @override
  Future<BlockChainData> getBlockChainDataFromMnemonic(
      String mnemonic, String passphrase) {
    // TODO: implement getBlockChainDataFromMnemonic
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
    return ethereumRpcClient.getAccountBalance(transferRequest.accountID!);
  }

  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) {
    // TODO: implement sendTransferNativeCoin
    throw UnimplementedError();
  }

  @override
  Future<void> setBlockchainNetworkEnvironment({required String newUrl}) async {
    ethereumRpcClient.networkClient.setUrl(newUrl);
  }

  //MPC Feature

  Future<MpcTransactionInfo> createPayloadForNearMPC({
    required String receiverAddress,
    required double amount,
    required EVMTransactionInfo transactionInfo,
    String typeOfNetwork = "testnet",
  }) async {
    final amountInWei = EthereumFormater.convertEthToWei(amount);
    final chainId = typeOfNetwork == "testnet" ? 11155111 : 1;
    final Map<String, dynamic> chainInfo = {
      "chainId": chainId,
    };

    final unsignedTransactionData = await jsVMService.callJS(
      """window.EVMUtils.createUnsignedTransaction('$receiverAddress', $amountInWei, 
      '${jsonEncode(chainInfo)}', ${transactionInfo.nonce}, ${transactionInfo.gasPrice}, 
       ${transactionInfo.gasLimit}, ${transactionInfo.maxPriorityFeePerGas})""",
    );
    final unsignedTransaction =
        json.decode(unsignedTransactionData) as Map<String, dynamic>;
    return MpcTransactionInfo(transactionInfo: unsignedTransaction);
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
    final res = await ethereumRpcClient.sendTransaction(txhex);
    return res;
  }
}
