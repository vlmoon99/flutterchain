import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/stores/chains/near_blockchain_store.dart';

class NearVM {
  final FlutterChainCryptoLibrary cryptoLibrary;
  final NearBlockchainStore nearBlockchainStore;
  NearVM(
    this.cryptoLibrary,
    this.nearBlockchainStore,
  );

  Future<BlockChainData> addBlockChainDataByDerivationPath({
    required DerivationPath derivationPath,
    required String walletID,
  }) async {
    return cryptoLibrary.addNearBlockChainDataByDerivationPath(
      derivationPath: derivationPath,
      blockchainType: BlockChains.near,
      walletID: walletID,
    );
  }

  Future<BlockchainResponse> addKeyNearBlockChain({
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String walletID,
    required DerivationPath derivationPathOfNewGeneratedAccount,
    required DerivationPath derivationPathOfCurrentWallet,
  }) {
    final yoctoNearAllowance = NearFormatter.nearToYoctoNear(allowance);
    final response = cryptoLibrary.addKeyNearBlockChain(
      permission: permission,
      allowance: yoctoNearAllowance,
      derivationPathOfCurrentWallet: derivationPathOfCurrentWallet,
      smartContractId: smartContractId,
      methodNames: methodNames,
      blockchainType: BlockChains.near,
      walletID: walletID,
      derivationPathOfNewGeneratedAccount: derivationPathOfNewGeneratedAccount,
    );

    return response;
  }

  Future<BlockchainResponse> deleteKeyNearBlockChain({
    required String walletID,
    required String publicKey,
    required String fromAddress,
    required DerivationPath derivationPath,
  }) {
    final response = cryptoLibrary.deleteKeyNearBlockChain(
      blockchainType: BlockChains.near,
      walletID: walletID,
      publicKey: publicKey,
      fromAdress: fromAddress,
      derivationPath: derivationPath,
    );

    return response;
  }

  Future<BlockchainResponse> stakeNearBlockChain({
    required String walletID,
    required String amount,
    required String validatorId,
    required String fromAdress,
    required DerivationPath derivationPath,
  }) {
    final response = cryptoLibrary.stakeNearBlockChain(
      blockchainType: BlockChains.near,
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
    required String walletId,
    required String smartContractAddress,
    required String method,
    required DerivationPath derivationPath,
  }) {
    final response = cryptoLibrary.callSmartContractFunction(
      derivationPath: derivationPath,
      walletId: walletId,
      typeOfBlockchain: BlockChains.near,
      toAdress: smartContractAddress,
      transferAmount: NearFormatter.nearToYoctoNear(amountOfDeposit),
      args: args,
      method: method,
    );
    return response;
  }

  Future<dynamic> getBalanceByDerivationPath({
    required String walletId,
    required DerivationPath derivationPath,
  }) async =>
      cryptoLibrary.getBalanceOfAddressOnSpecificBlockchain(
        walletId: walletId,
        blockchainType: BlockChains.near,
        derivationPath: derivationPath,
      );

  Future<String> getWalletPublicKeyAddressByWalletId(
          String walletName, DerivationPath derivationPath) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[BlockChains.near]!
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
    required DerivationPath derivationPath,
  }) async {
    final response = cryptoLibrary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAdress: toAddress,
      derivationPath: derivationPath,
      transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
    );
    return response;
  }
}
