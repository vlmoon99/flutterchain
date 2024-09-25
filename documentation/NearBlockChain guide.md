## About
NearBlockChainService allow to interact with Near Blockchain.

### Initialization

To initialize NearBlockChainService we can use the default constructor and named constructor `defaultInstance` which set to testnet environment.

```dart
  final service = NearBlockChainService.defaultInstance();
  
  final service_2 = NearBlockChainService(
    nearRpcClient: NearRpcClient(
      networkClient: NearNetworkClient(
        baseUrl: NearBlockChainNetworkUrls.listOfUrls.first,
      ),
    ),
  );

```

### Changing network environment

We also set network setting later and get current network setting.

```dart
  await service.setBlockchainNetworkEnvironment(NearNetworkEnvironmentSettings(
      chainUrl: NearBlockChainNetworkUrls.listOfUrls.first));
  final nearNetworkEnvironmentSettings = await service.getBlockchainNetworkEnvironment() as NearNetworkEnvironmentSettings;
  print(nearNetworkEnvironmentSettings.chainUrl);
```

### Account creation

To create new Near account we can use `generateNewWallet` and get `BlockchainData`.

```dart
  final mnemonic = await service.generateMnemonic(); // strength from 128 (12 words) to 256 (24 words)

  final blockChainData = await service.getBlockChainData(mnemonic: mnemonic) as NearBlockChainData; // also available passphrase and derivation path (defaults to m/44'/397'/0'/0'/1')

  final blockChainDataByCustomDerivationPath = await service.getBlockChainData(
    mnemonic: mnemonic,
    derivationPath: const DerivationPath(
      purpose: "44'",
      coinType: "397'",
      accountNumber: "0'",
      change: "0'",
      address: "2'",
    ),
  ) as NearBlockChainData;

  print(blockChainData.accountId);
  print(blockChainData.publicKey);
  print(blockChainData.privateKey);
```

`BlockchainData` contains public key and private key. Also don't forget to use it as `NearBlockChainData` to get access to accountId;

### Key transforms

NearBlockChainService uses `BlockChainData`'s private key in flutterchain format. To export it to near api js format we can use `exportPrivateKeyToTheNearApiJsFormat`: 

```dart
  final secretKey = await service.exportPrivateKeyToTheNearApiJsFormat(
    currentBlockchainData: blockChainData,
  ); // will look like ed25519:2KtpCfrY4ts3zAupKEcuGzVBnNQrvAoswVnjoZjY1VZKhpKcaypsVqcCtfSW3pirTtWsyRzEcQeQwAuNHqLQ5pj6
```

And reverse operation is `getPrivateKeyFromSecretKeyFromNearApiJSFormat` :

```dart
  final secretKey =
      "ed25519:w6iUJ6uLt1crmMcYMqeWXk3UVAzXzmgTibcsno639PCUfAQtxvbysXyxeeKja6BuwcA7B8gcMDXm4WiHAo6UgfF"; // near api js format

  final privKeyFromSecretKeyNearApiJsFormat =
      await service.getPrivateKeyFromSecretKeyFromNearApiJSFormat(
    secretKey.split(":").last,
  ); // returns key like this "LqcLu3l93qd3LkRc+pSHtol+Du01CkLfsYHCgGp3Vc4="
```

There are also few transform methods:

Obtaining the NEAR API JS format public key from a FlutterChain private key is is facilitated by the method `getPublicKeyFromSecretKeyFromNearApiJSFormat`:

```dart
  final secretKey =
      "ed25519:w6iUJ6uLt1crmMcYMqeWXk3UVAzXzmgTibcsno639PCUfAQtxvbysXyxeeKja6BuwcA7B8gcMDXm4WiHAo6UgfF"; // near api js format

  final pubKeyFromSecretKeyNearApiJsFormat =
      await service.getPublicKeyFromSecretKeyFromNearApiJSFormat(
    secretKey.split(":").last, 
  ); // will look lite fe8d9843db0a52e810361afcd9ec5d7d319de1e41d4dbe5cddbd790b6807b6ae
```

Transforming NEAR API JS format public key to Base58 format with "ed25519:" prefix by `getBase58PubKeyFromHexValue` method:

```dart
  final base58PubKeyFromHexValue =
      await service.getBase58PubKeyFromHexValue(
    hexEncodedPubKey:
        "fe8d9843db0a52e810361afcd9ec5d7d319de1e41d4dbe5cddbd790b6807b6ae",
  ); // output: ed25519:J8fnNvDEy79DLozTJQ2cgT4pa7E8yEzmeRqyFAgUdC6H
```

### Coins transfer
To transfer native coins, the method `sendTransferNativeCoin` can be utilized:

```dart
  final blockchainResponse = await service.sendTransferNativeCoin(
    NearTransferRequest(
      publicKey: blockChainData.publicKey,
      privateKey: blockChainData.privateKey,
      toAddress: "test.testnet",
      transferAmount: NearFormatter.nearToYoctoNear("1"), // transferAmount must be in yoctoNEAR
    ),
  );

  print(blockchainResponse.data["txHash"]);
```

The retrieved blockchainResponse depending on result of transaction executing has following structure:

 BlockchainResponse(
  data: {
    "txHash": transactionHash,
    "success": response,
  },
  status: BlockchainResponses.success,
)

or

BlockchainResponse(
  data: {
    "txHash": transactionHash,
    "error": functionCallError ?? executionError,
  },
  status: BlockchainResponses.error
)

### Smart contract call

```dart
  final blockchainResponse = service.callSmartContractFunction(
    NearBlockChainSmartContractArguments(
      publicKey: blockChainData.publicKey,
      privateKey: blockChainData.privateKey,
      toAddress: "test.testnet",
      method: "set_greeting",
      args: {"message": "hello"},
      transferAmount: NearFormatter.nearToYoctoNear("0"),
    ),
  );
```

About `blockchainResponse` see above.

### FunctionCall/FullAccess key management

Adding key:

```dart
  final tempMnemonic = await service.generateMnemonic();

  const tempDerivationPath = DerivationPath(
    purpose: "44'",
    coinType: "397'",
    accountNumber: "0'",
    change: "0'",
    address: "1'",
  );

  final tempBlockChainData = await service.getBlockChainData(
      mnemonic: tempMnemonic,
      derivationPath: tempDerivationPath) as NearBlockChainData;

  final fromAddress = blockChainData.accountId ?? blockChainData.publicKey;
  final publicKey = blockChainData.publicKey;
  final privateKey = blockChainData.privateKey;

  final blockchainResponse = await service.addKey(
    fromAddress: fromAddress,
    mnemonic: mnemonic,
    derivationPathOfNewGeneratedAccount: tempDerivationPath,
    permission: "functionCall", // could be also fullAccess
    allowance: NearFormatter.nearToYoctoNear("1"),
    smartContractId: "dev-1679756367837-29230485683009",
    methodNames: ["set_greeting", "get_greeting"],
    privateKey: privateKey,
    publicKey: publicKey,
  );

  final secretKey =
        await nearBlockChainService.exportPrivateKeyToTheNearApiJsFormat(
      currentBlockchainData: tempBlockChainData,
  ); // secret key of functionCall key in near api js format
```

Deleting key:

```dart
  final blockchainResponse = await service.deleteKey(
    publicKey: blockChainData.publicKey,
    accountId: blockChainData.accountId ?? blockChainData.publicKey,
    privateKey: blockChainData.privateKey,
    deletedPublicKey:
        "c1cb858d5b6177be0f4847d310eddbb302a06c76dd2f464138ec8761d9fe1c54",
  );
```