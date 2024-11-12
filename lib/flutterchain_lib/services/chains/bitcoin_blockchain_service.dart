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
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/bitcoin/bitcoin_blockchain_js_runner_interface.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/nearblockchain/near_blockchain_js_runner.dart';
import 'package:flutterchain/flutterchain_lib/services/core/mnemonic_generator.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/bitcoin/bitcoin_blockchain_js_runner.dart';

class BitcoinBlockChainService implements BlockChainService {
  final BitcoinBlockChainJsRunner jsRunner = getBitcoinJsRunner();
  final BitcoinRpcClient bitcoinRpcClient;

  BitcoinBlockChainService({
    required this.bitcoinRpcClient,
  });

  factory BitcoinBlockChainService.defaultInstance() {
    return BitcoinBlockChainService(
      bitcoinRpcClient: BitcoinRpcClient.defaultInstance(),
    );
  }

  //Core

  //Generate mnemonic
  Future<String> generateMnemonic({
    int strength = 128,
  }) async {
    return MnemonicGenerator().generateMnemonic(strength: strength);
  }

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
    final accountID =
        await getAddressBTCSegWitFormat(transferRequest.publicKey);
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
        await getAddressBTCSegWitFormat(accountInfoRequest.accountId);
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
    if (derivationPath is! DerivationPath?) {
      throw ArgumentError(
        'Incorrect derivationPath type. Expected: `DerivationPath`',
      );
    }
    passphrase ??= "";
    final res = await jsRunner.getBlockChainData(
      mnemonic: mnemonic,
      passphrase: passphrase,
      accountNumber: derivationPath?.accountNumber,
      change: derivationPath?.change,
      address: derivationPath?.address,
    );
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
    return jsRunner.formBitcoinTransferAction(
      toAddress: toAddress,
      accountID: accountID,
      transferAmount: transferAmount,
      privateKeyHex: privateKey,
      publicKey: publicKey,
      dataFromUTXO: jsonEncode(dataFromUTXO),
      format: format,
      feeBayte: feeBayte,
    );
  }

  //This method will transform Bitcoin public key (which in hex format) to Base58 format
  Future<String> getBase58PubKeyFromHexValue(
      {required String hexEncodedPubKey}) async {
    final nearJsRunner = getNearJsRunner();
    return nearJsRunner.getBase58PubKeyFromHexValue(hexEncodedPubKey);
  }

  //This method getting Address BTC in P2PKH format from Public Key in Hex format, if needKeyHash = true, return key hash
  Future<String> getAddressBTCP2PKHFormat(
      String publicKeyHEX, bool needKeyHash) async {
    return jsRunner.getAdressBTCFromHexPublicKeyP2PKH(
      publicKeyHEX: publicKeyHEX,
      needKeyHash: needKeyHash,
    );
  }

  //This method getting Address BTC in SegWit format from Public Key in Hex format
  Future<String> getAddressBTCSegWitFormat(String publicKeyHEX) async {
    return jsRunner.getAdressBTCFromHexPublicKeySegWit(publicKeyHEX);
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

    final psbtEncoded = await jsRunner.createPayloadForNearMPC(
      sender: senderAddress,
      receiver: receiverAddress,
      satoshis: amountOfSatoshi,
      utxos: jsonEncode(utxos),
      txInfos: jsonEncode(txInfos),
      feeRate: feeRate,
      network: network,
    );

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
