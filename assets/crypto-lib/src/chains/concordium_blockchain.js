import { generateMnemonic } from "@scure/bip39";
import { wordlist } from "@scure/bip39/wordlists/english";
import * as concordium from "@concordium/web-sdk";
import * as translator from "../utils/concroduim_rpc_translator";
import { createIdentityWorker } from "../core/workers/concordiumCreateIdentity.service";
import { createAccountWorker } from "../core/workers/concordiumCreateAccount.service";
import { recoverIdentityWorker } from "../core/workers/concrodiumRecoverIdentity.service";

export class ConcordiumBlockchain {
  generateMnemonic(strength = 128) {
    strength = parseInt(strength);
    return generateMnemonic(wordlist, strength);
  }

  async createIdentityRequestParams(
    mnemonic,
    network,
    selectedIdentityProvider,
    cryptographicParameters,
    identityIndex = 0
  ) {
    selectedIdentityProvider = JSON.parse(selectedIdentityProvider);
    cryptographicParameters = JSON.parse(cryptographicParameters);
    identityIndex = parseInt(identityIndex);

    const wallet = concordium.ConcordiumHdWallet.fromSeedPhrase(
      mnemonic,
      network
    );
    const identityProviderIndex = selectedIdentityProvider.ipInfo.ipIdentity;
    const idCredSec = wallet
      .getIdCredSec(identityProviderIndex, identityIndex)
      .toString("hex");
    const prfKey = wallet
      .getPrfKey(identityProviderIndex, identityIndex)
      .toString("hex");
    const blindingRandomness = wallet
      .getSignatureBlindingRandomness(identityProviderIndex, identityIndex)
      .toString("hex");

    const identityRequestInput = {
      arsInfos: selectedIdentityProvider.arsInfos,
      arThreshold: this.determineAnonymityRevokerThreshold(
        Object.keys(selectedIdentityProvider.arsInfos).length
      ),
      ipInfo: selectedIdentityProvider.ipInfo,
      globalContext: cryptographicParameters,
      idCredSec,
      prfKey,
      blindingRandomness,
    };

    const identityRequest = await createIdentityWorker(identityRequestInput);
    return JSON.stringify(identityRequest);
  }

  async createIdentityRecoveryParams(
    seedPhrase,
    network,
    selectedIdentityProvider,
    identityIndex = 0,
    cryptographicParameters
  ) {
    identityIndex = parseInt(identityIndex);
    selectedIdentityProvider = JSON.parse(selectedIdentityProvider);
    cryptographicParameters = JSON.parse(cryptographicParameters);

    const ipIdentity = selectedIdentityProvider.ipInfo.ipIdentity;

    const wallet = concordium.ConcordiumHdWallet.fromSeedPhrase(
      seedPhrase,
      network
    );
    const idCredSec = wallet
      .getIdCredSec(ipIdentity, identityIndex)
      .toString("hex");
    const identityRequestInput = {
      idCredSec,
      ipInfo: selectedIdentityProvider.ipInfo,
      globalContext: cryptographicParameters,
      timestamp: Math.floor(Date.now() / 1000),
    };

    const identityRecoveryRequestWithKeysInput = await recoverIdentityWorker(
      identityRequestInput
    );

    const params = {
      baseUrl: selectedIdentityProvider.metadata.recoveryStart,
      searchParams: {
        state: JSON.stringify({
          idRecoveryRequest: identityRecoveryRequestWithKeysInput,
        }),
      },
    };

    return JSON.stringify(params);
  }

