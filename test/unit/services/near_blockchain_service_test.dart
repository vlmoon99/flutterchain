import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'near_blockchain_service_test.mocks.dart';

@GenerateMocks([
  NearBlockChainService,
])
void main() {
  group('Unit tests for Near Blockchain Service', () {
    test('sendTransferNativeCoin', () async {
      final service = MockNearBlockChainService();
      const toAddress = 'pubkey';
      const fromAddress = 'pubkey2';
      final nearToYoctoNear = NearFormatter.nearToYoctoNear('1');
      const privateKey = 'privateKey in Base64';
      const publicKey = 'publicKey in hex';
      NearTransferRequest nearTransferRequest = NearTransferRequest(
          toAddress: toAddress,
          fromAddress: fromAddress,
          transferAmount: nearToYoctoNear,
          privateKey: privateKey,
          publicKey: publicKey);

      when(
        service.sendTransferNativeCoin(nearTransferRequest),
      ).thenAnswer((_) async =>
          BlockchainResponse(data: {}, status: BlockchainResponses.success));

      final res = await service.sendTransferNativeCoin(nearTransferRequest);
      expect(res,
          BlockchainResponse(data: {}, status: BlockchainResponses.success));
    });

    test('callSmartContractFunction', () async {
      final service = MockNearBlockChainService();
      const toAddress = 'to_address';
      const fromAddress = 'from_address';
      const privateKey = 'privateKey in Base64';
      const publicKey = 'publicKey in hex';
      NearTransferRequest nearTransferRequest = NearTransferRequest(
          toAddress: toAddress,
          fromAddress: fromAddress,
          privateKey: privateKey,
          publicKey: publicKey);

      final arguments = NearBlockChainSmartContractArguments(
        method: 'exampleMethod',
        args: {'exampleArg': 'exampleValue'},
        transferAmount: NearFormatter.nearToYoctoNear('1'),
      );

      when(service.callSmartContractFunction(nearTransferRequest)).thenAnswer(
          (_) async => BlockchainResponse(
              data: {}, status: BlockchainResponses.success));

      final res = await service.callSmartContractFunction(nearTransferRequest);
      expect(res,
          BlockchainResponse(data: {}, status: BlockchainResponses.success));
    });

    test('getBlockChainDataFromMnemonic', () async {
      final service = MockNearBlockChainService();
      const mnemonic = 'example mnemonic';
      const passphrase = 'example passphrase';

      when(service.getBlockChainDataFromMnemonic(mnemonic, passphrase))
          .thenAnswer(
        (_) async => NearBlockChainData(
          publicKey: 'examplePublicKey',
          privateKey: 'examplePrivateKey',
          derivationPath: const DerivationPath(
            purpose: "44'",
            coinType: "397'",
            accountNumber: "0'",
            change: "0'",
            address: "1'",
          ),
          passphrase: passphrase,
        ),
      );

      final res =
          await service.getBlockChainDataFromMnemonic(mnemonic, passphrase);
      expect(
          res,
          NearBlockChainData(
            publicKey: 'examplePublicKey',
            privateKey: 'examplePrivateKey',
            derivationPath: const DerivationPath(
              purpose: "44'",
              coinType: "397'",
              accountNumber: "0'",
              change: "0'",
              address: "1'",
            ),
            passphrase: passphrase,
          ));
    });

    test('getBlockChainDataByDerivationPath', () async {
      final service = MockNearBlockChainService();
      const mnemonic = 'some_mnemonic';
      const passphrase = 'some_passphrase';
      const derivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      final expectedResult = NearBlockChainData(
        publicKey: 'publicKey',
        privateKey: 'privateKey',
        derivationPath: derivationPath,
        passphrase: '',
      );

      when(service.getBlockChainDataByDerivationPath(
        mnemonic: mnemonic,
        passphrase: passphrase,
        derivationPath: derivationPath,
      )).thenAnswer((_) async => expectedResult);

      final result = await service.getBlockChainDataByDerivationPath(
        mnemonic: mnemonic,
        passphrase: passphrase,
        derivationPath: derivationPath,
      );

      expect(result, expectedResult);
    });

    test('getWalletBalance', () async {
      final service = MockNearBlockChainService();
      NearTransferRequest nearTransferRequest =
          NearTransferRequest(accountID: 'test_account_id');

      when(service.getWalletBalance(nearTransferRequest))
          .thenAnswer((_) async => '1000000000000000000000000');

      final res = await service.getWalletBalance(nearTransferRequest);
      expect(res, '1000000000000000000000000');
    });

    test('getNonceAndBlockHashInfo', () async {
      final service = MockNearBlockChainService();
      const accountId = 'test_account_id';
      const publicKey = 'test_public_key';

      when(service.getTransactionInfo(
        accountId: accountId,
        publicKey: publicKey,
      )).thenAnswer(
        (_) async => NearTransactionInfoModel(
          nonce: 1,
          blockHash: 'example_block_hash',
        ),
      );

      final res = await service.getTransactionInfo(
        accountId: accountId,
        publicKey: publicKey,
      );
      expect(
        res,
        NearTransactionInfoModel(
          nonce: 1,
          blockHash: 'example_block_hash',
        ),
      );
    });

    test('sendTransactionNearSync', () async {
      final service = MockNearBlockChainService();
      const tx = 'example_tx';

      when(service.sendTransactionNearSync(params: [tx])).thenAnswer(
          (_) async => BlockchainResponse(
              data: {}, status: BlockchainResponses.success));

      final res = await service.sendTransactionNearSync(params: [tx]);
      expect(res,
          BlockchainResponse(data: {}, status: BlockchainResponses.success));
    });

    test('sendTransactionNearAsync', () async {
      final service = MockNearBlockChainService();
      const tx = 'example_tx';

      when(service.sendTransactionNearAsync(params: [tx])).thenAnswer(
          (_) async => BlockchainResponse(
              data: {}, status: BlockchainResponses.success));

      final res = await service.sendTransactionNearAsync(params: [tx]);
      expect(res,
          BlockchainResponse(data: {}, status: BlockchainResponses.success));
    });
  });
}
