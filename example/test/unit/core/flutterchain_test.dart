import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

import '../mocks.dart';

void main() {
  group("Unit tests for Flutterchain", () {
    late MockFlutterChainLibrary mockCryptoLibrary;

    setUp(() {
      mockCryptoLibrary = MockFlutterChainLibrary();
    });

    test("initCryptoLib", () async {
      // Arrange
      const expectedResult = true;

      // Act
      final result = await mockCryptoLibrary.initCryptoLib();

      // Assert
      expect(result, expectedResult);
      expect(
        mockCryptoLibrary.walletsStream.value
            .any((element) => element.name == "wallet from store"),
        true,
      );
    });

    test('getBlockchainsUrlsByBlockchainType', () {
      // Arrange
      const blockchainType = BlockChains.near;
      final expectedUrls = {
        "https://example.com/blockchain1",
        "https://example.com/blockchain2"
      };

      // Act
      final result =
          mockCryptoLibrary.getBlockchainsUrlsByBlockchainType(blockchainType);

      // Assert
      expect(result, expectedUrls);
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
      const blockchainType = BlockChains.near;
      const walletID = '0';

      final expectedBlockChainData = NearBlockChainData(
        publicKey: 'publicKey',
        privateKey: 'privateKey',
        accountId: 'accountId',
        derivationPath: derivationPath,
        passphrase: '',
      );

      // Act
      final result = await mockCryptoLibrary.addBlockChainDataByDerivationPath(
        derivationPath: derivationPath,
        blockchainType: blockchainType,
        walletID: walletID,
      );

      // Assert
      expect(result, expectedBlockChainData);
      expect(
        mockCryptoLibrary.walletsStream.value
            .firstWhere((element) => element.id == walletID)
            .blockchainsData![BlockChains.near]!
            .contains(expectedBlockChainData),
        true,
      );
    });

    test('createWalletWithGeneratedMnemonic', () async {
      // Arrange
      const expectedWalletId = '1';
      const expectedWalletName = 'Test Wallet';
      const expectedMnemonic = "test mnemonic";
      const expectedPassphrase = '';
      final expectedblockchainsData = {
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
            passphrase: '',
          )
        }
      };

      // Act
      await mockCryptoLibrary.createWalletWithGeneratedMnemonic(
          walletName: expectedWalletName, passphrase: expectedPassphrase);
      final wallet = mockCryptoLibrary.walletsStream.value.last;

      // Assert
      expect(
        wallet,
        MockWallet(
          id: expectedWalletId,
          name: expectedWalletName,
          mnemonic: expectedMnemonic,
          passphrase: expectedPassphrase,
          blockchainsData: expectedblockchainsData,
        ),
      );
    });

    test('createWalletByImportedMnemonic', () async {
      // Arrange
      const expectedWalletId = '1';
      const expectedWalletName = 'Test Wallet';
      const expectedMnemonic = "test mnemonic imported";
      const expectedPassphrase = '';
      final expectedblockchainsData = {
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
            passphrase: '',
          )
        }
      };

      // Act
      await mockCryptoLibrary.createWalletByImportedMnemonic(
        mnemonic: expectedMnemonic,
        walletName: expectedWalletName,
        passphrase: expectedPassphrase,
      );
      final wallet = mockCryptoLibrary.walletsStream.value.last;

      // Assert
      expect(
        wallet,
        MockWallet(
          id: expectedWalletId,
          name: expectedWalletName,
          mnemonic: expectedMnemonic,
          passphrase: expectedPassphrase,
          blockchainsData: expectedblockchainsData,
        ),
      );
    });

    test('deleteWalletById', () async {
      // Arrange
      const walletId = 'delete';
      mockCryptoLibrary.walletsStream.value.add(MockWallet(
          id: walletId,
          name: "wallet",
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
          }));

      mockCryptoLibrary.walletsStream
          .add(mockCryptoLibrary.walletsStream.value);

      // Act
      final result =
          await mockCryptoLibrary.deleteWalletById(walletId: walletId);

      // Assert
      expect(result, true);
      expect(
        mockCryptoLibrary.walletsStream.value
            .firstWhereOrNull((element) => element.id == walletId),
        null,
      );
    });

    // test('getBalanceOfAddressOnSpecificBlockchain', () async {
    //   // Arrange
    //   const walletId = '0';
    //   const currentDerivationPath = DerivationPath(
    //     purpose: "44'",
    //     coinType: "397'",
    //     accountNumber: "0'",
    //     change: "0'",
    //     address: "1'",
    //   );
    //   const expectedBalance = '100';

    //   TransferRequest transferRequest = TransferRequest();

    //   // Act
    //   final result =
    //       await mockCryptoLibrary.getBalanceOfAddressOnSpecificBlockchain(
    //    transferRequest:
    //   );

    //   // Assert
    //   expect(result, expectedBalance);
    // });

    test('sendNativeCoinTransferByWalletId - Success', () async {
      // Arrange
      const toAddress = 'receiver_address';
      const transferAmount = '10';
      const walletId = '0';
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

      NearTransferRequest nearTransferRequest = NearTransferRequest(
          toAddress: toAddress,
          transferAmount: transferAmount,
          walletId: walletId,
          currentDerivationPath: currentDerivationPath);

      // Act
      final result = await mockCryptoLibrary.sendTransferNativeCoin(
          transferRequest: nearTransferRequest);

      // Assert
      expect(result, expectedResponse);
    });

    test('sendNativeCoinTransferByWalletId - Failure', () async {
      // Arrange
      const toAddress = 'receiver_address';
      const transferAmount = '-1';
      const walletId = '0';
      const currentDerivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );
      NearTransferRequest nearTransferRequest = NearTransferRequest(
          toAddress: toAddress,
          transferAmount: transferAmount,
          walletId: walletId,
          currentDerivationPath: currentDerivationPath);

      final expectedResponse = BlockchainResponse(
        status: 'failure',
        data: {'message': 'Server error'},
      );

      // Act
      final result = await mockCryptoLibrary.sendTransferNativeCoin(
          transferRequest: nearTransferRequest);

      // Assert
      expect(result, expectedResponse);
    });

    test("callSmartContractFunction", () async {
      // Arrange
      final args = {'arg1': 'value1', 'arg2': 'value2'};
      final amountOfDeposit = NearFormatter.nearToYoctoNear("1");
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
      final result = await mockCryptoLibrary.callSmartContractFunction(
        blockchainType: BlockChains.near,
        derivationPathData: currentDerivationPath,
        walletId: walletID,
        toAddress: smartContractAddress,
        method: method,
        args: args,
        transferAmount: amountOfDeposit,
      );

      // Assert
      expect(result, expectedResponse);
    });

    test("setBlockchainNetworkEnvironment", () async {
      // Arrange
      const newUrl = 'new_url';

      // Act
      await mockCryptoLibrary.setBlockchainNetworkEnvironment(
        blockChainNetworkEnvironmentSettings:
            NearNetworkEnvironmentSettings(chainUrl: newUrl),
        blockchainType: BlockChains.near,
      );

      // Assert
      expect(
        ((mockCryptoLibrary
                        .blockchainService.blockchainServices[BlockChains.near]
                    as MockNearBlockChainService)
                .nearRpcClient
                .networkClient as MockNearNetworkClient)
            .getUrl(),
        newUrl,
      );
    });
  });
}
