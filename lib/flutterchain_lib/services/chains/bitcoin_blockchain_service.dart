import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bitcoin_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/webview_constants.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/bitcoin_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';

class BitcoinBlockChainService implements BlockChainService {
  final JsVMService jsVMService;
  final BitcoinRpcClient bitcoinRpcClient;

  BitcoinBlockChainService({
    required this.jsVMService,
    required this.bitcoinRpcClient,
  });

  factory BitcoinBlockChainService.defaultInstance() {
    return BitcoinBlockChainService(
      jsVMService: getJsVM(),
      bitcoinRpcClient: BitcoinRpcClient.defaultInstance(),
    );
  }

  //Core

  //Send Bitcoin tokens thought bitcoin blockchain
  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) async {
    BitcoinTransferRequest bitcoinTransferRequest =
        transferRequest as BitcoinTransferRequest;
    final format = 'SEGWIT';
    final actuelFees = await bitcoinRpcClient.getActualPricesFeeSHigher();
    final accountID =
        await getAdressBTCSegWitFomat(bitcoinTransferRequest.publicKey!);
    final transactionInfo = await bitcoinRpcClient.getTransactionInfo(
        accountID, bitcoinTransferRequest.transferAmount!, actuelFees);

    final txHex = await signBitcoinTransfer(
        bitcoinTransferRequest.toAddress!,
        accountID,
        bitcoinTransferRequest.transferAmount!,
        bitcoinTransferRequest.privateKey!,
        bitcoinTransferRequest.publicKey!,
        transactionInfo.data,
        format,
        actuelFees);

    final res = await bitcoinRpcClient.sendTransferNativeCoinTest(txHex);
    return res;
  }

  //Call smart contract function not exist in bitcoin
  @override
  Future<BlockchainResponse> callSmartContractFunction(
    String toAdress,
    String fromAdress,
    String privateKey,
    String publicKey,
    BlockChainSmartContractArguments arguments,
  ) async {
    throw UnimplementedError('callSmartContractFunction is not implemented.');
  }

  //Get wallet balance by account ID (on input hex format public key)
  @override
  Future<String> getWalletBalance(TransferRequest transferRequest) async {
    final bitcoinTransferRequest = transferRequest as BitcoinTransferRequest;
    final addressId =
        await getAdressBTCSegWitFomat(bitcoinTransferRequest.accountID!);
    final res = await bitcoinRpcClient.getAccountBalance(addressId);
    return res;
  }

  //Setting new blockchain network environment on another url
  @override
  Future<void> setBlockchainNetworkEnvironment({required String newUrl}) async {
    bitcoinRpcClient.networkClient.setUrl(newUrl);
  }

  //Getting official blockchain's urls
  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return BitcoinBlockChainNetworkUrls.listOfUrls;
  }

  //Getting private , public key and other information from mnemonic passphrase, and derivation path
  @override
  Future<BitcoinBlockChainData> getBlockChainDataByDerivationPath({
    required String mnemonic,
    required String? passphrase,
    required DerivationPath derivationPath,
  }) async {
    final res = await jsVMService.callJS(
        """window.BitcoinBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase', "${derivationPath.accountNumber}","${derivationPath.change}","${derivationPath.address}")""");
    final blockChainData = BitcoinBlockChainData.fromJson(jsonDecode(res));
    return blockChainData;
  }

  //Getting private , public key and other information from mnemonic and passphrase
  //this method will give you first standard wallet generated from this mnemonic and passphrase
  @override
  Future<BitcoinBlockChainData> getBlockChainDataFromMnemonic(
      String mnemonic, String passphrase) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')");
    final decodedRes = jsonDecode(res);
    final blockChainData = BitcoinBlockChainData.fromJson(decodedRes);
    return blockChainData;
  }

  // Generate tx sign transfer in hex format
  Future<String> signBitcoinTransfer(
      String toAddress,
      String accountID,
      String transferAmount,
      String privateKey,
      String publicKey,
      List<dynamic> dataFromUTXO,
      String format,
      int feeBayte) async {
    String jsonFormData = jsonEncode(dataFromUTXO);
    final BigintTransferAmount = BigInt.parse(transferAmount);
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.bitcoinTransferAction('$toAddress', '$accountID', $BigintTransferAmount, '$privateKey', '$publicKey', $jsonFormData, '$format', $feeBayte)");
    return res.toString();
  }

  //This method will transform Bitcoin public key (which in hex format) to Base58 format
  Future<String> getBase58PubKeyFromHexValue(
      {required String? hexEncodedPubKey}) async {
    if (hexEncodedPubKey == null) {
      throw Exception('hexEncodedPubKey is incorrect');
    }
    final res = await jsVMService.callJS(
        "window.NearBlockchain.getBase58PubKeyFromHexValue('$hexEncodedPubKey')");
    return res.toString();
  }

  //This method getting Address BTC in P2PKH format from Public Key in Hex format, if needKeyHash = true, return key hash
  Future<String> getAdressBTCP2PKHFomat(
      String publicKeyHEX, bool needKeyHash) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.getAdressBTCFromHexPublicKeyP2PKH('$publicKeyHEX', $needKeyHash)");
    return res.toString();
  }

  //This method getting Address BTC in SegWit format from Public Key in Hex format
  Future<String> getAdressBTCSegWitFomat(String publicKeyHEX) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.getAdressBTCFromHexPublicKeySegWit('$publicKeyHEX')");
    return res.toString();
  }

  //This method getting actual price fee in SegWit format
  Future<BlockchainResponse> getActualPriceFee() async {
    final res = await bitcoinRpcClient.getActualPricesFeeSAll();
    return res;
  }

  @override
  Future<String> getBlockchainNetworkEnvironment() async {
    return bitcoinRpcClient.networkClient.dio.options.baseUrl;
  }

  String? getAccountIdFromWalletRedirectOnTheWeb() {
    if (!kIsWeb) {
      return 'no_web_env';
    }
    String? accountId = Uri.base.queryParameters["account_id"];
    return accountId;
  }
}
