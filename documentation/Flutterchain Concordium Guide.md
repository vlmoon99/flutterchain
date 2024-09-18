# Flutterchain Concordium Guide

### Registering on Concordium and account creation:

First of all, you need initialization of Concordium blockchain service.

```
final ConcordiumBlockchainService concordiumBlockchainService =
        ConcordiumBlockchainService.defaultInstance();
```

Default instance configured to work with testnet. You can change it by calling default constructor or use method `setBlockchainNetworkEnvironment`.

```dart
  final ConcordiumBlockchainService concordiumBlockchainService =
      ConcordiumBlockchainService.defaultInstance()
        ..setBlockchainNetworkEnvironment(
          ConcordiumNetworkEnvironmentSettings(
            baseUrl: ConcordiumBlockchainNetworkUrls.listOfUrls.last,
            port: 20000,
            typeOfNetwork: ConcordiumNetwork.mainnet
          ),
        );
```

Now we can create an account. Steps:

#### Creating identity:

To create identity we need to generate mnemonic and choose identityProvider. After that we generaing CreateIdentityRequestParams which used for forming request to create identity.

```dart
final identityProviders = await concordiumBlockchainService.getIdentityProviders();

final identityProvider = identityProviders.first; // for example we take first

final int identityProviderIndex = identityProvider.ipInfo["ipIdentity"]; // thats how to get identityProviderIndex

final mnemonic = await concordiumBlockchainService.generateMnemonic(strength: 128);

final createIdentityRequestParams = await concordiumBlockchainService.getCreateIdentityRequestParams(mnemonic: mnemonic, identityProvider: identityProvider, identityIndex: 0);

final creationUrl = await concordiumBlockchainService.getIdentityCreateRequestUrl(identityProvider: identityProviders.first,createIdentityRequestParams: createIdentityRequestParams);

```

`getIdentityCreateRequestUrl` also has parameter `redirectUrlToReturnForWeb` which is used for web platforms only to redirect user from registration page. Here you have to implement additional logic for this page to extract url after redirection to get identity info from it.

For another platforms you can use `createIdentityDialog` to open registration page. And after registration you can get identity url info from it.

```dart
final urlForIdentityInfo = await concordiumBlockchainService.createIdentityDialog(context: context,creationUrl: creationUrl);
```

#### Creating account:

```dart
const int identityProviderIndex = 0; // how to get it you can found above
const int identityIndex = 0; // index of identity
const int credsNumber = 0; // account number

final identityProvider = (await concordiumBlockchainService.getIdentityProviders()).firstWhere(
  (element) {
    return element.ipInfo["ipIdentity"] ==
        identityProviderIndex;
  },
);

final identityInfo = await concordiumBlockchainService.getIdentityInfo(urlToGetIdentityInfo);

final res = await concordiumBlockchainService.createAccount(
  mnemonic: mnemonic,
  identityInfo: identityInfo,
  identityProviderInfo: identityProvider,
  derivationPath: ConcordiumDerivationPath(
    identityProviderIndex: identityProviderIndex,
    identityIndex: identityIndex,
    credentialIndex: credsNumber,
  ),
);
```

To retrieve identity info we can use `getIdentityInfo` method. Also there is other method `recoverExistingIdentity` to get rid of storing url to identity info and helps for creating new accounts.

Method `createAccount` creates account and returns `BlockchainResponse` with the transaction hash data["txHash"] and account address data["accountAddress"].

To retrieve identity info from method `recoverExistingIdentity`:

```dart
final identityInfo = await concordiumBlockchainService.recoverExistingIdentity(mnemonic: mnemonic, identityProvider: identityProvider,identityIndex: identityIndex);
```

### Helpful methods:

We can get Account Information from `getAccountInfo` method:

```dart
final accountInfo = await concordiumBlockchainService.getAccountInfo(ConcordiumAccountInfoRequest(accountAddress: "3ZbX3pvwGeb4Wxx6tV9swEphAaSLXJPqQPQV7sa7nHDZ3aqiNe"));
```

It contains all information which can be obtain from chain. For more info consider `ConcordiumAccountInfo` class.
Or to get only wallet balance with `getWalletBalance` method.

We can get transaction information from `getTransactionInfo` method:

```dart
final res = await concordiumBlockchainService.getTransactionStatus(transactionHash:
"5d8ed983caa2c168a6be67...");
```

It returns `BlockchainResponse` with current transaction status and outcome information.

There are also methods to get account adress, public key and private key:

