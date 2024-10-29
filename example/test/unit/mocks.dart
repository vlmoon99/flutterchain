import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/near_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/crypto_service.dart';
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
  Future<bool> initCryptoLib() async {
    final wallet = MockWallet(
      id: '2',
      name: "wallet from store",
      mnemonic: "mnemonic",
      passphrase: "passphrase",
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
            passphrase: "passphrase",
          )
        }
      },
    );
    walletsStream.value.add(wallet);
    walletsStream.add(walletsStream.value);
    return true;
  }

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
    required DerivationPathData derivationPath,
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
  Future<BlockchainResponse> callSmartContractFunction({
    required String blockchainType,
    required DerivationPathData derivationPathData,
    required RawBlockChainSmartContractArguments rawSmartContractArguments,
    required String toAddress,
    required String walletId,
  }) async {
    return BlockchainResponse(
      status: 'success',
      data: {'txhash': 'some hash'},
    );
  }

  @override
  Future<BlockchainResponse> sendTransferNativeCoin({
    required String blockchainType,
    required DerivationPathData derivationPathData,
    required String toAddress,
    required String transferAmount,
    required String walletId,
  }) async {
    if (transferAmount == '-1') {
      return BlockchainResponse(
        status: 'failure',
        data: {'message': 'Server error'},
      );
    }
    return BlockchainResponse(
      status: 'success',
      data: {'txhash': 'some hash'},
    );
  }

  @override
  Future<String> getBalanceOfAddressOnSpecificBlockchain({
    String? address,
    required String blockchainType,
    DerivationPathData? derivationPathData,
    String? walletId,
  }) async {
    return '100';
  }

  @override
  Future<void> setBlockchainNetworkEnvironment(
      {required BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings,
      required String blockchainType}) async {
    await blockchainService.setBlockchainNetworkEnvironment(
      blockchainType: blockchainType,
      blockChainNetworkEnvironmentSettings:
          blockChainNetworkEnvironmentSettings,
    );
  }

  @override
  Future<bool> deleteWalletById({required String walletId}) async {
    walletsStream.add(walletsStream.valueOrNull
            ?.where((element) => element.id != walletId)
            .toList() ??
        []);
    return true;
  }
}

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

  @override
  Future<void> setBlockchainNetworkEnvironment(
      {required BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings,
      required String blockchainType}) async {
    await blockchainServices[blockchainType]
        ?.setBlockchainNetworkEnvironment(blockChainNetworkEnvironmentSettings);
  }
}

class MockNearBlockChainService extends Mock implements NearBlockChainService {
  @override
  NearRpcClient get nearRpcClient => MockNearRpcClient();

  @override
  Future<NearTransactionInfoModel> getTransactionInfo(
      {required String accountId, required String publicKey}) async {
    return NearTransactionInfoModel(
      nonce: 125149053000037,
      blockHash: 'blockHash',
    );
  }

  @override
  Future<String> exportPrivateKeyToTheNearApiJsFormat(
      {BlockChainData? currentBlockchainData}) async {
    return 'privateKeyInNearApiJsFormat';
  }

  @override
  Future<String> getPublicKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey) async {
    return 'publicKeyInNearApiJsFormat';
  }

  @override
  Future<String> getPrivateKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey) async {
    return "privateKeyInNearApiJsFormat";
  }

  @override
  Future<String> getBase58PubKeyFromHexValue(
      {required String? hexEncodedPubKey}) async {
    return "base58PubKey with 'ed25519:' prefix";
  }

  @override
  Future<BlockChainNetworkEnvironmentSettings>
      getBlockchainNetworkEnvironment() async {
    return const NearNetworkEnvironmentSettings(chainUrl: "url");
  }

  @override
  Future<String> signNearActions(
      {required String fromAddress,
      required String toAddress,
      required String transferAmount,
      required String privateKey,
      required String gas,
      required int nonce,
      required String blockHash,
      required List<Map<String, dynamic>> actions}) async {
    return 'signedTx';
  }

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
  Future<NearBlockChainData> getBlockChainData(
      {DerivationPathData? derivationPath,
      required String mnemonic,
      String? passphrase}) async {
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

  @override
  Future<BlockchainResponse> callSmartContractFunction(
      BlockChainSmartContractArguments blockChainSmartContractArguments) async {
    return BlockchainResponse(
      status: 'success',
      data: {'txhash': 'some hash'},
    );
  }

  @override
  Future<void> setBlockchainNetworkEnvironment(
      BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings) async {
    nearRpcClient.networkClient.setUrl(
      (blockChainNetworkEnvironmentSettings as NearNetworkEnvironmentSettings)
          .chainUrl,
    );
  }

  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) async {
    if ((transferRequest as NearTransferRequest).transferAmount == '-1') {
      return BlockchainResponse(
        status: 'failure',
        data: {'message': 'Server error'},
      );
    }
    return BlockchainResponse(
      status: 'success',
      data: {'txhash': 'some hash'},
    );
  }

  @override
  Future<String> getWalletBalance(AccountInfoRequest accountInfoRequest) async {
    return '100';
  }

  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return {'url1', 'url2'};
  }
}

class MockNearRpcClient extends Mock implements NearRpcClient {
  @override
  final NearNetworkClient networkClient = MockNearNetworkClient();
}

class MockNearNetworkClient extends Mock implements NearNetworkClient {
  String dioBaseUrl = "new_url";

  @override
  void setUrl(String newUrl) {
    dioBaseUrl = newUrl;
  }

  String getUrl() {
    return dioBaseUrl;
  }
}
