import * as concordium from "@concordium/web-sdk";

export async function createIdentityWorker(identityRequestInput) {
    return concordium.createIdentityRequestWithKeys(identityRequestInput);
}