```dart
final accAdress = await concordiumBlockchainService
    .getAccountAddressFromMnemonic(
  mnemonic: mnemonic,
  derivationPath: ConcordiumDerivationPath(
    identityProviderIndex: 0,
    identityIndex: 0,
    credentialIndex: 0,
  ),
);

final publicKey =
    await concordiumBlockchainService.getAccountPublicKey(
        mnemonic: mnemonic,
        derivationPath: ConcordiumDerivationPath(
          identityProviderIndex: 0,
));

final privateKey =
    await concordiumBlockchainService.getAccountPrivateKey(
        mnemonic: mnemonic,
        derivationPath: ConcordiumDerivationPath(
          identityProviderIndex: 0,
));

final res = await concordiumBlockchainService
    .getBlockChainData(
  mnemonic: mnemonic,
  derivationPath: ConcordiumDerivationPath(
    identityProviderIndex: 0,
  ),
);
```

Method `getBlockChainData` returns `ConcordiumBlockchainData` instance which contains mnemonic, derivation path, account address, public key and private key.

### Transactions:

#### Coin transfer:

To send coin transfer transaction we can use `sendTransferNativeCoin` method:

```dart
const senderAddress = "3LuHCzrXjxAnPaiRqQAyk7MeEd4...";
const toAddress = "4ZZ5wvTLoiokBv3huUomRmEpvAT...";
const transferAmountInMicroCcd = 100000000;

final privateKey = await concordiumBlockchainService.getAccountPrivateKey(
 mnemonic: mnemonic,
derivationPath: ConcordiumDerivationPath(
  identityProviderIndex: 0,
  identityIndex: 0,
  credentialIndex: 0,
));

final res = await concordiumBlockchainService.sendTransferNativeCoin(
ConcordiumTransferRequest(senderAddress: senderAddress,
  toAddress: toAddress,
  transferAmountInMicroCcd: transferAmountInMicroCcd,
  privateKey: privateKey)
);
```

Returns `BlockchainResponse` with transaction hash data["txHash"].

We also can use methods from `ConcordiumFormatter` class to convert CCD to microCCD and vice versa:

```dart
final amountInCcd = ConcordiumFormatter.convertMicroCcdToCcd(14000000000);
final amountInMicroCcd = ConcordiumFormatter.convertCcdToMicroCcd(14000);
```

#### Delegation transaction:

```dart
const senderAddress = "3ZbX3pvwGeb4Wxx6tV9s...";
const amountInMicroCcd = 14000000000;

final privateKey = await concordiumBlockchainService.getAccountPrivateKey(
 mnemonic: mnemonic,
derivationPath: ConcordiumDerivationPath(
  identityProviderIndex: 0,
  identityIndex: 0,
  credentialIndex: 0,
));
final res = await concordiumBlockchainService
    .sendDelegationTransaction(
  senderAddress: senderAddress,
  amountInMicroCcd: amountInMicroCcd,
  privateKey: privateKey,
  // delegationType: ConcordiumDelegationType.baker,
  // bakerId: '12369',
  restakeEarnings: true,
  delegationType: ConcordiumDelegationType.passive,
);
```

Method `sendDelegationTransaction` gives oportunity to init delegation transaction and configure it with optional parameters. For initialization all optional parameters must be set. Method returns `BlockchainResponse` with transaction hash data["txHash"].
For more info check in `ConcordiumBlockchainService` class.

#### Baker transaction:

```dart
const senderAddress = "3ZbX3pvwGeb4Wxx6tV9s...";
const amountInMicroCcd = 14000000000;

final privateKey = await concordiumBlockchainService.getAccountPrivateKey(
 mnemonic: mnemonic,
derivationPath: ConcordiumDerivationPath(
  identityProviderIndex: 0,
  identityIndex: 0,
  credentialIndex: 0,
));

final res =
    await concordiumBlockchainService.sendBakerTransaction(
  senderAddress: senderAddress,
  privateKey: privateKey,
  restakeEarnings: true,
  metadataUrl: "www.url.for.metadata",
  openStatus: DelegationOpenStatus.OpenForAll,
  transactionFeeCommissionInPercentage: 10,
  bakingRewardCommissionInPercentage: 10,
  finalizationRewardCommissionInPercentage: 100,
  stakeAmountInMicroCcd: amountInMicroCcd,
);
```

Method `sendBakerTransaction` gives oportunity to init baker transaction and configure it with optional parameters. For initialization all optional parameters(except `bakerKeys`) must be set. Method returns `BlockchainResponse` with transaction hash data["txHash"] and baker keys data["bakerKeys"].
For more info check in `ConcordiumBlockchainService` class.
