import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/crypto_service.dart';
import 'package:flutterchain_example/modules/home/services/helper_service.dart';
import 'package:flutterchain_example/modules/home/stores/chains/near_blockchain_store.dart';
import 'package:flutterchain_example/modules/home/stores/core/user_store.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

class MockFlutterChainLibrary extends Mock implements FlutterChainLibrary {
  @override
  final BehaviorSubject<List<Wallet>> walletsStream =
      BehaviorSubject<List<Wallet>>.seeded(
    [
      MockWallet(
        id: '0',
        name: 'Wallet 0',
        mnemonic: 'mnemonic wallet 0',
        passphrase: '',
        blockchainsData: {
          BlockChains.near: {
            NearBlockChainData(
              publicKey: 'publicKey',
              privateKey: 'privateKey',
              accountId: 'accountId',
              derivationPath: const DerivationPath(
                purpose: "44'",
                coinType: "397'",
                accountNumber: "0'",
                change: "0'",
                address: "1'",
              ),
              passphrase: '',
            )
          }
        },
      )
    ],
  );

  @override
  final FlutterChainService blockchainService = MockFlutterChainService();

  @override
  Set<String> getBlockchainsUrlsByBlockchainType(String blockchainType) {
    return {
      "https://example.com/blockchain1",
      "https://example.com/blockchain2"
    };
  }

  @override
  Future<Wallet> createWalletWithGeneratedMnemonic({
    required String walletName,
    String passphrase = '',
  }) async {
    return await createWalletByImportedMnemonic(
      mnemonic: 'test mnemonic',
      walletName: walletName,
      passphrase: passphrase,
    );
  }

  @override
  Future<Wallet> createWalletByImportedMnemonic({
    required String mnemonic,
    required String walletName,
    String passphrase = '',
  }) async {
    final wallet = MockWallet(
      id: '1',
      name: walletName,
      mnemonic: mnemonic,
      passphrase: passphrase,
      blockchainsData: {
        BlockChains.near: {
          NearBlockChainData(
            publicKey: 'publicKey',
            privateKey: 'privateKey',
            accountId: 'accountId',
            derivationPath: const DerivationPath(
              purpose: "44'",
              coinType: "397'",
              accountNumber: "0'",
              change: "0'",
              address: '1',
            ),
            passphrase: passphrase,
          )
        }
      },
    );
    walletsStream.value.add(wallet);
    walletsStream.add(walletsStream.value);
    return wallet;
  }

  @override
  Future<BlockChainData> addBlockChainDataByDerivationPath({
    required DerivationPath derivationPath,
    required String blockchainType,
    required String walletID,
  }) async {
    final wallet =
        walletsStream.value.firstWhere((element) => element.id == walletID);
    final blockChainData = NearBlockChainData(
      publicKey: 'publicKey',
      privateKey: 'privateKey',
      accountId: 'accountId',
      derivationPath: const DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      ),
      passphrase: '',
    );
    wallet.blockchainsData![blockchainType] = {
      ...wallet.blockchainsData![blockchainType] ?? {},
      blockChainData
    };
    walletsStream.value[walletsStream.value
        .indexWhere((element) => element.id == walletID)] = wallet;
    walletsStream.add(walletsStream.value);
    return blockChainData;
  }

  @override
  Future<BlockchainResponse> callSmartContractFunction(
      {required String walletId,
      required String typeOfBlockchain,
      required DerivationPath currentDerivationPath,
      required String toAddress,
      required BlockChainSmartContractArguments arguments}) async {
    return BlockchainResponse(
      status: 'success',
      data: {'txhash': 'some hash'},
    );
  }

  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      {required String walletId,
      required String typeOfBlockchain,
      required String toAddress,
      required String transferAmount,
      required DerivationPath currentDerivationPath}) async {
    return BlockchainResponse(
      status: 'success',
      data: {'txhash': 'some hash'},
    );
  }

  @override
  Future<String> getBalanceOfAddressOnSpecificBlockchain({
    required String walletId,
    required String blockchainType,
    required DerivationPath currentDerivationPath,
  }) async {
    return '100';
  }
}

class MockUserStore extends Mock implements UserStore {
  @override
  final BehaviorSubject<String> walletIdStream = BehaviorSubject<String>.seeded(
      '0'); // Встановлюємо початкове значення для walletIdStream
}

class MockNearBlockchainStore extends Mock implements NearBlockchainStore {}

class MockNearHelperService extends Mock implements NearHelperService {}

class MockWallet extends Wallet {
  MockWallet({
    required super.id,
    required super.name,
    required super.mnemonic,
    super.passphrase,
    super.blockchainsData,
  });

  @override
  operator ==(Object other) {
    // return other is MockWallet &&
    return other is MockWallet &&
        other.id == id &&
        other.name == name &&
        other.mnemonic == mnemonic &&
        other.passphrase == passphrase &&
        other.blockchainsData![BlockChains.near]!.last ==
            blockchainsData![BlockChains.near]!.last;
  }
}

class MockFlutterChainService extends Mock implements FlutterChainService {
  @override
  final Map<String, BlockChainService> blockchainServices = {
    BlockChains.near: MockNearBlockChainService(),
  };

  @override
  Future<Wallet> generateNewWallet(
      {String passphrase = '', required String walletName}) {
    return Future.value(
      MockWallet(
        id: '1',
        name: walletName,
        mnemonic: 'test mnemonic',
        passphrase: passphrase,
        blockchainsData: {
          BlockChains.near: {},
        },
      ),
    );
  }
}

class MockNearBlockChainService extends Mock implements NearBlockChainService {
  @override
  Future<BlockchainResponse> addKey({
    required String fromAddress,
    required String mnemonic,
    String passphrase = '',
    required DerivationPath derivationPathOfNewGeneratedAccount,
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String privateKey,
    required String publicKey,
  }) async {
    if (smartContractId == 'some_contract_with_success_execution') {
      return BlockchainResponse(
        status: 'success',
        data: {'txhash': 'some hash'},
      );
    } else {
      return BlockchainResponse(
        status: 'failure',
        data: {'message': 'Server error'},
      );
    }
  }

  @override
  Future<NearBlockChainData> getBlockChainDataByDerivationPath(
      {required String mnemonic,
      required String? passphrase,
      required DerivationPath derivationPath}) async {
    return NearBlockChainData(
      publicKey: 'publicKey',
      privateKey: 'privateKey',
      accountId: 'accountId',
      derivationPath: const DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      ),
      passphrase: '',
    );
  }

  @override
  Future<BlockchainResponse> deleteKey(
      {required String accountId,
      required String deletedPublicKey,
      required String privateKey,
      required String publicKey}) async {
    return BlockchainResponse(
      status: 'success',
      data: {'txhash': 'some hash'},
    );
  }
}
