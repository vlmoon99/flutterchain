import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/stores/chains/near_blockchain_store.dart';

class NearVM {
  final FlutterChainLibrary cryptoLibrary;
  final NearBlockchainStore nearBlockchainStore;
  NearVM(
    this.cryptoLibrary,
    this.nearBlockchainStore,
  );

  Future<BlockChainData> addBlockChainDataByDerivationPath({
    required DerivationPath currentDerivationPath,
    required String walletID,
  }) async {
    return cryptoLibrary.addBlockChainDataByDerivationPath(
      currentDerivationPath: currentDerivationPath,
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
    required DerivationPath currentDerivationPath,
  }) {
    final yoctoNearAllowance = NearFormatter.nearToYoctoNear(allowance);
    final nearBlockChainService = cryptoLibrary.blockchainService
        .blockchainServices[BlockChains.near] as NearBlockChainService?;
    if (nearBlockChainService == null) {
      throw Exception("didn't found near blockchain service");
    }
    final currentWallet = cryptoLibrary.walletsStream.value
        .firstWhere((element) => element.id == walletID);

    final fromTheAddress = (currentWallet.blockchainsData?[BlockChains.near]
                as NearBlockChainData)
            .accountId ??
        (currentWallet.blockchainsData?[BlockChains.near] as NearBlockChainData)
            .publicKey;

    final publicKey = currentWallet.blockchainsData?[BlockChains.near]!
        .firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.publicKey;
    if (publicKey == null) {
      throw Exception('Incorrect User public key is null');
    }

    final privateKey = currentWallet.blockchainsData?[BlockChains.near]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.privateKey;

    if (privateKey == null) {
      throw Exception('Incorrect User private key is null');
    }

    final response = nearBlockChainService.addKey(
      permission: permission,
      allowance: yoctoNearAllowance,
      smartContractId: smartContractId,
      methodNames: methodNames,
      derivationPathOfNewGeneratedAccount: derivationPathOfNewGeneratedAccount,
      fromAddress: fromTheAddress,
      mnemonic: currentWallet.mnemonic,
      privateKey: privateKey,
      publicKey: publicKey,
    );

    return response;
  }

  Future<BlockchainResponse> deleteKeyNearBlockChain({
    required String walletID,
    required String publicKey,
    required DerivationPath currentDerivationPath,
  }) {
    final nearBlockChainService = cryptoLibrary.blockchainService
        .blockchainServices[BlockChains.near] as NearBlockChainService?;
    if (nearBlockChainService == null) {
      throw Exception("didn't found near blockchain service");
    }
    final currentWallet = cryptoLibrary.walletsStream.value
        .firstWhere((element) => element.id == walletID);

    final fromAddress = currentWallet.blockchainsData?[BlockChains.near]!
        .firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.publicKey;
    if (fromAddress == null) {
      throw Exception('Incorrect User public key is null');
    }

    final privateKey = currentWallet.blockchainsData?[BlockChains.near]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.privateKey;

    if (privateKey == null) {
      throw Exception('Incorrect User private key is null');
    }

    final response = nearBlockChainService.deleteKey(
      publicKey: publicKey,
      fromAdress: fromAddress,
      privateKey: privateKey,
    );

    return response;
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required Map<String, dynamic> args,
    required String amountOfDeposit,
    required String walletId,
    required String smartContractAddress,
    required String method,
    required DerivationPath currentDerivationPath,
  }) {
    final wallet = cryptoLibrary.walletsStream.value
        .firstWhereOrNull((element) => element.id == walletId);
    final fromTheAddress =
        (wallet?.blockchainsData?[BlockChains.near] as NearBlockChainData)
                .accountId ??
            (wallet?.blockchainsData?[BlockChains.near] as NearBlockChainData)
                .publicKey;
    final response = cryptoLibrary.callSmartContractFunction(
      currentDerivationPath: currentDerivationPath,
      walletId: walletId,
      typeOfBlockchain: BlockChains.near,
      toAddress: smartContractAddress,
      arguments: NearBlockChainSmartContractArguments(
        method: method,
        args: args,
        transferAmount: NearFormatter.nearToYoctoNear(amountOfDeposit),
      ),
      fromAddress: fromTheAddress,
    );
    return response;
  }

  Future<dynamic> getBalanceByDerivationPath({
    required String walletId,
    required DerivationPath currentDerivationPath,
  }) async =>
      cryptoLibrary.getBalanceOfAddressOnSpecificBlockchain(
        walletId: walletId,
        blockchainType: BlockChains.near,
        currentDerivationPath: currentDerivationPath,
      );

  Future<String> getWalletPublicKeyAddressByWalletId(
          String walletName, DerivationPath currentDerivationPath) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[BlockChains.near]!
          .firstWhereOrNull(
              (element) => element.derivationPath == currentDerivationPath)
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
    required DerivationPath currentDerivationPath,
  }) async {
    final response = cryptoLibrary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAddress: toAddress,
      currentDerivationPath: currentDerivationPath,
      transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
    );
    return response;
  }
}
