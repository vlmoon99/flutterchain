import * as concordium from "@concordium/web-sdk";

export async function createAccountWorker(credentialInput, expiry) {
    return concordium.createCredentialTransactionNoSeed(credentialInput, expiry);
}