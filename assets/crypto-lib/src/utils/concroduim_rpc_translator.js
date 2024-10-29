import * as concordium from '@concordium/web-sdk';
import bs58check from 'bs58check';

export function accountInfo(acc) {
    const aggAmount = acc.encryptedBalance?.aggregatedAmount?.value;
    const numAggregated = acc.encryptedBalance?.numAggregated;
    const encryptedAmount = {
        selfAmount: unwrapValToHex(acc.encryptedBalance?.selfAmount),
        startIndex: acc.encryptedBalance?.startIndex != undefined ? concordium.unwrap(acc.encryptedBalance?.startIndex) : BigInt(0),
        incomingAmounts: concordium.unwrap(acc.encryptedBalance?.incomingAmounts ?? []).map(unwrapValToHex),
        // Set the following values if they are not undefined
        ...(numAggregated && { numAggregated: numAggregated }),
        ...(aggAmount && { aggregatedAmount: unwrapToHex(aggAmount) }),
    };
    const releaseSchedule = {
        total: concordium.CcdAmount.fromProto(concordium.unwrap( {value: acc.schedule?.total.value ?? BigInt(0)} )),
        schedule: concordium.unwrap(acc.schedule?.schedules ?? []).map(trRelease),
    };
    const accInfoCommon = {
        type: concordium.AccountInfoType.Simple,
        accountAddress: concordium.AccountAddress.fromBuffer(Uint8Array.from(acc.address.value)),
        accountNonce: concordium.SequenceNumber.fromProto(concordium.unwrap(acc.sequenceNumber)),
        accountAmount: concordium.CcdAmount.fromMicroCcd(acc.amount.value ?? BigInt(0)),
        accountIndex: BigInt(concordium.unwrap(acc.index?.value)),
        accountThreshold: concordium.unwrap(acc.threshold?.value),
        accountEncryptionKey: unwrapValToHex(acc.encryptionKey),
        accountEncryptedAmount: encryptedAmount,
        accountReleaseSchedule: releaseSchedule,
        accountCredentials: mapRecord(acc.creds, trCred),
    };
    if (acc.stake?.delegator !== undefined) {
        return {
            ...accInfoCommon,
            type: concordium.AccountInfoType.Delegator,
            accountDelegation: trDelegator(acc.stake.delegator),
        };
    }
    else if (acc.stake?.baker !== undefined) {
        return {
            ...accInfoCommon,
            type: concordium.AccountInfoType.Baker,
            accountBaker: trBaker(acc.stake.baker),
        };
    }
    else {
        return accInfoCommon;
    }
}

export function cryptographicParameters(cp) {
    return {
        onChainCommitmentKey: unwrapToHex(cp.onChainCommitmentKey),
        bulletproofGenerators: unwrapToHex(cp.bulletproofGenerators),
        genesisString: cp.genesisString,
    };
}

export function accountTransactionSignatureToV2(signature) {
    function trSig(a) {
        return { value: Array.from(Buffer.from(a, 'hex')) };
    }
    function trCredSig(a) {
        return { signatures: mapRecord(a, trSig) };
    }
    return { signatures: mapRecord(signature, trCredSig) };
}

function unwrapToHex(bytes) {
    return Buffer.from(concordium.unwrap(bytes)).toString('hex');
}
function unwrapValToHex(x) {
    return unwrapToHex(concordium.unwrap(x).value);
}
function unwrapToBase58(address) {
    return bs58check.encode(Buffer.concat([Buffer.of(1), concordium.unwrap(address?.value)]));
}

function trDelegator(deleg) {
    return {
        restakeEarnings: deleg.restakeEarnings,
        stakedAmount: concordium.CcdAmount.fromMicroCcd(deleg.stakedAmount.value),
        delegationTarget: trDelegatorTarget(deleg.target),
        // Set the following value if deleg.pendingChange is set to true
        ...(deleg.pendingChange && {
            pendingChange: trPendingChange(deleg.pendingChange),
        }),
    };
}

function trDelegatorTarget(target) {
    if (target.passive !== undefined) {
        return {
            delegateType: concordium.DelegationTargetType.PassiveDelegation,
        };
    }
    else if (target.baker !== undefined) {
        return {
            delegateType: concordium.DelegationTargetType.Baker,
            bakerId: target.baker.value,
        };
    }
    else {
        throw Error('DelegatorTarget expected to be of type "passive" or "baker", but found ' + target.target.oneofKind);
    }
}

function trPendingChange(pendingChange) {
    const change = pendingChange;
    if (change.reduce !== undefined) {
        return {
            newStake: change.reduce.newStake?.value,
            effectiveTime: trTimestamp(change.reduce.effectiveTime),
            change: concordium.StakePendingChangeType.ReduceStake,
        };
    }
    else if (change.remove !== undefined) {
        return {
            effectiveTime: trTimestamp(change.remove),
            change: concordium.StakePendingChangeType.RemoveStake,
        };
    }
    else {
        throw Error('PendingChange expected to be of type "reduce" or "remove", but found ' + change.oneofKind);
    }
}

function trTimestamp(timestamp) {
    return new Date(Number(concordium.unwrap(timestamp?.value)));
}

