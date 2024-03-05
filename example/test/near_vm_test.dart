import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';

import 'mocks.dart';

void main() {
  group('NearVM', () {
    late NearVM nearVM;
    late MockFlutterChainLibrary mockCryptoLibrary;
    late MockNearBlockchainStore mockNearBlockchainStore;
    late MockUserStore mockUserStore;
    late MockNearHelperService mockNearHelperService;

    setUp(() {
      mockCryptoLibrary = MockFlutterChainLibrary();
      mockNearBlockchainStore = MockNearBlockchainStore();
      mockUserStore = MockUserStore();
      mockNearHelperService = MockNearHelperService();

      nearVM = NearVM(
        mockCryptoLibrary,
        mockNearBlockchainStore,
        mockUserStore,
        mockNearHelperService,
      );
    });

    test('addBlockChainDataByDerivationPath', () async {
      // Arrange
      const derivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );
      const walletID = '0';
      final expectedBlockChainData = NearBlockChainData(
        publicKey: 'publicKey',
        privateKey: 'privateKey',
        accountId: 'accountId',
        derivationPath: derivationPath,
        passphrase: '',
      );

      // Act
      final result = await nearVM.addBlockChainDataByDerivationPath(
        derivationPath: derivationPath,
        walletID: walletID,
      );

      // Assert
      expect(result, expectedBlockChainData);
      expect(
        nearVM.cryptoLibrary.walletsStream.value
            .firstWhere((element) => element.id == walletID)
            .blockchainsData![BlockChains.near]!
            .contains(expectedBlockChainData),
        true,
      );
    });

    test('addKeyNearBlockChain - Success', () async {
      // Arrange
      const permission = "functionCall";
      const allowance = '1';
      const smartContractId = 'some_contract_with_success_execution';
      final methodNames = ['method1', 'method2'];
      const walletID = '0';
      const currentDerivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      final expectedResponse = BlockchainResponse(
        status: 'success',
        data: {'txhash': 'some hash'},
      );

      // Act
      final result = await nearVM.addKeyNearBlockChain(
        permission: permission,
        allowance: allowance,
        smartContractId: smartContractId,
        methodNames: methodNames,
        walletID: walletID,
        currentDerivationPath: currentDerivationPath,
      );

      // Assert
      expect(result, expectedResponse);
    });

    test('addKeyNearBlockChain - Failure', () async {
      // Arrange
      const permission = "functionCall";
      const allowance = '1';
      const smartContractId = 'some_contract_with_failure';
      final methodNames = ['method1', 'method2'];
      const walletID = '0';
      const currentDerivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      final expectedResponse = BlockchainResponse(
        status: 'failure',
        data: {'message': 'Server error'},
      );

      // Act
      final result = await nearVM.addKeyNearBlockChain(
        permission: permission,
        allowance: allowance,
        smartContractId: smartContractId,
        methodNames: methodNames,
        walletID: walletID,
        currentDerivationPath: currentDerivationPath,
      );

      // Assert
      expect(result, expectedResponse);
    });

    test('deleteKeyNearBlockChain', () async {
      // Arrange
      const walletID = '0';
      const currentDerivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );
      const deletedPublicKey = "public functional key";
      final expectedResponse = BlockchainResponse(
        status: 'success',
        data: {'txhash': 'some hash'},
      );

      // Act
      final result = await nearVM.deleteKeyNearBlockChain(
        walletID: walletID,
        currentDerivationPath: currentDerivationPath,
        deletedPublicKey: deletedPublicKey,
      );

      // Assert
      expect(result, expectedResponse);
    });

    test("callSmartContractFunction", () async {
      // Arrange
      final args = {'arg1': 'value1', 'arg2': 'value2'};
      const amountOfDeposit = '1';
      const smartContractAddress = 'some_contract_address';
      const method = 'some_method';
      const walletID = '0';
      const currentDerivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      final expectedResponse = BlockchainResponse(
        status: 'success',
        data: {'txhash': 'some hash'},
      );

      // Act
      final result = await nearVM.callSmartContractFunction(
        args: args,
        amountOfDeposit: amountOfDeposit,
        walletId: walletID,
        smartContractAddress: smartContractAddress,
        method: method,
        currentDerivationPath: currentDerivationPath,
      );

      // Assert
      expect(result, expectedResponse);
    });

    test('sendNativeCoinTransferByWalletId - Success', () async {
      // Arrange
      const toAddress = 'receiver_address';
      const transferAmount = '10';
      const walletId = '0';
      const typeOfBlockchain = BlockChains.near;
      const currentDerivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      final expectedResponse = BlockchainResponse(
        status: 'success',
        data: {'txhash': 'some hash'},
      );

      // Act
      final result = await nearVM.sendNativeCoinTransferByWalletId(
        toAddress: toAddress,
        transferAmount: transferAmount,
        walletId: walletId,
        typeOfBlockchain: typeOfBlockchain,
        currentDerivationPath: currentDerivationPath,
      );

      // Assert
      expect(result, expectedResponse);
    });

    test('getMnemonicPhraseByWalletName', () async {
      // Arrange
      const walletId = 'Wallet 0';
      const expectedMnemonicPhrase = 'mnemonic wallet 0';

      // Act
      final result = await nearVM.getMnemonicPhraseByWalletName(walletId);

      // Assert
      expect(result, expectedMnemonicPhrase);
    });

    test('getBalanceByDerivationPath', () async {
      // Arrange
      const walletId = '0';
      const currentDerivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      // Act
      final result = await nearVM.getBalanceByDerivationPath(
        walletId: walletId,
        currentDerivationPath: currentDerivationPath,
      );

      // Assert
      expect(result, '100');
    });
  });
}
