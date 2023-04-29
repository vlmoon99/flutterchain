import 'package:flutterchain/flutterchain_lib/constants/derivation_paths.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib/repositories/wallet_repository.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/crypto_service.dart';
import 'package:rxdart/rxdart.dart';

class FlutterChainLibrary {
  final BehaviorSubject<List<Wallet>> walletsStream =
      BehaviorSubject<List<Wallet>>();
  final FlutterChainService blockchainService;
  final WalletRepository walletRepository;

  FlutterChainLibrary(this.blockchainService, this.walletRepository) {
    initCryptoLib();
  }

  Future<void> initCryptoLib() async {
    walletRepository.readAll().then((wallets) {
      walletsStream.add(wallets);
    });
  }

  Future<void> deleteWalletById({
    required String walletId,
  }) async {
    walletsStream.add(walletsStream.valueOrNull
            ?.where((element) => element.id != walletId)
            .toList() ??
        []);
    walletRepository.saveAll(walletsStream.value);
  }

  Future<void> deleteAllWallets() async {
    walletsStream.add([]);
    walletRepository.deleteAll();
  }

  Future<void> setBlockchainNetworkEnvironment(
      {required String blockchainType, required String newUrl}) async {
    await blockchainService.setBlockchainNetworkEnvironment(
      blockchainType: blockchainType,
      newUrl: newUrl,
    );
  }

  Set<String> getBlockchainsUrlsByBlockchainType(String blockchainType) {
    return blockchainService.getBlockchainsUrlsByBlockchainType(blockchainType);
  }

//Need to be refactored

  Future<dynamic> getBalanceOfAddressOnSpecificBlockchain({
    required String walletId,
    required String blockchainType,
    DerivationPath derivationPath = BlockChainsDerivationPaths.near,
  }) async {
    final wallet = walletsStream.value
        .firstWhereOrNull((element) => element.id == walletId);
    final publicKey = wallet?.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPath)
        ?.publicKey;
    if (publicKey != null) {
      return blockchainService.getWalletBalance(
          accountId: publicKey, blockchainType: blockchainType);
    } else {
      throw Exception("Public key is null");
    }
  }

  Future<void> createWalletWithGeneratedMnemonic({
    required String walletName,
    String passphrase = '',
  }) async {
    final mnemonicData = await blockchainService.generateNewWallet(
        walletName: walletName, passphrase: passphrase);
    await createWallet(mnemonic: mnemonicData.mnemonic, walletName: walletName);
  }

  Future<void> createWallet({
    required String mnemonic,
    required String walletName,
    String passphrase = '',
  }) async {
    final isAlreadyExist = (await walletRepository.readAll())
            .firstWhereOrNull((element) => element.name == walletName) !=
        null;

    if (isAlreadyExist) {
      throw Exception("This wallet Name is already exist");
    }

    final blockchainsData =
        await blockchainService.createBlockchainsDataFromTheMnemonic(
            mnemonic: mnemonic, passphrase: passphrase);

    final id = int.tryParse(
            (await walletRepository.readAll()).lastOrNull?.id ?? '-1')! +
        1;

    final wallet = Wallet(
      id: id.toString(),
      name: walletName,
      mnemonic: mnemonic,
      passphrase: passphrase,
      blockchainsData: blockchainsData,
    );

    walletsStream.value.add(wallet);
    walletsStream.add(walletsStream.value);
    walletRepository.saveAll(walletsStream.value);
  }

  Future<dynamic> sendTransferNativeCoin({
    required String walletId,
    required String typeOfBlockchain,
    required String toAdress,
    required String transferAmount,
    DerivationPath derivationPath = BlockChainsDerivationPaths.near,
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPath)
        ?.privateKey;

    final publicKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPath)
        ?.publicKey;
    if (publicKey == null) {
      throw Exception('Public key is null');
    }
    if (privateKey == null) {
      throw Exception('Private key is null');
    }
    return blockchainService.sendTransferNativeCoin(
      toAdress: toAdress,
      fromAdress: publicKey,
      transferAmount: transferAmount,
      typeOfBlockchain: typeOfBlockchain,
      privateKey: privateKey,
    );
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required String walletId,
    required String method,
    required Map<String, dynamic> args,
    required String typeOfBlockchain,
    required String toAdress,
    required String transferAmount,
    DerivationPath derivationPath = BlockChainsDerivationPaths.near,
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPath)
        ?.privateKey;

    final publicKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPath)
        ?.publicKey;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    return blockchainService.callSmartContractFunction(
      toAdress: toAdress,
      fromAdress: publicKey,
      transferAmount: transferAmount,
      typeOfBlockchain: typeOfBlockchain,
      privateKey: privateKey,
      arguments: args,
      methodName: method,
    );
  }

