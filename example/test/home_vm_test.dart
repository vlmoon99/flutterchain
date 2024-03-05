import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/vms/core/home_vm.dart';

import 'mocks.dart';

void main() {
  group('HomeVM', () {
    late HomeVM homeVM;
    late MockFlutterChainLibrary mockCryptoLibrary;
    late MockUserStore mockUserStore;

    setUp(() {
      mockCryptoLibrary = MockFlutterChainLibrary();
      mockUserStore = MockUserStore();
      homeVM = HomeVM(mockCryptoLibrary, mockUserStore);
    });

    test('getBlockchainsUrlsByBlockchainType', () {
      // Arrange
      const blockchainType = BlockChains.near;
      final expectedUrls = {
        "https://example.com/blockchain1",
        "https://example.com/blockchain2"
      };

      // Act
      final result = homeVM.getBlockchainsUrlsByBlockchainType(blockchainType);

      // Assert
      expect(result, expectedUrls);
    });

    test('createWallet with generated mnemonic', () async {
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
      await homeVM.createWallet(null, expectedWalletName);
      final walletId = homeVM.userStore.walletIdStream.value;
      final wallet = homeVM.cryptoLibrary.walletsStream.value.last;

      // Assert
      expect(walletId, expectedWalletId);
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

    test('createWallet with imported mnemonic', () async {
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
      await homeVM.createWallet(expectedMnemonic, expectedWalletName);
      final walletId = homeVM.userStore.walletIdStream.value;
      final wallet = homeVM.cryptoLibrary.walletsStream.value.last;

      // Assert
      expect(walletId, expectedWalletId);
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
  });
}
