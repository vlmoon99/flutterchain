import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bitcoin_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/bitcoin_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
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
    if (transferRequest is! BitcoinTransferRequest) {
      throw ArgumentError(
          'Invalid transferRequest type. Expected: `BitcoinTransferRequest`');
    }

    final format = 'SEGWIT';
    final actualFees = await bitcoinRpcClient.getActualPricesFeeSHigher();
    final accountID = await getAdressBTCSegWitFomat(transferRequest.publicKey);
    final transactionInfo = await bitcoinRpcClient.getTransactionInfo(
      accountID,
      transferRequest.transferAmount,
      actualFees,
    );

    final txHex = await signBitcoinTransfer(
      transferRequest.toAddress,
      accountID,
      transferRequest.transferAmount,
      transferRequest.privateKey,
      transferRequest.publicKey,
      transactionInfo.data,
      format,
      actualFees,
    );

    final res = await bitcoinRpcClient.sendTransaction(txHex);
    return res;
  }

  //Get wallet balance by account ID (on input hex format public key)
  @override
  Future<String> getWalletBalance(
    AccountInfoRequest accountInfoRequest,
  ) async {
    if (accountInfoRequest is! BitcoinAccountInfoRequest) {
      throw ArgumentError(
          'Invalid accountInfoRequest type. Expected: `BitcoinAccountInfoRequest`');
    }
    final addressId =
        await getAdressBTCSegWitFomat(accountInfoRequest.accountId);
    final res = await bitcoinRpcClient.getAccountBalance(addressId);
    return res;
  }

  //Setting new blockchain network environment on another url
  @override
  Future<void> setBlockchainNetworkEnvironment(
      BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings) async {
    if (blockChainNetworkEnvironmentSettings
        is! BitcoinNetworkEnvironmentSettings) {
      throw ArgumentError(
          'Invalid blockChainNetworkEnvironmentSettings type. Expected: `BitcoinNetworkEnvironmentSettings`');
    }
    bitcoinRpcClient.networkClient
        .setUrl(blockChainNetworkEnvironmentSettings.chainUrl);
  }

  //Getting official blockchain's urls
  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return BitcoinBlockChainNetworkUrls.listOfUrls;
  }

  @override
  Future<BlockChainData> getBlockChainData({
    required String mnemonic,
    String? passphrase,
    DerivationPathData? derivationPath,
  }) async {
    final rawFunction = derivationPath == null
        ? "window.BitcoinBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')"
        : """window.BitcoinBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase', "${(derivationPath as DerivationPath).accountNumber}","${derivationPath.change}","${derivationPath.address}")""";
    final res = await jsVMService.callJS(rawFunction);
    final blockChainData = BitcoinBlockChainData.fromJson(jsonDecode(res));
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
  Future<BlockChainNetworkEnvironmentSettings>
      getBlockchainNetworkEnvironment() async {
    return BitcoinNetworkEnvironmentSettings(
      chainUrl: bitcoinRpcClient.networkClient.dio.options.baseUrl,
    );
  }

  String? getAccountIdFromWalletRedirectOnTheWeb() {
    if (!kIsWeb) {
      return 'no_web_env';
    }
    String? accountId = Uri.base.queryParameters["account_id"];
    return accountId;
  }

  //MPC Feature

  Future<MpcTransactionInfo> createPayloadForNearMPC({
    required String senderAddress,
    required String receiverAddress,
    required String amountOfBTC,
    bool testNetwork = true,
  }) async {
    final utxos = await bitcoinRpcClient.getUTXOs(address: senderAddress);
    final feeRate = await bitcoinRpcClient.getFeeRate();

    final Map<String, dynamic> txInfos = {};

    for (var utxo in utxos) {
      final res =
          await bitcoinRpcClient.getExecutedTxData(txHash: utxo['txid']);
      txInfos[utxo['txid']] = res;
    }

    final amountOfSatoshi =
        int.parse(BitcoinFormatter.bitcoinToSatoshi(amountOfBTC));

    final network = testNetwork ? 'testnet' : 'mainnet';

    final psbtEncoded = await jsVMService.callJS(
        "window.BitcoinUtils.createPayload('$senderAddress', '$receiverAddress', $amountOfSatoshi, '${jsonEncode(utxos)}', '${jsonEncode(txInfos)}', $feeRate, '$network')");
    final psbtInHex = jsonDecode(psbtEncoded);

    return MpcTransactionInfo(transactionInfo: {
      'psbt': psbtInHex,
      'utxos': utxos,
    });
  }

  Future<BlockchainResponse> sendTransaction(String txhex) async {
    final res = await bitcoinRpcClient.sendTransaction(txhex);
    return res;
  }
}
