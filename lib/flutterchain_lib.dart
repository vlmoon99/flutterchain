import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib/repositories/wallet_repository.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/crypto_service.dart';
import 'package:rxdart/rxdart.dart';

class FlutterChainCryptoLibrary {
  final BehaviorSubject<List<Wallet>> walletsStream =
      BehaviorSubject<List<Wallet>>();
  final CryptoService cryptoService;
  final WalletRepository walletRepository;

  FlutterChainCryptoLibrary(this.cryptoService, this.walletRepository) {
    initCryptoLib();
  }

  Future<void> initCryptoLib() async {
    walletRepository.readAll().then((wallets) {
      walletsStream.add(wallets);
    });
  }

  Future<dynamic> getBalanceOfAddressOnSpecificBlockchain({
    required String walletId,
    required String blockchainType,
  }) async {
    final wallet = walletsStream.value
        .firstWhereOrNull((element) => element.id == walletId);
    final publicKey = wallet?.blockchainsData?[blockchainType]?.publicKey;
    if (publicKey != null) {
      return cryptoService.getWalletBalance(
          accountId: publicKey, blockchainType: blockchainType);
    } else {
      throw Exception("Public key is null");
    }
  }

  Future<void> createWalletWithGeneratedMnemonic({
    required String walletName,
    String passphrase = '',
  }) async {
    final mnemonicData = await cryptoService.generateNewWallet(
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
        await cryptoService.createBlockchainsDataFromTheMnemonic(
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

  Future<dynamic> sendTransferNativeCoin({
    required String walletId,
    required String typeOfBlockchain,
    required String toAdress,
    required String transferAmount,
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }
    final publicKey = wallet.blockchainsData?[typeOfBlockchain]?.publicKey;
    final privateKey = wallet.blockchainsData?[typeOfBlockchain]?.privateKey;
    if (publicKey == null) {
      throw Exception('Public key is null');
    }
    if (privateKey == null) {
      throw Exception('Private key is null');
    }
    return cryptoService.sendTransferNativeCoin(
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
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[typeOfBlockchain]?.privateKey;
    final publicKey = wallet.blockchainsData?[typeOfBlockchain]?.publicKey;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    return cryptoService.callSmartContractFunction(
      toAdress: toAdress,
      fromAdress: publicKey,
      transferAmount: transferAmount,
      typeOfBlockchain: typeOfBlockchain,
      privateKey: privateKey,
      arguments: args,
      methodName: method,
    );
  }

  Future<void> setBlockchainNetworkEnvironment(
      {required String blockchainType, required String newUrl}) async {
    await cryptoService.setBlockchainNetworkEnvironment(
      blockchainType: blockchainType,
      newUrl: newUrl,
    );
  }

  Set<String> getBlockchainsUrlsByBlockchainType(String blockchainType) {
    return cryptoService.getBlockchainsUrlsByBlockchainType(blockchainType);
  }

  Future<BlockchainResponse> addKeyNearBlockChain({
    required String indexOfTheDerivationPath,
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String blockchainType,
    required String walletID,
  }) {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletID);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]?.privateKey;
    final publicKey = wallet.blockchainsData?[blockchainType]?.publicKey;
    final mnemonic = wallet.mnemonic;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    final nearBlockChainService = cryptoService
        .blockchainServices[blockchainType] as NearBlockChainService;

    return nearBlockChainService.addKey(
      indexOfTheDerivationPath: indexOfTheDerivationPath,
      permission: permission,
      allowance: allowance,
      smartContractId: smartContractId,
      methodNames: methodNames,
      privateKey: privateKey,
      fromAdress: publicKey,
      mnemonic: mnemonic,
    );
  }

  Future<BlockchainResponse> deleteKeyNearBlockChain({
    required String fromAdress,
    required String publicKey,
    required String blockchainType,
    required String walletID,
  }) {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletID);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]?.privateKey;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    final nearBlockChainService = cryptoService
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
  }) {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletID);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]?.privateKey;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (validatorId == null) {
      throw Exception('Public key is null');
    }

    final nearBlockChainService = cryptoService
        .blockchainServices[blockchainType] as NearBlockChainService;

    return nearBlockChainService.stake(
      privateKey: privateKey,
      fromAdress: fromAdress,
      amount: amount,
      validatorId: validatorId,
    );
  }
}