function trBaker(baker) {
    const bakerInfo = baker.bakerInfo;
    const v0 = {
        version: 0,
        restakeEarnings: baker.restakeEarnings,
        bakerId: bakerInfo.bakerId.value,
        bakerAggregationVerifyKey: unwrapToHex(bakerInfo?.aggregationKey.value),
        bakerElectionVerifyKey: unwrapToHex(bakerInfo?.electionKey.value),
        bakerSignatureVerifyKey: unwrapToHex(bakerInfo?.signatureKey.value),
        stakedAmount: concordium.CcdAmount.fromMicroCcd(baker.stakedAmount.value),
        // // Set the following value if baker.pendingChange is set to true
        ...(baker.pendingChange && {
            pendingChange: trPendingChange(baker.pendingChange),
        }),
    };
    if (baker.poolInfo === undefined) {
        return v0;
    }
    const bakerPoolInfo = {
        openStatus: trOpenStatus(baker.poolInfo?.openStatus),
        metadataUrl: baker.poolInfo.url,
        commissionRates: trCommissionRates(baker.poolInfo?.commissionRates),
    };
    return {
        ...v0,
        version: 1,
        bakerPoolInfo: bakerPoolInfo,
    };
}

function trOpenStatus(openStatus) {
    switch (openStatus) {
        case concordium.OpenStatus.OPEN_FOR_ALL:
            return concordium.OpenStatusText.OpenForAll;
        case concordium.OpenStatus.CLOSED_FOR_NEW:
            return concordium.OpenStatusText.ClosedForNew;
        case concordium.OpenStatus.CLOSED_FOR_ALL:
            return concordium.OpenStatusText.ClosedForAll;
        default: 
            return "unknown";
    }
}

function trCommissionRates(rates) {
    return {
        transactionCommission: trAmountFraction(rates?.transaction),
        bakingCommission: trAmountFraction(rates?.baking),
        finalizationCommission: trAmountFraction(rates?.finalization),
    };
}

function trAmountFraction(amount) {
    return amount.partsPerHundredThousand / 100000;
}

function trRelease(release) {
    return {
        timestamp: trTimestamp(release.timestamp),
        amount: concordium.CcdAmount.fromProto(concordium.unwrap(release.amount)),
        transactions: release.transactions.map(unwrapValToHex),
    };
}

function trCred(cred) {
    const isNormal = cred["normal"] !== undefined;
    const credVals = isNormal ? cred.normal : cred.initial;
    const policy = {
        validTo: trDate(concordium.unwrap(credVals.policy?.validTo)),
        createdAt: trDate(concordium.unwrap(credVals.policy?.createdAt)),
        revealedAttributes: mapRecord(credVals.policy?.attributes, unwrapToHex, trAttKey),
    };
    const commonValues = {
        ipIdentity: concordium.unwrap(credVals.ipId?.value ?? 0),
        credentialPublicKeys: trCredKeys(concordium.unwrap(credVals.keys)),
        policy: policy,
    };
    let value;
    if (isNormal) {
        const deploymentValues = {
            ...commonValues,
            credId: unwrapValToHex(credVals.credId),
            revocationThreshold: concordium.unwrap(credVals.arThreshold?.value),
            arData: mapRecord(credVals.arData, trChainArData, String),
            commitments: trCommits(concordium.unwrap(credVals.commitments)),
        };
        value = {
            type: 'normal',
            contents: deploymentValues,
        };
    }
    else {
        const deploymentValues = {
            ...commonValues,
            regId: unwrapValToHex(credVals.credId),
        };
        value = {
            type: 'initial',
            contents: deploymentValues,
        };
    }
    return {
        v: 0,
        value,
    };
}

function trDate(ym) {
    return String(ym.year) + String(ym.month).padStart(2, '0');
}

function trCredKeys(credKeys) {
    return {
        threshold: concordium.unwrap(credKeys.threshold?.value),
        keys: mapRecord(credKeys.keys, trVerifyKey),
    };
}

export function mapRecord(rec, valMapper, keyMapper = (a) => a) {
    const ret = {};
    for (const i in rec) {
        ret[keyMapper(i)] = valMapper(rec[i]);
    }
    return ret;
}

function trAttKey(attributeKey) {
    return concordium.AttributesKeys[attributeKey];
}

function trVerifyKey(verifyKey) {
    return {
        schemeId: 'Ed25519',
        verifyKey: unwrapToHex(verifyKey.ed25519Key),
    };
}

function trChainArData(chainArData) {
    return {
        encIdCredPubShare: unwrapToHex(chainArData.encIdCredPubShare),
    };
}

function trCommits(cmm) {
    return {
        cmmPrf: unwrapValToHex(cmm.prf),
        cmmCredCounter: unwrapValToHex(cmm.credCounter),
        cmmIdCredSecSharingCoeff: cmm.idCredSecSharingCoeff.map(unwrapValToHex),
        cmmAttributes: mapRecord(cmm.attributes, unwrapValToHex, trAttKey),
        cmmMaxAccounts: unwrapValToHex(cmm.maxAccounts),
    };
}

export function filterRecord(rec, predicate) {
    return Object.fromEntries(Object.entries(rec).filter(([k, v]) => predicate(k, v)));
}