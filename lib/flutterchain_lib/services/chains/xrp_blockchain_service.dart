import 'dart:convert';
import 'package:flutterchain/flutterchain_lib/constants/chains/xrp_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/xrp_formatter.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_account_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/xrp/xrp_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/xrp_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';

class XRPBlockChainService implements BlockChainService {
  final JsVMService jsVMService;
  final XRPRpcClient xrpRpcClient;

  XRPBlockChainService({
    required this.jsVMService,
    required this.xrpRpcClient,
  });

  factory XRPBlockChainService.defaultInstance() {
    return XRPBlockChainService(
      jsVMService: getJsVM(),
      xrpRpcClient: XRPRpcClient.defaultInstance(),
    );
  }

  Future<XRPTransactionInfo> getTransactionInfo(
      {required String senderAdress}) async {
    final res = await xrpRpcClient.getTransactionInfo(senderAdress);
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
    return XRPBlockChainNetworkUrls.listOfUrls;
  }

  @override
  Future<String> getWalletBalance(TransferRequest transferRequest) {
    return xrpRpcClient.getAccountBalance(transferRequest.accountID!);
  }

  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) {
    // TODO: implement sendTransferNativeCoin
    throw UnimplementedError();
  }

  @override
  Future<void> setBlockchainNetworkEnvironment({required String newUrl}) async {
    xrpRpcClient.networkClient.setUrl(newUrl);
  }

  //MPC Feature

  Future<MpcTransactionInfo> createPayloadForNearMPC({
    required MPCAccountInfo mpcAccountInfo,
    required String receiverAddress,
    required double amount,
    required XRPTransactionInfo transactionInfo,
    String typeOfNetwork = "testnet",
  }) async {
    final amountInDrops = XrpFormatter.xrpToDrops(amount);

    final txInJsonFormat = {
      "TransactionType": 'Payment',
      "Account": mpcAccountInfo.adress,
      "Amount": amountInDrops.toString(),
      "Destination": receiverAddress,
      "SigningPubKey": mpcAccountInfo.publicKey,
      // "NetworkID": transactionInfo.networkId,
      "Sequence": transactionInfo.sequence,
      "Fee": transactionInfo.fee.toString(),
      "LastLedgerSequence": transactionInfo.lastLedgerSequence,
    };

    final unsignedTransactionData = await jsVMService.callJSAsync(
      """window.XRPUtils.createUnsignedTransaction('${jsonEncode(txInJsonFormat)}')""",
    );

    final unsignedTransaction =
        json.decode(unsignedTransactionData) as Map<String, dynamic>;
    return MpcTransactionInfo(transactionInfo: unsignedTransaction);
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
    final res = await xrpRpcClient.sendTransaction(txhex);
    return res;
  }
}
