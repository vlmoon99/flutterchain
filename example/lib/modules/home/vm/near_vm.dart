import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

class NearVM {
  final FlutterChainCryptoLibrary cryptoLibrary;

  NearVM(this.cryptoLibrary);

  Future<BlockChainData> addBlockChainDataByDerivationPath({
    required DerivationPath derivationPath,
    required String blockchainType,
    required String walletID,
  }) async {
    return cryptoLibrary.addNearBlockChainDataByDerivationPath(
      derivationPath: derivationPath,
      blockchainType: blockchainType,
      walletID: walletID,
    );
  }

  Future<BlockchainResponse> addKeyNearBlockChain({
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String blockchainType,
    required String walletID,
    required DerivationPath derivationPath,
  }) {
    final yoctoNearAllowance = NearFormatter.nearToYoctoNear(allowance);
    final response = cryptoLibrary.addKeyNearBlockChain(
      permission: permission,
      allowance: yoctoNearAllowance,
      smartContractId: smartContractId,
      methodNames: methodNames,
      blockchainType: blockchainType,
      walletID: walletID,
      derivationPath: derivationPath,
    );

    return response;
  }

  Future<BlockchainResponse> deleteKeyNearBlockChain({
    required String blockchainType,
    required String walletID,
    required String publicKey,
    required String fromAddress,
    required DerivationPath derivationPath,
  }) {
    final response = cryptoLibrary.deleteKeyNearBlockChain(
      blockchainType: blockchainType,
      walletID: walletID,
      publicKey: publicKey,
      fromAdress: fromAddress,
      derivationPath: derivationPath,
    );

    return response;
  }

  Future<BlockchainResponse> stakeNearBlockChain({
    required String blockchainType,
    required String walletID,
    required String amount,
    required String validatorId,
    required String fromAdress,
    required DerivationPath derivationPath,
  }) {
    final response = cryptoLibrary.stakeNearBlockChain(
      blockchainType: blockchainType,
      walletID: walletID,
      amount: NearFormatter.nearToYoctoNear(amount),
      validatorId: validatorId,
      fromAdress: fromAdress,
      derivationPath: derivationPath,
    );

    return response;
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required Map<String, dynamic> args,
    required String amountOfDeposit,
    required String blockchainType,
    required String walletId,
    required String smartContractAddress,
    required String method,
  }) {
    final response = cryptoLibrary.callSmartContractFunction(
      walletId: walletId,
      typeOfBlockchain: blockchainType,
      toAdress: smartContractAddress,
      transferAmount: NearFormatter.nearToYoctoNear(amountOfDeposit),
      args: args,
      method: method,
    );
    return response;
  }

  Future<dynamic> getWalletBalanceByPublicKey({
    required String walletId,
    required String blockchainType,
  }) async =>
      cryptoLibrary.getBalanceOfAddressOnSpecificBlockchain(
          walletId: walletId, blockchainType: blockchainType);

  Future<String> getWalletPublicKeyAddressByWalletId(String walletName,
          String blockchainType, DerivationPath derivationPath) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[blockchainType]!
          .firstWhereOrNull(
              (element) => element.derivationPath == derivationPath)
          ?.publicKey ??
      'not founded';

  Future<String> getMnemonicPhraseByWalletId(
    String walletName,
  ) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .mnemonic;

  Future<dynamic> sendNativeCoinTransferByWalletId({
    required String toAddress,
    required String transferAmount,
    required String walletId,
    required String typeOfBlockchain,
  }) async {
    final response = cryptoLibrary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAdress: toAddress,
      transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
    );
    return response;
  }
}
