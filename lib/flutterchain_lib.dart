import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib/repositories/wallet_repository.dart';
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

  factory FlutterChainLibrary.defaultInstance() {
    return FlutterChainLibrary(
      FlutterChainService.defaultInstance(),
      WalletRepository.defaultInstance(),
    );
  }

  Future<bool> initCryptoLib() async {
    await walletRepository.readAll().then((wallets) {
      walletsStream.add(wallets);
    });
    return true;
  }

  Future<bool> deleteWalletById({
    required String walletId,
  }) async {
    walletsStream.add(walletsStream.valueOrNull
            ?.where((element) => element.id != walletId)
            .toList() ??
        []);
    walletRepository.saveAll(walletsStream.value);
    return true;
  }

  Future<bool> deleteAllWallets() async {
    walletsStream.add([]);
    walletRepository.deleteAll();
    return true;
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

  Future<BlockChainData> addBlockChainDataByDerivationPath({
    required DerivationPath currentDerivationPath,
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
      derivationPath: currentDerivationPath,
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

  Future<String> getBalanceOfAddressOnSpecificBlockchain({
    required String walletId,
    required String blockchainType,
    required DerivationPath currentDerivationPath,
  }) async {
    final wallet = walletsStream.value
        .firstWhereOrNull((element) => element.id == walletId);
    final publicKey = wallet?.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.publicKey;
    if (publicKey != null) {
      return blockchainService.getWalletBalance(
          accountId: publicKey, blockchainType: blockchainType);
    } else {
      throw Exception("Public key is null");
    }
  }

  Future<Wallet> createWalletWithGeneratedMnemonic({
    required String walletName,
    String passphrase = '',
  }) async {
    final mnemonicData = await blockchainService.generateNewWallet(
        walletName: walletName, passphrase: passphrase);
    return await createWalletByImportedMnemonic(
        mnemonic: mnemonicData.mnemonic, walletName: walletName);
  }

  Future<Wallet> createWalletByImportedMnemonic({
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
    return wallet;
  }

  Future<BlockchainResponse> sendTransferNativeCoin({
    required String walletId,
    required String typeOfBlockchain,
    required String toAddress,
    required String transferAmount,
    required DerivationPath currentDerivationPath,
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.privateKey;

    final publicKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.publicKey;
    if (publicKey == null) {
      throw Exception('Public key is null');
    }
    if (privateKey == null) {
      throw Exception('Private key is null');
    }
    return blockchainService.sendTransferNativeCoin(
      toAddress: toAddress,
      fromAddress: publicKey,
      transferAmount: transferAmount,
      typeOfBlockchain: typeOfBlockchain,
      privateKey: privateKey,
    );
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required String walletId,
    required String typeOfBlockchain,
    required DerivationPath currentDerivationPath,
    required String toAddress,
    required BlockChainSmartContractArguments arguments,
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.privateKey;

    final publicKey = wallet.blockchainsData?[typeOfBlockchain]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.publicKey;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    return blockchainService.callSmartContractFunction(
      typeOfBlockchain: typeOfBlockchain,
      privateKey: privateKey,
      fromAddress: publicKey,
      toAddress: toAddress,
      arguments: arguments,
    );
  }
}
