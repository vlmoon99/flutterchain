## FlutterChainLibrary

FlutterChainLibrary provides an interface that allows you to create wallets for different blockchains simultaneously, securely store them and manage, and execute standardized operations like transferring coins or interacting with smart contracts (where supported by the blockchain). It also provides access to the blockchain specific methods interface.

## How to use

- [Initialization](#initialization)
- [Wallet creation](#wallet-creation)
- [Deleting wallets](#deleting-wallets)
- [Changing network environment settings](#changing-network-environment-settings)
- [Transfer coins](#transfer-coins)
- [Smart contract call](#contributing)
- [Specific blockchain methods](#specific-blockchain-methods)


### Initialization

```dart
  final flutterChainLibrary = FlutterChainLibrary.defaultInstance();
  final flutterChainLibrary2 = FlutterChainLibrary(
    FlutterChainService(
      nearBlockchainService: NearBlockChainService.defaultInstance(),
    ),
    WalletRepository.defaultInstance(),
  );
```

`FlutterChainLibrary` includes a named constructor with predefined `FlutterChainService` and `Repository<Wallet>` components. The `FlutterChainService` is responsible for handling blockchain operations. It also provides a `defaultInstance` named constructor, which includes all supported blockchains by default, or you can use the standard constructor to specify the blockchains you wish to integrate.

`Repository<Wallet>` is an abstract class responsible for managing wallets, offering methods to save, read, update, and delete wallets. The provided implementation is `WalletRepository`, which uses `FlutterServiceStorage` under the hood. However, you are free to use your own implementation if needed.

### Wallet creation

```dart
  final wallet = await flutterChainLibrary.createWalletWithGeneratedMnemonic(
      walletName: "my wallet"); // create new wallet with a random mnemonic

  final wallet2 = await flutterChainLibrary.createWalletByImportedMnemonic(
    mnemonic: "your mnemonic here", walletName: "my wallet 2"); // create new wallet with imported mnemonic
```
The generated `Wallet` contains the wallet's ID, name, mnemonic, passphrase, and a map of `BlockChainData` for each blockchain. The `BlockChainData` includes general account information such as the public key, private key, derivation path, and blockchain-specific data, like the accountId for `Near`.

You can retrieve all your wallets using the following method:

```dart
  final List<Wallet>? wallets = flutterChainLibrary.walletsStream.valueOrNull;
```

To add a new account for this mnemonic on a blockchain, you can use the `addBlockChainDataByDerivationPath` method:

```dart
  final blockchainData =  flutterChainLibrary.addBlockChainDataByDerivationPath(
    derivationPath: const DerivationPath(
      purpose: "44'",
      coinType: "397'",
      accountNumber: "0'",
      change: "0'",
      address: "2'",
    ), // derivation path for new account
    blockchainType: BlockChains.near,
    walletID: wallet1.id,
  );

  // we also can get it from wallet
  final blockchainData2 = wallet1.blockchainsData![BlockChains.near]!.last;
```

### Deleting wallets

```dart
  await flutterChainLibrary.deleteWalletById(walletId: wallet1.id);
  // or
  await flutterChainLibrary.deleteAllWallets();
```

### Changing network environment settings

You can change network environment setting for particular Blockchain:

```dart
  final chainUrls = flutterChainLibrary.getBlockchainsUrlsByBlockchainType(
      BlockChains.near); // get endpoints for this blockchain

  await flutterChainLibrary.setBlockchainNetworkEnvironment(
    blockchainType: BlockChains.near,
    blockChainNetworkEnvironmentSettings: NearNetworkEnvironmentSettings(chainUrl: chainUrls.last),
  ); // set endpoint for this blockchain
```

### Get wallet balance

You can retrieve the wallet balance on a specific blockchain using the `getBalanceOfAddressOnSpecificBlockchain` method. This can be done either by using the derivation path and wallet id or directly by providing the address:

```dart
  final String balance =
      await flutterChainLibrary.getBalanceOfAddressOnSpecificBlockchain(
    blockchainType: BlockChains.near,
    walletId: wallet1.id,
    derivationPathData: const DerivationPath(
      purpose: "44'",
      coinType: "397'",
      accountNumber: "0'",
      change: "0'",
      address: "1'",
    ),
  );

  final String balance2 =
      await flutterChainLibrary.getBalanceOfAddressOnSpecificBlockchain(
    blockchainType: BlockChains.near,
    address: "test.near",
  );

```

### Transfer coins

To transfer coins, you select the wallet, blockchain, and the specific account using the derivation path

```dart
  final blockchainResponse = await flutterChainLibrary.sendTransferNativeCoin(
    blockchainType: BlockChains.near,
    walletId: wallet1.id,
    derivationPathData:
        wallet1.blockchainsData![BlockChains.near]!.first.derivationPath,
    toAddress: "test.near",
    transferAmount: NearFormatter.nearToYoctoNear("1"),
  );
```
`blockchainResponse` differs depending on blockchain. But it always has `status` and data["txHash"] if transaction was executed.


### Smart contract call

```dart
  final blockchainResponse = await flutterChainLibrary.callSmartContractFunction(
    blockchainType: BlockChains.near,
    derivationPathData:
        wallet1.blockchainsData![BlockChains.near]!.first.derivationPath,
    walletId: wallet1.id,
    toAddress: "smart-contract.near",
    rawSmartContractArguments: RawNearBlockChainSmartContractArguments(
      method: "some method",
      args: {},
      transferAmount: "0",
    ),
  );
```

### Specific blockchain methods

To use specific blockchain methods we should get blockchain service from `FlutterChainService`:

```dart
  final NearBlockChainService nearBlockChainService = flutterChainLibrary
      .blockchainService
      .blockchainServices[BlockChains.near] as NearBlockChainService;

  final balance = await nearBlockChainService
      .getWalletBalance(NearAccountInfoRequest(accountId: "accountId.test"));
```