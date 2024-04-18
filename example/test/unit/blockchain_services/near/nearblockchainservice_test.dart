import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

import '../../mocks.dart';

void main() {
  group("Unit tests for NearBlockChainService", () {
    late MockNearBlockChainService mockNearBlockChainService;

    setUp(() {
      mockNearBlockChainService = MockNearBlockChainService();
    });

    test('addKey - Success', () async {
      // Arrange
      const fromAddress = "accountId";
      const mnemonic = 'mnemonic';
      const passphrase = 'passphrase';
      const derivationPathOfNewGeneratedAccount = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );
      const permission = 'functionCall';
      const allowance = '1';
      const smartContractId = 'some_contract_with_success_execution';
      const methodNames = ['method1', 'method2'];
      const privateKey = 'private_key';
      const publicKey = 'public_key';

      // Act
      final response = await mockNearBlockChainService.addKey(
        fromAddress: fromAddress,
        mnemonic: mnemonic,
        passphrase: passphrase,
        derivationPathOfNewGeneratedAccount:
            derivationPathOfNewGeneratedAccount,
        permission: permission,
        allowance: allowance,
        smartContractId: smartContractId,
        methodNames: methodNames,
        privateKey: privateKey,
        publicKey: publicKey,
      );

      // Assert
      expect(response.status, 'success');
    });

    test('addKey - Failure', () async {
      // Arrange
      const fromAddress = "accountId";
      const mnemonic = 'mnemonic';
      const passphrase = 'passphrase';
      const derivationPathOfNewGeneratedAccount = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );
      const permission = 'functionCall';
      const allowance = '1';
      const smartContractId = 'some_contract_with_failure_execution';
      const methodNames = ['method1', 'method2'];
      const privateKey = 'private_key';
      const publicKey = 'public_key';

      // Act
      final response = await mockNearBlockChainService.addKey(
        fromAddress: fromAddress,
        mnemonic: mnemonic,
        passphrase: passphrase,
        derivationPathOfNewGeneratedAccount:
            derivationPathOfNewGeneratedAccount,
        permission: permission,
        allowance: allowance,
        smartContractId: smartContractId,
        methodNames: methodNames,
        privateKey: privateKey,
        publicKey: publicKey,
      );

      // Assert
      expect(response.status, 'failure');
    });

    test("deleteKey", () async {
      // Arrange
      const accountId = "accountId";
      const deletedPublicKey = "public functional key";
      const privateKey = "privateKey";
      const publicKey = "publicKey";

      // Act
      final response = await mockNearBlockChainService.deleteKey(
        accountId: accountId,
        deletedPublicKey: deletedPublicKey,
        privateKey: privateKey,
        publicKey: publicKey,
      );

      // Assert
      expect(response.status, 'success');
    });

    test('callSmartContractFunction', () async {
      // Arrange
      const toAddress = 'to_address';
      const fromAddress = 'from_address';
      const privateKey = 'privateKey';
      const publicKey = 'publicKey';

      final arguments = NearBlockChainSmartContractArguments(
        method: 'exampleMethod',
        args: {'exampleArg': 'exampleValue'},
        transferAmount: NearFormatter.nearToYoctoNear('1'),
      );

      final expectedResponse = BlockchainResponse(
        status: 'success',
        data: {'txhash': 'some hash'},
      );

      // Act
      final response =
          await mockNearBlockChainService.callSmartContractFunction(
        toAddress,
        fromAddress,
        privateKey,
        publicKey,
        arguments,
      );

      // Assert
      expect(response, expectedResponse);
    });

    test('sendTransferNativeCoin', () async {
      // Arrange
      const toAddress = 'reciver pubkey';
      const fromAddress = 'sender pubkey';
      final transferAmount = NearFormatter.nearToYoctoNear('1');
      const privateKey = 'sender privateKey';
      const publicKey = 'sender publicKey';

      final expectedResponse = BlockchainResponse(
        status: 'success',
        data: {'txhash': 'some hash'},
      );

      NearTransferRequest nearTransferRequest = NearTransferRequest(
          toAddress: toAddress, transferAmount: transferAmount);

      // Act
      final response = await mockNearBlockChainService
          .sendTransferNativeCoin(nearTransferRequest);

      // Assert
      expect(response, expectedResponse);
    });

    test('getWalletBalance', () async {
      // Arrange
      NearTransferRequest nearTransferRequest =
          NearTransferRequest(accountID: 'accountId');

      // Act
      final response = await mockNearBlockChainService.getWalletBalance(
        nearTransferRequest,
      );

      // Assert
      expect(response, '100');
    });

    test('getBlockchainsUrlsByBlockchainType', () {
      // Arrange
      const expectedUrls = {'url1', 'url2'};

      // Act
      final urls =
          mockNearBlockChainService.getBlockchainsUrlsByBlockchainType();

      // Assert
      expect(urls, expectedUrls);
    });

    test("setBlockchainNetworkEnvironment", () async {
      // Arrange
      const newUrl = 'new_url';

      // Act
      await mockNearBlockChainService.setBlockchainNetworkEnvironment(
          newUrl: newUrl);

      // Assert
      expect(
        (mockNearBlockChainService.nearRpcClient.networkClient
                as MockNearNetworkClient)
            .getUrl(),
        newUrl,
      );
    });

    test('getBlockchainNetworkEnvironment', () async {
      // Arrange
      const expectedUrl = 'url';

      // Act
      final url =
          await mockNearBlockChainService.getBlockchainNetworkEnvironment();

      // Assert
      expect(url, expectedUrl);
    });

    test('getBlockChainDataByDerivationPath', () async {
      // Arrange
      const mnemonic = 'mnemonic';
      const passphrase = 'passphrase';
      const derivationPath = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      // Act
      final blockChainData =
          await mockNearBlockChainService.getBlockChainDataByDerivationPath(
        mnemonic: mnemonic,
        passphrase: passphrase,
        derivationPath: derivationPath,
      );

      // Assert
      expect(
        blockChainData,
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
        ),
      );
    });

    test('getTransactionInfo', () async {
      // Arrange
      const accountId = 'accountId';
      const publicKey = 'publicKey';
      final expectedNearTransactionInfoModel = NearTransactionInfoModel(
        nonce: 125149053000037,
        blockHash: 'blockHash',
      );

      // Act
      final transactionInfo =
          await mockNearBlockChainService.getTransactionInfo(
        accountId: accountId,
        publicKey: publicKey,
      );

      // Assert
      expect(transactionInfo, expectedNearTransactionInfoModel);
    });

    test('signNearActions', () async {
      // Arrange
      const fromAddress = 'fromAddress';
      const toAddress = 'toAddress';
      const transferAmount = 'transferAmount';
      const privateKey = 'privateKey';
      const gas = 'gas';
      const nonce = 125149053000037;
      const blockHash = 'blockHash';
      final actions = [
        {
          "type": "action type",
          "data": {},
        },
      ];

      // Act
      final signedAction = await mockNearBlockChainService.signNearActions(
        fromAddress: fromAddress,
        toAddress: toAddress,
        transferAmount: transferAmount,
        privateKey: privateKey,
        gas: gas,
        nonce: nonce,
        blockHash: blockHash,
        actions: actions,
      );

      // Assert
      expect(signedAction, "signedTx");
    });

    test('exportPrivateKeyToTheNearApiJsFormat', () async {
      // Arrange
      final blockChainData = NearBlockChainData(
        publicKey: 'publicKey',
        privateKey: 'privateKeyInFlutterchainFormat',
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

      // Act
      final exportedPrivateKey =
          await mockNearBlockChainService.exportPrivateKeyToTheNearApiJsFormat(
        currentBlockchainData: blockChainData,
      );

      // Assert
      expect(exportedPrivateKey, "privateKeyInNearApiJsFormat");
    });

    test('getPublicKeyFromSecretKeyFromNearApiJSFormat', () async {
      // Arrange
      const secretKey = 'secretKeyFromNearApiJSFormat';

      // Act
      final publicKey = await mockNearBlockChainService
          .getPublicKeyFromSecretKeyFromNearApiJSFormat(secretKey);

      // Assert
      expect(publicKey, "publicKeyInNearApiJsFormat");
    });

    test('getPrivateKeyFromSecretKeyFromNearApiJSFormat', () async {
      // Arrange
      const secretKey = 'secretKeyFromNearApiJSFormat';

      // Act
      final privateKey = await mockNearBlockChainService
          .getPrivateKeyFromSecretKeyFromNearApiJSFormat(secretKey);

      // Assert
      expect(privateKey, "privateKeyInNearApiJsFormat");
    });

    test('getBase58PubKeyFromHexValue', () async {
      // Arrange
      const publicKey = 'publicKey';

      // Act
      final base58PubKey = await mockNearBlockChainService
          .getBase58PubKeyFromHexValue(hexEncodedPubKey: publicKey);

      // Assert
      expect(base58PubKey, "base58PubKey with 'ed25519:' prefix");
    });
  });
}