  async createCredentialDeploymentTransaction(
    seedPhrase,
    network,
    identityIndex,
    credNumber,
    identity,
    selectedIdentityProvider,
    global
  ) {
    identityIndex = parseInt(identityIndex);
    credNumber = parseInt(credNumber);
    identity = JSON.parse(identity);
    selectedIdentityProvider = JSON.parse(selectedIdentityProvider);
    global = JSON.parse(global);

    const {
      idCredSec,
      prfKey,
      attributeRandomness,
      blindingRandomness,
      credentialPublicKeys,
    } = this.createCredentialDeploymentKeysAndRandomness(
      seedPhrase,
      network,
      selectedIdentityProvider.ipInfo.ipIdentity,
      identityIndex,
      credNumber
    );

    const credentialInput = {
      revealedAttributes: [],
      idObject: identity,
      globalContext: global,
      credNumber,
      ipInfo: selectedIdentityProvider.ipInfo,
      arsInfos: selectedIdentityProvider.arsInfos,
      attributeRandomness,
      credentialPublicKeys,
      idCredSec,
      prfKey,
      sigRetrievelRandomness: blindingRandomness,
    };

    const expiry = this.getDefaultTransactionExpiry();

    const credentialDeploymentTransaction = await createAccountWorker(
      credentialInput,
      expiry
    );

    const signingKey = this.getAccountSigningKey(
      seedPhrase,
      network,
      credentialDeploymentTransaction.unsignedCdi.ipIdentity,
      identityIndex,
      credNumber
    );

    const signature = await concordium.signCredentialTransaction(
      credentialDeploymentTransaction,
      signingKey
    );

    const payload = concordium.serializeCredentialDeploymentPayload(
      [signature],
      credentialDeploymentTransaction
    );
    const accountAddress = this.getAccountAddressInBase58FromCredentialId(
      credentialDeploymentTransaction.unsignedCdi.credId
    );

    const res = {
      payload: Array.from(payload),
      expiry: credentialDeploymentTransaction.expiry,
      accountAddress,
    };

    return JSON.stringify(res, (key, value) =>
      typeof value === "bigint" ? parseInt(value) : value
    );
  }

  async createTransferTransactionParams(
    senderAddress,
    toAddress,
    amount,
    signingKey,
    nonce
  ) {
    senderAddress = concordium.AccountAddress.fromBase58(senderAddress);
    toAddress = concordium.AccountAddress.fromBase58(toAddress);
    amount = concordium.CcdAmount.fromMicroCcd(BigInt(amount));
    nonce = concordium.SequenceNumber.create(parseInt(nonce));

    const payload = {
      amount,
      toAddress,
    };

    const header = {
      expiry: this.getDefaultTransactionExpiry(),
      nonce,
      sender: senderAddress,
    };

    const transaction = {
      type: concordium.AccountTransactionType.Transfer,
      payload,
      header,
    };

    const signature = await concordium.signTransaction(
      transaction,
      concordium.buildBasicAccountSigner(signingKey)
    );

    const accountTransactionHandler = concordium.getAccountTransactionHandler(
      transaction.type
    );
    const rawPayload =
      concordium.serializeAccountTransactionPayload(transaction);
    const baseEnergyCost = accountTransactionHandler.getBaseEnergyCost(
      transaction.payload
    );
    const energyCost = concordium.calculateEnergyCost(
      this.countSignatures(signature),
      BigInt(rawPayload.length),
      baseEnergyCost
    );

    const rawAccountTransaction = this.getRawAccountTransaction(
      transaction.header,
      energyCost,
      rawPayload,
      signature
    );

    return JSON.stringify(rawAccountTransaction, (key, value) =>
      typeof value === "bigint" ? parseInt(value) : value
    );
  }

  async createDelegationTransactionParams(
    senderAddress,
    amount,
    signingKey,
    nonce,
    restakeEarnings,
    delegationTarget
  ) {
    senderAddress = concordium.AccountAddress.fromBase58(senderAddress);
    amount = JSON.parse(amount);
    restakeEarnings = JSON.parse(restakeEarnings);
    nonce = concordium.SequenceNumber.create(parseInt(nonce));
    delegationTarget = JSON.parse(delegationTarget);

    const header = {
      expiry: this.getDefaultTransactionExpiry(),
      nonce,
      sender: senderAddress,
    };

    const payload = {};

    if (amount !== null) {
      amount = concordium.CcdAmount.fromMicroCcd(BigInt(amount));
      payload.stake = amount;
    }

    if (restakeEarnings !== null) {
      payload.restakeEarnings = restakeEarnings;
    }

    if (Object.keys(delegationTarget).length !== 0) {
      payload.delegationTarget = delegationTarget;
    }

    const transaction = {
      header: header,
      payload: payload,
      type: concordium.AccountTransactionType.ConfigureDelegation,
    };

    const signature = await concordium.signTransaction(
      transaction,
      concordium.buildBasicAccountSigner(signingKey)
    );

    const accountTransactionHandler = concordium.getAccountTransactionHandler(
      transaction.type
    );
    const rawPayload =
      concordium.serializeAccountTransactionPayload(transaction);

    const baseEnergyCost = accountTransactionHandler.getBaseEnergyCost(
      transaction.payload
    );

    const energyCost = concordium.calculateEnergyCost(
      this.countSignatures(signature),
      BigInt(rawPayload.length),
      baseEnergyCost
    );

    const rawAccountTransaction = this.getRawAccountTransaction(
      transaction.header,
      energyCost,
      rawPayload,
      signature
    );

    return JSON.stringify(rawAccountTransaction, (key, value) =>
      typeof value === "bigint" ? parseInt(value) : value
    );
  }