//Need to be deleted

  Future<BlockchainResponse> addKeyNearBlockChain({
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String blockchainType,
    required String walletID,
    required DerivationPath derivationPathOfNewGeneratedAccount,
    required DerivationPath derivationPathOfCurrentWallet,
  }) {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletID);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull((element) =>
            element.derivationPath == derivationPathOfCurrentWallet)
        ?.privateKey;

    final publicKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull((element) =>
            element.derivationPath == derivationPathOfCurrentWallet)
        ?.publicKey;
    final mnemonic = wallet.mnemonic;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    final nearBlockChainService = blockchainService
        .blockchainServices[blockchainType] as NearBlockChainService;

    return nearBlockChainService.addKey(
        permission: permission,
        allowance: allowance,
        smartContractId: smartContractId,
        methodNames: methodNames,
        privateKey: privateKey,
        fromAdress: publicKey,
        mnemonic: mnemonic,
        derivationPathOfNewGeneratedAccount:
            derivationPathOfNewGeneratedAccount);
  }

  Future<BlockchainResponse> deleteKeyNearBlockChain({
    required String fromAdress,
    required String publicKey,
    required String blockchainType,
    required String walletID,
    required DerivationPath derivationPath,
    // String derivationIndex = '0',
  }) {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletID);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPath)
        ?.privateKey;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    final nearBlockChainService = blockchainService
        .blockchainServices[blockchainType] as NearBlockChainService;

    return nearBlockChainService.deleteKey(
      publicKey: publicKey,
      privateKey: privateKey,
      fromAdress: fromAdress,
    );
  }

  Future<BlockchainResponse> stakeNearBlockChain({
    required String fromAdress,
    required String validatorId,
    required String blockchainType,
    required String amount,
    required String walletID,
    required DerivationPath derivationPath,
  }) {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletID);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPath)
        ?.privateKey;
    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    final nearBlockChainService = blockchainService
        .blockchainServices[blockchainType] as NearBlockChainService;

    return nearBlockChainService.stake(
      privateKey: privateKey,
      fromAdress: fromAdress,
      amount: amount,
      validatorId: validatorId,
    );
  }

  Future<BlockChainData> addNearBlockChainDataByDerivationPath({
    required DerivationPath derivationPath,
    required String blockchainType,
    required String walletID,
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletID);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }
    final blockChainService =
        blockchainService.blockchainServices[blockchainType];

    if (blockChainService == null) {
      throw Exception('Does not exist blockchain service with this name');
    }

    final blockChainData =
        await blockChainService.getBlockChainDataByDerivationPath(
      derivationPath: derivationPath,
      mnemonic: wallet.mnemonic,
      passphrase: wallet.passphrase,
    );
    wallet.blockchainsData![blockchainType] = {
      ...wallet.blockchainsData![blockchainType] ?? {},
      blockChainData
    };
    walletsStream.value[walletsStream.value
        .indexWhere((element) => element.id == walletID)] = wallet;
    walletsStream.add(walletsStream.value);
    await walletRepository.saveAll(walletsStream.value);
    return blockChainData;
  }
}
