import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';

class HomeVM {
  final FlutterChainCryptoLibrary cryptoLibary;

  HomeVM(this.cryptoLibary) {
    cryptoLibary.walletsStream.value.forEach((element) {
      print(element.name);
    });
  }

  Future<dynamic> getWalletBalanceByPublicKey({
    required String walletId,
    required String blockchainType,
  }) async =>
      cryptoLibary.getBalanceOfAddressOnSpecificBlockchain(
          walletId: walletId, blockchainType: blockchainType);

  Future<String> getWalletPublicKeyAddressByWalletName(
          String walletName, String blockchainType) async =>
      cryptoLibary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[blockchainType]
          ?.publicKey ??
      'No public key';

  Future<String> getMnemonicPhraseByWalletName(
    String walletName,
  ) async =>
      cryptoLibary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .mnemonic;

  Future<dynamic> sendNativeCoinTransferByWalletName({
    required String toAdress,
    required String transferAmount,
    required String walletId,
    required String typeOfBlockchain,
  }) async {
    final response = cryptoLibary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAdress: toAdress,
      transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
    );
    return response;
  }

  // Future<String> getWalletBalance() async =>
  //     _walletService.getWalletBalance((await getWallet()).publicKey);

  // Future<dynamic> sendNearToAddress(
  //     String toAddress, String transferAmount) async {
  //   final wallet = await getWallet();
  //   final txSubInfo = await _walletService.getNonceAndBlockHashInfo(
  //       wallet.publicKey, wallet.publicKey);
  //   final actions = [
  //     {
  //       "type": "transfer",
  //       "data": {"amount": transferAmount}
  //     }
  //   ];
  //   final signedTX = await _walletService.signNearActions(
  //     fromAddress: wallet.publicKey,
  //     toAddress: toAddress,
  //     transferAmount: nearToYoctoNear(transferAmount),
  //     privateKey: wallet.privateKey,
  //     nonce: txSubInfo.nonce,
  //     blockHash: txSubInfo.blockHash,
  //     actions: actions,
  //     gas: '30000000000000',
  //   );
  //   final res = await _walletService.sendTransactionNearSync(tx: signedTX);
  //   return res;
  // }

  // Future<dynamic> callSmartContractFunctionSet(
  //   String argumentValue,
  //   String smAdressValue,
  // ) async {
  //   final wallet = await getWallet();
  //   final txSubInfo = await _walletService.getNonceAndBlockHashInfo(
  //       wallet.publicKey, wallet.publicKey);
  //   final List<Map<String, dynamic>> actions = [
  //     {
  //       "type": "functionCall",
  //       "data": {
  //         "methodName": "set_greeting",
  //         "args": {"message": argumentValue},
  //       },
  //     },
  //   ];
  //   final signedTX = await _walletService.signNearActions(
  //     actions: actions,
  //     blockHash: txSubInfo.blockHash,
  //     fromAddress: wallet.publicKey,
  //     nonce: txSubInfo.nonce,
  //     gas: "30000000000000",
  //     privateKey: wallet.privateKey,
  //     toAddress: smAdressValue,
  //     transferAmount: nearToYoctoNear("0"),
  //   );
  //   final res = await _walletService.sendTransactionNearAsync(tx: signedTX);

  //   return res;
  // }

  // Future<dynamic> callSmartContractFunctionGet(
  //   String argumentValue,
  //   String smAdressValue,
  // ) async {
  //   final wallet = await getWallet();
  //   final txSubInfo = await _walletService.getNonceAndBlockHashInfo(
  //       wallet.publicKey, wallet.publicKey);
  //   final List<Map<String, dynamic>> actions = [
  //     {
  //       "type": "functionCall",
  //       "data": {
  //         "methodName": "get_greeting",
  //         "args": {"message": argumentValue},
  //       },
  //     },
  //   ];
  //   final signedTX = await _walletService.signNearActions(
  //     actions: actions,
  //     blockHash: txSubInfo.blockHash,
  //     fromAddress: wallet.publicKey,
  //     nonce: txSubInfo.nonce,
  //     gas: "30000000000000",
  //     privateKey: wallet.privateKey,
  //     toAddress: smAdressValue,
  //     transferAmount: nearToYoctoNear("0"),
  //   );
  //   final res = await _walletService.sendTransactionNearAsync(tx: signedTX);

  //   final value = res['result']['status']['SuccessValue'] ?? 'no result';
  //   String decodedString =
  //       utf8.decode(base64.decode(value)).replaceAll(r'"', "");

  //   return decodedString;
  // }
}