  async createBakerTransactionParams(
    senderAddress,
    signingKey,
    nonce,
    amount,
    restakeEarnings,
    bakerSettigs,
    bakerKeys
  ) {
    senderAddress = concordium.AccountAddress.fromBase58(senderAddress);
    nonce = concordium.SequenceNumber.create(parseInt(nonce));
    amount = JSON.parse(amount);
    restakeEarnings = JSON.parse(restakeEarnings);
    bakerSettigs = JSON.parse(bakerSettigs);
    bakerKeys = JSON.parse(bakerKeys);

    const payload = {
      ...bakerSettigs,
    };

    if (amount !== null) {
      amount = concordium.CcdAmount.fromMicroCcd(BigInt(amount));
      payload.stake = amount;
    }

    if (Object.keys(bakerKeys).length === 0) {
      bakerKeys = concordium.generateBakerKeys(senderAddress);
      payload.keys = bakerKeys;
    }

    if (restakeEarnings !== null) {
      payload.restakeEarnings = restakeEarnings;
    }

    const header = {
      expiry: this.getDefaultTransactionExpiry(),
      nonce,
      sender: senderAddress,
    };

    const transaction = {
      type: concordium.AccountTransactionType.ConfigureBaker,
      payload,
      header,
    };

    const signature = await concordium.signTransaction(
      transaction,
      concordium.buildBasicAccountSigner(signingKey)
    );

    const accountTransactionHandler = concordium.getAccountTransactionHandler(
      transaction.type
    );
    const rawPayload =
      concordium.serializeAccountTransactionPayload(transaction);
    const baseEnergyCost = accountTransactionHandler.getBaseEnergyCost(
      transaction.payload
    );
    const energyCost = concordium.calculateEnergyCost(
      this.countSignatures(signature),
      BigInt(rawPayload.length),
      baseEnergyCost
    );

    const rawAccountTransaction = this.getRawAccountTransaction(
      transaction.header,
      energyCost,
      rawPayload,
      signature
    );

    return JSON.stringify(
      { ...rawAccountTransaction, bakerKeys: bakerKeys },
      (key, value) => (typeof value === "bigint" ? parseInt(value) : value)
    );
  }

  getRawAccountTransaction(header, energyAmount, payload, signature) {
    const transactionSignature =
      translator.accountTransactionSignatureToV2(signature);
    if (concordium.TransactionExpiry.toDate(header.expiry) < new Date()) {
      throw new Error(
        "A transaction expiry is not allowed to be in the past: " +
          TransactionExpiry.toDate(header.expiry)
      );
    }

    const convertedHeader = {
      sender: {
        value: Array.from(header.sender.decodedAddress),
      },
      sequenceNumber: concordium.SequenceNumber.toProto(header.nonce),
      energyAmount: concordium.Energy.toProto(energyAmount),
      expiry: concordium.TransactionExpiry.toProto(header.expiry),
    };
    const accountTransaction = {
      signature: transactionSignature,
      header: convertedHeader,
      payload: { rawPayload: Array.from(payload) },
    };
    return accountTransaction;
  }

  getAccountSigningKey(
    seedPhrase,
    network,
    identityProviderIndex,
    identityIndex,
    credNumber
  ) {
    identityProviderIndex = parseInt(identityProviderIndex);
    identityIndex = parseInt(identityIndex);
    credNumber = parseInt(credNumber);
    const wallet = concordium.ConcordiumHdWallet.fromSeedPhrase(
      seedPhrase,
      network
    );
    return wallet
      .getAccountSigningKey(identityProviderIndex, identityIndex, credNumber)
      .toString("hex");
  }

