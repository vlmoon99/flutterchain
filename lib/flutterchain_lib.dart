import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/xrp/xrp_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib/repositories/core/core_repository.dart';
import 'package:flutterchain/flutterchain_lib/repositories/wallet_repository.dart';
import 'package:flutterchain/flutterchain_lib/services/core/crypto_service.dart';
import 'package:rxdart/rxdart.dart';

class FlutterChainLibrary {
  final BehaviorSubject<List<Wallet>> walletsStream =
      BehaviorSubject<List<Wallet>>();
  final FlutterChainService blockchainService;
  final Repository<Wallet> walletRepository;

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
      {required String blockchainType,
      required BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings}) async {
    await blockchainService.setBlockchainNetworkEnvironment(
      blockchainType: blockchainType,
      blockChainNetworkEnvironmentSettings:
          blockChainNetworkEnvironmentSettings,
    );
  }

  Set<String> getBlockchainsUrlsByBlockchainType(String blockchainType) {
    return blockchainService.getBlockchainsUrlsByBlockchainType(blockchainType);
  }

  Future<BlockChainData> addBlockChainDataByDerivationPath({
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

    final blockChainData = await blockChainService.getBlockChainData(
      mnemonic: wallet.mnemonic,
      passphrase: wallet.passphrase,
      derivationPath: derivationPath,
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
    String? address,
    required String blockchainType,
    String? walletId,
    DerivationPathData? derivationPathData,
  }) async {
    late final AccountInfoRequest accountInfoRequest;

    if (address != null) {
      switch (blockchainType) {
        case BlockChains.near:
          accountInfoRequest = NearAccountInfoRequest(accountId: address);
          break;
        case BlockChains.bitcoin:
          accountInfoRequest = BitcoinAccountInfoRequest(accountId: address);
          break;
        case BlockChains.aurora ||
              BlockChains.avalanche ||
              BlockChains.ethereum ||
              BlockChains.bnb ||
              BlockChains.polygon:
          accountInfoRequest = EvmAccountInfoRequest(accountId: address);
          break;
        case BlockChains.xrp:
          accountInfoRequest = XrpAccountInfoRequest(accountId: address);
          break;
        default:
          throw Exception('Unsupported blockchain type');
      }
      return blockchainService.getWalletBalance(
        accountInfoRequest: accountInfoRequest,
        blockchainType: blockchainType,
      );
    } else {
      if (walletId == null || derivationPathData == null) {
        throw Exception("Missing walletId or derivationPathData");
      }
      final wallet = walletsStream.value
          .firstWhereOrNull((element) => element.id == walletId);
      final publicKey = wallet?.blockchainsData?[blockchainType]
          ?.firstWhereOrNull(
              (element) => element.derivationPath == derivationPathData)
          ?.publicKey;
      if (publicKey != null) {
        switch (blockchainType) {
          case BlockChains.near:
            accountInfoRequest = NearAccountInfoRequest(accountId: publicKey);
            break;
          case BlockChains.bitcoin:
            accountInfoRequest =
                BitcoinAccountInfoRequest(accountId: publicKey);
            break;
          case BlockChains.aurora ||
                BlockChains.avalanche ||
                BlockChains.ethereum ||
                BlockChains.bnb ||
                BlockChains.polygon:
            accountInfoRequest = EvmAccountInfoRequest(accountId: publicKey);
            break;
          case BlockChains.xrp:
            accountInfoRequest = XrpAccountInfoRequest(accountId: publicKey);
          default:
            throw Exception('Unsupported blockchain type');
        }
        return blockchainService.getWalletBalance(
          accountInfoRequest: accountInfoRequest,
          blockchainType: blockchainType,
        );
      } else {
        throw Exception("Public key is null");
      }
    }
  }

//accountId: publicKey, blockchainType: blockchainType
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
    required String blockchainType,
    required DerivationPathData derivationPathData,
    required String walletId,
    required String toAddress,
    required String transferAmount,
  }) async {
    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPathData)
        ?.privateKey;

    final publicKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPathData)
        ?.publicKey;

    if (publicKey == null) {
      throw Exception('Public key is null');
    }
    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    late final TransferRequest transferRequest;

    switch (blockchainType) {
      case BlockChains.near:
        transferRequest = NearTransferRequest(
          accountId: publicKey,
          publicKey: publicKey,
          toAddress: toAddress,
          privateKey: privateKey,
          transferAmount: transferAmount,
        );
        break;
      case BlockChains.bitcoin:
        transferRequest = BitcoinTransferRequest(
          publicKey: publicKey,
          toAddress: toAddress,
          privateKey: privateKey,
          transferAmount: transferAmount,
        );
        break;
      default:
        throw Exception('Unsupported blockchain type');
    }

    return blockchainService.sendTransferNativeCoin(
      transferRequest: transferRequest,
      blockchainType: blockchainType,
    );
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required String blockchainType,
    required DerivationPathData derivationPathData,
    required String walletId,
    required String toAddress,
    required RawBlockChainSmartContractArguments rawSmartContractArguments,
  }) async {
    if (!BlockChains.supportedBlockChainsForSmartContractCall
        .contains(blockchainType)) {
      throw Exception('Blockchain does not support smart contract call');
    }

    final wallet = walletsStream.valueOrNull
        ?.firstWhereOrNull((element) => element.id == walletId);
    if (wallet == null) {
      throw Exception('Does not exist wallet with this name');
    }

    final privateKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPathData)
        ?.privateKey;

    final publicKey = wallet.blockchainsData?[blockchainType]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == derivationPathData)
        ?.publicKey;

    if (privateKey == null) {
      throw Exception('Private key is null');
    }

    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    late final BlockChainSmartContractArguments smartContractArguments;

    switch (blockchainType) {
      case BlockChains.near:
        smartContractArguments = NearBlockChainSmartContractArguments(
          accountId: publicKey,
          publicKey: publicKey,
          privateKey: privateKey,
          toAddress: toAddress,
          method: (rawSmartContractArguments
                  as RawNearBlockChainSmartContractArguments)
              .method,
          args: rawSmartContractArguments.args,
          transferAmount: rawSmartContractArguments.transferAmount,
          gas: rawSmartContractArguments.gas,
        );
        break;
      default:
        throw ArgumentError(
            'This blockchain does not support smart contract call');
    }
    return blockchainService.callSmartContractFunction(
      smartContractArguments: smartContractArguments,
      blockchainType: blockchainType,
    );
  }
}
