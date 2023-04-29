import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchains_gas.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_specific_arguments_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

void main() {
  group('Wallet tests', () {
    test('Test creating a wallet with no blockchain data', () {
      final wallet = Wallet(
        id: '123',
        name: 'Test Wallet',
        mnemonic: 'test mnemonic',
      );

      expect(wallet.id, '123');
      expect(wallet.name, 'Test Wallet');
      expect(wallet.mnemonic, 'test mnemonic');
      expect(wallet.passphrase, isNull);
      expect(wallet.blockchainsData, isNull);
    });

    test('Test creating a wallet with blockchain data', () {
      final nearData = NearBlockChainData(
        publicKey: 'near public key',
        privateKey: 'near private key',
        derivationPath: const DerivationPath(
          purpose: '44',
          coinType: '397',
          accountNumber: '0',
          change: '0',
          address: '1',
        ),
        passphrase: 'passphrase',
      );

      final wallet = Wallet(
        id: '123',
        name: 'Test Wallet',
        mnemonic: 'test mnemonic',
        blockchainsData: {
          BlockChains.near: {nearData},
        },
      );

      expect(wallet.blockchainsData, isNotNull);
      expect(wallet.blockchainsData!.length, 1);
      expect(
          wallet.blockchainsData![BlockChains.near]!
              .firstWhere((element) =>
                  element.derivationPath == nearData.derivationPath)
              .publicKey,
          'near public key');
      expect(
          wallet.blockchainsData![BlockChains.near]!
              .firstWhere((element) =>
                  element.derivationPath == nearData.derivationPath)
              .privateKey,
          'near private key');
    });
  });

  group('NearBlockChainSpecificArgumentsData tests', () {
    test('Test creating NearBlockChainSpecificArgumentsData', () {
      final gasValue = BlockchainGas.gas[BlockChains.near]!;

      final data = NearBlockChainSpecificArgumentsData(
        privateKey: 'private key',
        gas: gasValue,
        nonce: 1,
        blockHash: 'block hash',
        actions: [
          {
            "type": "transfer",
            "data": {"amount": "1000000000000000000000000"}
          }
        ],
      );

      expect(data.privateKey, 'private key');
      expect(data.gas, '30000000000000');
      expect(data.nonce, 1);
      expect(data.blockHash, 'block hash');
      expect(data.actions.length, 1);
      expect(data.actions[0]['type'], 'transfer');
      expect(data.actions[0]['data']['amount'], '1000000000000000000000000');
    });
  });

  group('NearTransactionInfoModel tests', () {
    test('Test creating NearTransactionInfoModel', () {
      final data = NearTransactionInfoModel(
        nonce: 1,
        blockHash: 'block hash',
      );

      expect(data.nonce, 1);
      expect(data.blockHash, 'block hash');
    });
  });

  group('BlockchainGas tests', () {
    test('Test getting gas value for NEAR blockchain', () {
      final gasValue = BlockchainGas.gas[BlockChains.near];

      expect(gasValue, '30000000000000');
    });
  });
}