  getAccountPublicKey(
    seedPhrase,
    network,
    identityProviderIndex,
    identityIndex,
    credNumber
  ) {
    identityProviderIndex = parseInt(identityProviderIndex);
    identityIndex = parseInt(identityIndex);
    credNumber = parseInt(credNumber);
    const wallet = concordium.ConcordiumHdWallet.fromSeedPhrase(
      seedPhrase,
      network
    );
    return wallet
      .getAccountPublicKey(identityProviderIndex, identityIndex, credNumber)
      .toString("hex");
  }

  getAccountAddressFromMnemonic(
    seedPhrase,
    network,
    identityProviderIndex,
    identityIndex = 0,
    credNumber = 0,
    cryptographicParameters
  ) {
    identityProviderIndex = parseInt(identityProviderIndex);
    identityIndex = parseInt(identityIndex);
    credNumber = parseInt(credNumber);
    cryptographicParameters = JSON.parse(cryptographicParameters);

    const wallet = concordium.ConcordiumHdWallet.fromSeedPhrase(
      seedPhrase,
      network
    );
    const credentialId = wallet.getCredentialId(
      identityProviderIndex,
      identityIndex,
      credNumber,
      cryptographicParameters
    );
    return this.getAccountAddressInBase58FromCredentialId(credentialId);
  }

  getAccountAddressInBase58FromCredentialId(credId) {
    const account = concordium.getAccountAddress(credId);
    return account.address;
  }

  createCredentialDeploymentKeysAndRandomness(
    seedPhrase,
    net,
    identityProviderIndex,
    identityIndex,
    credNumber
  ) {
    const wallet = concordium.ConcordiumHdWallet.fromSeedPhrase(
      seedPhrase,
      net
    );
    const publicKey = wallet
      .getAccountPublicKey(identityProviderIndex, identityIndex, credNumber)
      .toString("hex");

    const verifyKey = {
      schemeId: "Ed25519",
      verifyKey: publicKey,
    };
    const credentialPublicKeys = {
      keys: { 0: verifyKey },
      threshold: 1,
    };

    const prfKey = wallet
      .getPrfKey(identityProviderIndex, identityIndex)
      .toString("hex");
    const idCredSec = wallet
      .getIdCredSec(identityProviderIndex, identityIndex)
      .toString("hex");
    const blindingRandomness = wallet
      .getSignatureBlindingRandomness(identityProviderIndex, identityIndex)
      .toString("hex");

    const attributeRandomness = translator.mapRecord(
      translator.filterRecord(concordium.AttributesKeys, (k) =>
        isNaN(Number(k))
      ),
      (x) =>
        wallet
          .getAttributeCommitmentRandomness(
            identityProviderIndex,
            identityIndex,
            credNumber,
            x
          )
          .toString("hex")
    );

    return {
      prfKey,
      idCredSec,
      blindingRandomness,
      attributeRandomness,
      credentialPublicKeys,
    };
  }

  accountInfoFromProtoFormat(accountInfo) {
    accountInfo = JSON.parse(accountInfo);
    const str = JSON.stringify(
      translator.accountInfo(accountInfo),
      (key, value) => (typeof value === "bigint" ? parseInt(value) : value) // return everything else unchanged
    );
    return str;
  }

  transactionHashFromProtoFormat(txHashRaw) {
    txHashRaw = JSON.parse(txHashRaw);
    const transactionHash = concordium.TransactionHash.fromBuffer(
      Buffer.from(txHashRaw)
    );
    return concordium.TransactionHash.toHexString(transactionHash);
  }

  cryptographicParametersFromProtoFormat(cp) {
    cp = JSON.parse(cp);
    const str = JSON.stringify(
      translator.cryptographicParameters(cp),
      (key, value) => (typeof value === "bigint" ? parseInt(value) : value) // return everything else unchanged
    );
    return str;
  }

  determineAnonymityRevokerThreshold(anonymityRevokerCount) {
    return Math.min(anonymityRevokerCount - 1, 255);
  }

  getDefaultTransactionExpiry() {
    const DEFAULT_TRANSACTION_EXPIRY = 360000;
    return concordium.TransactionExpiry.fromDate(
      new Date(Date.now() + DEFAULT_TRANSACTION_EXPIRY)
    );
  }

  countSignatures(accountSignatures) {
    let totalSignatureCount = 0n;
    const values = Object.values(accountSignatures);
    for (const credentialSignature of values) {
      const signatureCount = BigInt(Object.keys(credentialSignature).length);
      totalSignatureCount += signatureCount;
    }
    return totalSignatureCount;
  }
}
