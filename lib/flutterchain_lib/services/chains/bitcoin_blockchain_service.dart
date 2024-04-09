import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bitcoin_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchains_gas.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/webview_constants.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
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
    String toAddress,
    String fromAddress,
    String transferAmount,
    String privateKey,
    String publicKey,
  ) async {
    const needKeyHash = false;
    final accountID = await getAdressBTCP2PKHFomat(publicKey, needKeyHash);
    final transactionInfo =
        await bitcoinRpcClient.getTransactionInfo(accountID);
    final txHex = await signBitcoinTransfer(
        toAddress,
        accountID,
        transferAmount,
        privateKey,
        publicKey,
        transactionInfo.tx_hash,
        transactionInfo.ref_balance,
        transactionInfo.tx_output);

    final res = bitcoinRpcClient.sendTransferNativeCoinTest(txHex);
    return res;
  }

  //Call smart contract function
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

  //Get wallet balance by account ID (hex representation of near account)
  @override
  Future<String> getWalletBalance(String accountId) async {
    const needKeyHash = false;
    final addressId = await getAdressBTCP2PKHFomat(accountId, needKeyHash);
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

  Future<BitcoinBlockChainData> getBlockChainDataFromMnemonicTest(
      String mnemonic, String passphrase) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')");
    final decodedRes = jsonDecode(res);
    final blockChainData = BitcoinBlockChainData.fromJson(decodedRes);
    return blockChainData;
  }

  Future<String> signBitcoinTransfer(
      String toAddress,
      String accountID,
      String transferAmount,
      String privateKey,
      String publicKey,
      String tx_hash,
      String utxoAmount,
      int tx_output) async {
    final BigintTransferAmount = BigInt.parse(transferAmount);
    final BigintUtxoAmount = BigInt.parse(utxoAmount);
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.bitcoinTransferAction('$toAddress', '$accountID', $BigintTransferAmount, '$privateKey', '$publicKey', '$tx_hash', $BigintUtxoAmount, $tx_output)");
    // final decode = jsonDecode(res);
    return res.toString();
  }

  //This method helps sign near actions , you can find this actions description here -> https://nomicon.io/RuntimeSpec/Actions
  //This is a core method to got signed transaction from your list of actions

  //This method will transform Near public key (which in hex format) to Base58 format with "ed25519:" prefix
  Future<String> getBase58PubKeyFromHexValue(
      {required String? hexEncodedPubKey}) async {
    if (hexEncodedPubKey == null) {
      throw Exception('hexEncodedPubKey is incorrect');
    }
    final res = await jsVMService.callJS(
        "window.NearBlockchain.getBase58PubKeyFromHexValue('$hexEncodedPubKey')");
    return res.toString();
  }

  //This method getting Address BTC in P2PKH format from Public Key in Hex format
  Future<String> getAdressBTCP2PKHFomat(
      String publicKeyHEX, bool needKeyHash) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.getAdressBTCP2PKHFomat('$publicKeyHEX', $needKeyHash)");
    return res.toString();
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
