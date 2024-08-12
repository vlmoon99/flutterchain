import * as concordium from "@concordium/web-sdk";

export async function recoverIdentityWorker(identityRequestInput) {
    return concordium.createIdentityRecoveryRequestWithKeys(identityRequestInput);
}