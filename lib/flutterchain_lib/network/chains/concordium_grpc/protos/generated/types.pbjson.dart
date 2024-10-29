//
//  Generated code. Do not modify.
//  source: lib/flutterchain_lib/network/chains/concordium_grpc/protos/types.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use openStatusDescriptor instead')
const OpenStatus$json = {
  '1': 'OpenStatus',
  '2': [
    {'1': 'OPEN_STATUS_OPEN_FOR_ALL', '2': 0},
    {'1': 'OPEN_STATUS_CLOSED_FOR_NEW', '2': 1},
    {'1': 'OPEN_STATUS_CLOSED_FOR_ALL', '2': 2},
  ],
};

/// Descriptor for `OpenStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List openStatusDescriptor = $convert.base64Decode(
    'CgpPcGVuU3RhdHVzEhwKGE9QRU5fU1RBVFVTX09QRU5fRk9SX0FMTBAAEh4KGk9QRU5fU1RBVF'
    'VTX0NMT1NFRF9GT1JfTkVXEAESHgoaT1BFTl9TVEFUVVNfQ0xPU0VEX0ZPUl9BTEwQAg==');

@$core.Deprecated('Use contractVersionDescriptor instead')
const ContractVersion$json = {
  '1': 'ContractVersion',
  '2': [
    {'1': 'V0', '2': 0},
    {'1': 'V1', '2': 1},
  ],
};

/// Descriptor for `ContractVersion`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List contractVersionDescriptor = $convert.base64Decode(
    'Cg9Db250cmFjdFZlcnNpb24SBgoCVjAQABIGCgJWMRAB');

@$core.Deprecated('Use credentialTypeDescriptor instead')
const CredentialType$json = {
  '1': 'CredentialType',
  '2': [
    {'1': 'CREDENTIAL_TYPE_INITIAL', '2': 0},
    {'1': 'CREDENTIAL_TYPE_NORMAL', '2': 1},
  ],
};

/// Descriptor for `CredentialType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List credentialTypeDescriptor = $convert.base64Decode(
    'Cg5DcmVkZW50aWFsVHlwZRIbChdDUkVERU5USUFMX1RZUEVfSU5JVElBTBAAEhoKFkNSRURFTl'
    'RJQUxfVFlQRV9OT1JNQUwQAQ==');

@$core.Deprecated('Use updateTypeDescriptor instead')
const UpdateType$json = {
  '1': 'UpdateType',
  '2': [
    {'1': 'UPDATE_PROTOCOL', '2': 0},
    {'1': 'UPDATE_ELECTION_DIFFICULTY', '2': 1},
    {'1': 'UPDATE_EURO_PER_ENERGY', '2': 2},
    {'1': 'UPDATE_MICRO_CCD_PER_EURO', '2': 3},
    {'1': 'UPDATE_FOUNDATION_ACCOUNT', '2': 4},
    {'1': 'UPDATE_MINT_DISTRIBUTION', '2': 5},
    {'1': 'UPDATE_TRANSACTION_FEE_DISTRIBUTION', '2': 6},
    {'1': 'UPDATE_GAS_REWARDS', '2': 7},
    {'1': 'UPDATE_POOL_PARAMETERS', '2': 8},
    {'1': 'ADD_ANONYMITY_REVOKER', '2': 9},
    {'1': 'ADD_IDENTITY_PROVIDER', '2': 10},
    {'1': 'UPDATE_ROOT_KEYS', '2': 11},
    {'1': 'UPDATE_LEVEL1_KEYS', '2': 12},
    {'1': 'UPDATE_LEVEL2_KEYS', '2': 13},
    {'1': 'UPDATE_COOLDOWN_PARAMETERS', '2': 14},
    {'1': 'UPDATE_TIME_PARAMETERS', '2': 15},
    {'1': 'UPDATE_TIMEOUT_PARAMETERS', '2': 16},
    {'1': 'UPDATE_MIN_BLOCK_TIME', '2': 17},
    {'1': 'UPDATE_BLOCK_ENERGY_LIMIT', '2': 18},
    {'1': 'UPDATE_FINALIZATION_COMMITTEE_PARAMETERS', '2': 19},
  ],
};

/// Descriptor for `UpdateType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List updateTypeDescriptor = $convert.base64Decode(
    'CgpVcGRhdGVUeXBlEhMKD1VQREFURV9QUk9UT0NPTBAAEh4KGlVQREFURV9FTEVDVElPTl9ESU'
    'ZGSUNVTFRZEAESGgoWVVBEQVRFX0VVUk9fUEVSX0VORVJHWRACEh0KGVVQREFURV9NSUNST19D'
    'Q0RfUEVSX0VVUk8QAxIdChlVUERBVEVfRk9VTkRBVElPTl9BQ0NPVU5UEAQSHAoYVVBEQVRFX0'
    '1JTlRfRElTVFJJQlVUSU9OEAUSJwojVVBEQVRFX1RSQU5TQUNUSU9OX0ZFRV9ESVNUUklCVVRJ'
    'T04QBhIWChJVUERBVEVfR0FTX1JFV0FSRFMQBxIaChZVUERBVEVfUE9PTF9QQVJBTUVURVJTEA'
    'gSGQoVQUREX0FOT05ZTUlUWV9SRVZPS0VSEAkSGQoVQUREX0lERU5USVRZX1BST1ZJREVSEAoS'
    'FAoQVVBEQVRFX1JPT1RfS0VZUxALEhYKElVQREFURV9MRVZFTDFfS0VZUxAMEhYKElVQREFURV'
    '9MRVZFTDJfS0VZUxANEh4KGlVQREFURV9DT09MRE9XTl9QQVJBTUVURVJTEA4SGgoWVVBEQVRF'
    'X1RJTUVfUEFSQU1FVEVSUxAPEh0KGVVQREFURV9USU1FT1VUX1BBUkFNRVRFUlMQEBIZChVVUE'
    'RBVEVfTUlOX0JMT0NLX1RJTUUQERIdChlVUERBVEVfQkxPQ0tfRU5FUkdZX0xJTUlUEBISLAoo'
    'VVBEQVRFX0ZJTkFMSVpBVElPTl9DT01NSVRURUVfUEFSQU1FVEVSUxAT');

@$core.Deprecated('Use transactionTypeDescriptor instead')
const TransactionType$json = {
  '1': 'TransactionType',
  '2': [
    {'1': 'DEPLOY_MODULE', '2': 0},
    {'1': 'INIT_CONTRACT', '2': 1},
    {'1': 'UPDATE', '2': 2},
    {'1': 'TRANSFER', '2': 3},
    {'1': 'ADD_BAKER', '2': 4},
    {'1': 'REMOVE_BAKER', '2': 5},
    {'1': 'UPDATE_BAKER_STAKE', '2': 6},
    {'1': 'UPDATE_BAKER_RESTAKE_EARNINGS', '2': 7},
    {'1': 'UPDATE_BAKER_KEYS', '2': 8},
    {'1': 'UPDATE_CREDENTIAL_KEYS', '2': 9},
    {'1': 'ENCRYPTED_AMOUNT_TRANSFER', '2': 10},
    {'1': 'TRANSFER_TO_ENCRYPTED', '2': 11},
    {'1': 'TRANSFER_TO_PUBLIC', '2': 12},
    {'1': 'TRANSFER_WITH_SCHEDULE', '2': 13},
    {'1': 'UPDATE_CREDENTIALS', '2': 14},
    {'1': 'REGISTER_DATA', '2': 15},
    {'1': 'TRANSFER_WITH_MEMO', '2': 16},
    {'1': 'ENCRYPTED_AMOUNT_TRANSFER_WITH_MEMO', '2': 17},
    {'1': 'TRANSFER_WITH_SCHEDULE_AND_MEMO', '2': 18},
    {'1': 'CONFIGURE_BAKER', '2': 19},
    {'1': 'CONFIGURE_DELEGATION', '2': 20},
  ],
};

/// Descriptor for `TransactionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List transactionTypeDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvblR5cGUSEQoNREVQTE9ZX01PRFVMRRAAEhEKDUlOSVRfQ09OVFJBQ1QQAR'
    'IKCgZVUERBVEUQAhIMCghUUkFOU0ZFUhADEg0KCUFERF9CQUtFUhAEEhAKDFJFTU9WRV9CQUtF'
    'UhAFEhYKElVQREFURV9CQUtFUl9TVEFLRRAGEiEKHVVQREFURV9CQUtFUl9SRVNUQUtFX0VBUk'
    '5JTkdTEAcSFQoRVVBEQVRFX0JBS0VSX0tFWVMQCBIaChZVUERBVEVfQ1JFREVOVElBTF9LRVlT'
    'EAkSHQoZRU5DUllQVEVEX0FNT1VOVF9UUkFOU0ZFUhAKEhkKFVRSQU5TRkVSX1RPX0VOQ1JZUF'
    'RFRBALEhYKElRSQU5TRkVSX1RPX1BVQkxJQxAMEhoKFlRSQU5TRkVSX1dJVEhfU0NIRURVTEUQ'
    'DRIWChJVUERBVEVfQ1JFREVOVElBTFMQDhIRCg1SRUdJU1RFUl9EQVRBEA8SFgoSVFJBTlNGRV'
    'JfV0lUSF9NRU1PEBASJwojRU5DUllQVEVEX0FNT1VOVF9UUkFOU0ZFUl9XSVRIX01FTU8QERIj'
    'Ch9UUkFOU0ZFUl9XSVRIX1NDSEVEVUxFX0FORF9NRU1PEBISEwoPQ09ORklHVVJFX0JBS0VSEB'
    'MSGAoUQ09ORklHVVJFX0RFTEVHQVRJT04QFA==');

@$core.Deprecated('Use protocolVersionDescriptor instead')
const ProtocolVersion$json = {
  '1': 'ProtocolVersion',
  '2': [
    {'1': 'PROTOCOL_VERSION_1', '2': 0},
    {'1': 'PROTOCOL_VERSION_2', '2': 1},
    {'1': 'PROTOCOL_VERSION_3', '2': 2},
    {'1': 'PROTOCOL_VERSION_4', '2': 3},
    {'1': 'PROTOCOL_VERSION_5', '2': 4},
    {'1': 'PROTOCOL_VERSION_6', '2': 5},
    {'1': 'PROTOCOL_VERSION_7', '2': 6},
  ],
};

/// Descriptor for `ProtocolVersion`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List protocolVersionDescriptor = $convert.base64Decode(
    'Cg9Qcm90b2NvbFZlcnNpb24SFgoSUFJPVE9DT0xfVkVSU0lPTl8xEAASFgoSUFJPVE9DT0xfVk'
    'VSU0lPTl8yEAESFgoSUFJPVE9DT0xfVkVSU0lPTl8zEAISFgoSUFJPVE9DT0xfVkVSU0lPTl80'
    'EAMSFgoSUFJPVE9DT0xfVkVSU0lPTl81EAQSFgoSUFJPVE9DT0xfVkVSU0lPTl82EAUSFgoSUF'
    'JPVE9DT0xfVkVSU0lPTl83EAY=');

@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode(
    'CgVFbXB0eQ==');

@$core.Deprecated('Use blockHashDescriptor instead')
const BlockHash$json = {
  '1': 'BlockHash',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `BlockHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockHashDescriptor = $convert.base64Decode(
    'CglCbG9ja0hhc2gSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use sha256HashDescriptor instead')
const Sha256Hash$json = {
  '1': 'Sha256Hash',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Sha256Hash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sha256HashDescriptor = $convert.base64Decode(
    'CgpTaGEyNTZIYXNoEhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use transactionHashDescriptor instead')
const TransactionHash$json = {
  '1': 'TransactionHash',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `TransactionHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionHashDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvbkhhc2gSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use stateHashDescriptor instead')
const StateHash$json = {
  '1': 'StateHash',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `StateHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stateHashDescriptor = $convert.base64Decode(
    'CglTdGF0ZUhhc2gSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use absoluteBlockHeightDescriptor instead')
const AbsoluteBlockHeight$json = {
  '1': 'AbsoluteBlockHeight',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `AbsoluteBlockHeight`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List absoluteBlockHeightDescriptor = $convert.base64Decode(
    'ChNBYnNvbHV0ZUJsb2NrSGVpZ2h0EhQKBXZhbHVlGAEgASgEUgV2YWx1ZQ==');

@$core.Deprecated('Use blockHeightDescriptor instead')
const BlockHeight$json = {
  '1': 'BlockHeight',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `BlockHeight`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockHeightDescriptor = $convert.base64Decode(
    'CgtCbG9ja0hlaWdodBIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');

@$core.Deprecated('Use bakerIdDescriptor instead')
const BakerId$json = {
  '1': 'BakerId',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `BakerId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerIdDescriptor = $convert.base64Decode(
    'CgdCYWtlcklkEhQKBXZhbHVlGAEgASgEUgV2YWx1ZQ==');

@$core.Deprecated('Use accountIndexDescriptor instead')
const AccountIndex$json = {
  '1': 'AccountIndex',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `AccountIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountIndexDescriptor = $convert.base64Decode(
    'CgxBY2NvdW50SW5kZXgSFAoFdmFsdWUYASABKARSBXZhbHVl');

@$core.Deprecated('Use moduleRefDescriptor instead')
const ModuleRef$json = {
  '1': 'ModuleRef',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `ModuleRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moduleRefDescriptor = $convert.base64Decode(
    'CglNb2R1bGVSZWYSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use versionedModuleSourceDescriptor instead')
const VersionedModuleSource$json = {
  '1': 'VersionedModuleSource',
  '2': [
    {'1': 'v0', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.VersionedModuleSource.ModuleSourceV0', '9': 0, '10': 'v0'},
    {'1': 'v1', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.VersionedModuleSource.ModuleSourceV1', '9': 0, '10': 'v1'},
  ],
  '3': [VersionedModuleSource_ModuleSourceV0$json, VersionedModuleSource_ModuleSourceV1$json],
  '8': [
    {'1': 'module'},
  ],
};

@$core.Deprecated('Use versionedModuleSourceDescriptor instead')
const VersionedModuleSource_ModuleSourceV0$json = {
  '1': 'ModuleSourceV0',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

@$core.Deprecated('Use versionedModuleSourceDescriptor instead')
const VersionedModuleSource_ModuleSourceV1$json = {
  '1': 'ModuleSourceV1',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `VersionedModuleSource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionedModuleSourceDescriptor = $convert.base64Decode(
    'ChVWZXJzaW9uZWRNb2R1bGVTb3VyY2USRQoCdjAYASABKAsyMy5jb25jb3JkaXVtLnYyLlZlcn'
    'Npb25lZE1vZHVsZVNvdXJjZS5Nb2R1bGVTb3VyY2VWMEgAUgJ2MBJFCgJ2MRgCIAEoCzIzLmNv'
    'bmNvcmRpdW0udjIuVmVyc2lvbmVkTW9kdWxlU291cmNlLk1vZHVsZVNvdXJjZVYxSABSAnYxGi'
    'YKDk1vZHVsZVNvdXJjZVYwEhQKBXZhbHVlGAEgASgMUgV2YWx1ZRomCg5Nb2R1bGVTb3VyY2VW'
    'MRIUCgV2YWx1ZRgBIAEoDFIFdmFsdWVCCAoGbW9kdWxl');

@$core.Deprecated('Use timestampDescriptor instead')
const Timestamp$json = {
  '1': 'Timestamp',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `Timestamp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timestampDescriptor = $convert.base64Decode(
    'CglUaW1lc3RhbXASFAoFdmFsdWUYASABKARSBXZhbHVl');

@$core.Deprecated('Use releaseDescriptor instead')
const Release$json = {
  '1': 'Release',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'timestamp'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'transactions', '3': 3, '4': 3, '5': 11, '6': '.concordium.v2.TransactionHash', '10': 'transactions'},
  ],
};

/// Descriptor for `Release`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List releaseDescriptor = $convert.base64Decode(
    'CgdSZWxlYXNlEjYKCXRpbWVzdGFtcBgBIAEoCzIYLmNvbmNvcmRpdW0udjIuVGltZXN0YW1wUg'
    'l0aW1lc3RhbXASLQoGYW1vdW50GAIgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSBmFtb3Vu'
    'dBJCCgx0cmFuc2FjdGlvbnMYAyADKAsyHi5jb25jb3JkaXVtLnYyLlRyYW5zYWN0aW9uSGFzaF'
    'IMdHJhbnNhY3Rpb25z');

@$core.Deprecated('Use newReleaseDescriptor instead')
const NewRelease$json = {
  '1': 'NewRelease',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'timestamp'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
  ],
};

/// Descriptor for `NewRelease`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newReleaseDescriptor = $convert.base64Decode(
    'CgpOZXdSZWxlYXNlEjYKCXRpbWVzdGFtcBgBIAEoCzIYLmNvbmNvcmRpdW0udjIuVGltZXN0YW'
    '1wUgl0aW1lc3RhbXASLQoGYW1vdW50GAIgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSBmFt'
    'b3VudA==');

@$core.Deprecated('Use releaseScheduleDescriptor instead')
const ReleaseSchedule$json = {
  '1': 'ReleaseSchedule',
  '2': [
    {'1': 'total', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'total'},
    {'1': 'schedules', '3': 2, '4': 3, '5': 11, '6': '.concordium.v2.Release', '10': 'schedules'},
  ],
};

/// Descriptor for `ReleaseSchedule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List releaseScheduleDescriptor = $convert.base64Decode(
    'Cg9SZWxlYXNlU2NoZWR1bGUSKwoFdG90YWwYASABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudF'
    'IFdG90YWwSNAoJc2NoZWR1bGVzGAIgAygLMhYuY29uY29yZGl1bS52Mi5SZWxlYXNlUglzY2hl'
    'ZHVsZXM=');

@$core.Deprecated('Use encryptedAmountDescriptor instead')
const EncryptedAmount$json = {
  '1': 'EncryptedAmount',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `EncryptedAmount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encryptedAmountDescriptor = $convert.base64Decode(
    'Cg9FbmNyeXB0ZWRBbW91bnQSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use encryptedBalanceDescriptor instead')
const EncryptedBalance$json = {
  '1': 'EncryptedBalance',
  '2': [
    {'1': 'self_amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmount', '10': 'selfAmount'},
    {'1': 'start_index', '3': 2, '4': 1, '5': 4, '10': 'startIndex'},
    {'1': 'aggregated_amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmount', '9': 0, '10': 'aggregatedAmount', '17': true},
    {'1': 'num_aggregated', '3': 4, '4': 1, '5': 13, '9': 1, '10': 'numAggregated', '17': true},
    {'1': 'incoming_amounts', '3': 5, '4': 3, '5': 11, '6': '.concordium.v2.EncryptedAmount', '10': 'incomingAmounts'},
  ],
  '8': [
    {'1': '_aggregated_amount'},
    {'1': '_num_aggregated'},
  ],
};

/// Descriptor for `EncryptedBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encryptedBalanceDescriptor = $convert.base64Decode(
    'ChBFbmNyeXB0ZWRCYWxhbmNlEj8KC3NlbGZfYW1vdW50GAEgASgLMh4uY29uY29yZGl1bS52Mi'
    '5FbmNyeXB0ZWRBbW91bnRSCnNlbGZBbW91bnQSHwoLc3RhcnRfaW5kZXgYAiABKARSCnN0YXJ0'
    'SW5kZXgSUAoRYWdncmVnYXRlZF9hbW91bnQYAyABKAsyHi5jb25jb3JkaXVtLnYyLkVuY3J5cH'
    'RlZEFtb3VudEgAUhBhZ2dyZWdhdGVkQW1vdW50iAEBEioKDm51bV9hZ2dyZWdhdGVkGAQgASgN'
    'SAFSDW51bUFnZ3JlZ2F0ZWSIAQESSQoQaW5jb21pbmdfYW1vdW50cxgFIAMoCzIeLmNvbmNvcm'
    'RpdW0udjIuRW5jcnlwdGVkQW1vdW50Ug9pbmNvbWluZ0Ftb3VudHNCFAoSX2FnZ3JlZ2F0ZWRf'
    'YW1vdW50QhEKD19udW1fYWdncmVnYXRlZA==');

@$core.Deprecated('Use delegationTargetDescriptor instead')
const DelegationTarget$json = {
  '1': 'DelegationTarget',
  '2': [
    {'1': 'passive', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'passive'},
    {'1': 'baker', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '9': 0, '10': 'baker'},
  ],
  '8': [
    {'1': 'target'},
  ],
};

/// Descriptor for `DelegationTarget`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delegationTargetDescriptor = $convert.base64Decode(
    'ChBEZWxlZ2F0aW9uVGFyZ2V0EjAKB3Bhc3NpdmUYASABKAsyFC5jb25jb3JkaXVtLnYyLkVtcH'
    'R5SABSB3Bhc3NpdmUSLgoFYmFrZXIYAiABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRIAFIF'
    'YmFrZXJCCAoGdGFyZ2V0');

@$core.Deprecated('Use bakerElectionVerifyKeyDescriptor instead')
const BakerElectionVerifyKey$json = {
  '1': 'BakerElectionVerifyKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `BakerElectionVerifyKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerElectionVerifyKeyDescriptor = $convert.base64Decode(
    'ChZCYWtlckVsZWN0aW9uVmVyaWZ5S2V5EhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use bakerSignatureVerifyKeyDescriptor instead')
const BakerSignatureVerifyKey$json = {
  '1': 'BakerSignatureVerifyKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `BakerSignatureVerifyKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerSignatureVerifyKeyDescriptor = $convert.base64Decode(
    'ChdCYWtlclNpZ25hdHVyZVZlcmlmeUtleRIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use bakerAggregationVerifyKeyDescriptor instead')
const BakerAggregationVerifyKey$json = {
  '1': 'BakerAggregationVerifyKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `BakerAggregationVerifyKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerAggregationVerifyKeyDescriptor = $convert.base64Decode(
    'ChlCYWtlckFnZ3JlZ2F0aW9uVmVyaWZ5S2V5EhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use bakerInfoDescriptor instead')
const BakerInfo$json = {
  '1': 'BakerInfo',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'election_key', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BakerElectionVerifyKey', '10': 'electionKey'},
    {'1': 'signature_key', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BakerSignatureVerifyKey', '10': 'signatureKey'},
    {'1': 'aggregation_key', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.BakerAggregationVerifyKey', '10': 'aggregationKey'},
  ],
};

/// Descriptor for `BakerInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerInfoDescriptor = $convert.base64Decode(
    'CglCYWtlckluZm8SMQoIYmFrZXJfaWQYASABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRSB2'
    'Jha2VySWQSSAoMZWxlY3Rpb25fa2V5GAIgASgLMiUuY29uY29yZGl1bS52Mi5CYWtlckVsZWN0'
    'aW9uVmVyaWZ5S2V5UgtlbGVjdGlvbktleRJLCg1zaWduYXR1cmVfa2V5GAMgASgLMiYuY29uY2'
    '9yZGl1bS52Mi5CYWtlclNpZ25hdHVyZVZlcmlmeUtleVIMc2lnbmF0dXJlS2V5ElEKD2FnZ3Jl'
    'Z2F0aW9uX2tleRgEIAEoCzIoLmNvbmNvcmRpdW0udjIuQmFrZXJBZ2dyZWdhdGlvblZlcmlmeU'
    'tleVIOYWdncmVnYXRpb25LZXk=');

@$core.Deprecated('Use stakePendingChangeDescriptor instead')
const StakePendingChange$json = {
  '1': 'StakePendingChange',
  '2': [
    {'1': 'reduce', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.StakePendingChange.Reduce', '9': 0, '10': 'reduce'},
    {'1': 'remove', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '9': 0, '10': 'remove'},
  ],
  '3': [StakePendingChange_Reduce$json],
  '8': [
    {'1': 'change'},
  ],
};

@$core.Deprecated('Use stakePendingChangeDescriptor instead')
const StakePendingChange_Reduce$json = {
  '1': 'Reduce',
  '2': [
    {'1': 'new_stake', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newStake'},
    {'1': 'effective_time', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'effectiveTime'},
  ],
};

/// Descriptor for `StakePendingChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stakePendingChangeDescriptor = $convert.base64Decode(
    'ChJTdGFrZVBlbmRpbmdDaGFuZ2USQgoGcmVkdWNlGAEgASgLMiguY29uY29yZGl1bS52Mi5TdG'
    'FrZVBlbmRpbmdDaGFuZ2UuUmVkdWNlSABSBnJlZHVjZRIyCgZyZW1vdmUYAiABKAsyGC5jb25j'
    'b3JkaXVtLnYyLlRpbWVzdGFtcEgAUgZyZW1vdmUafQoGUmVkdWNlEjIKCW5ld19zdGFrZRgBIA'
    'EoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UghuZXdTdGFrZRI/Cg5lZmZlY3RpdmVfdGltZRgC'
    'IAEoCzIYLmNvbmNvcmRpdW0udjIuVGltZXN0YW1wUg1lZmZlY3RpdmVUaW1lQggKBmNoYW5nZQ'
    '==');

@$core.Deprecated('Use amountFractionDescriptor instead')
const AmountFraction$json = {
  '1': 'AmountFraction',
  '2': [
    {'1': 'parts_per_hundred_thousand', '3': 1, '4': 1, '5': 13, '10': 'partsPerHundredThousand'},
  ],
};

/// Descriptor for `AmountFraction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List amountFractionDescriptor = $convert.base64Decode(
    'Cg5BbW91bnRGcmFjdGlvbhI7ChpwYXJ0c19wZXJfaHVuZHJlZF90aG91c2FuZBgBIAEoDVIXcG'
    'FydHNQZXJIdW5kcmVkVGhvdXNhbmQ=');

@$core.Deprecated('Use commissionRatesDescriptor instead')
const CommissionRates$json = {
  '1': 'CommissionRates',
  '2': [
    {'1': 'finalization', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'finalization'},
    {'1': 'baking', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'baking'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'transaction'},
  ],
};

/// Descriptor for `CommissionRates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commissionRatesDescriptor = $convert.base64Decode(
    'Cg9Db21taXNzaW9uUmF0ZXMSQQoMZmluYWxpemF0aW9uGAEgASgLMh0uY29uY29yZGl1bS52Mi'
    '5BbW91bnRGcmFjdGlvblIMZmluYWxpemF0aW9uEjUKBmJha2luZxgCIAEoCzIdLmNvbmNvcmRp'
    'dW0udjIuQW1vdW50RnJhY3Rpb25SBmJha2luZxI/Cgt0cmFuc2FjdGlvbhgDIAEoCzIdLmNvbm'
    'NvcmRpdW0udjIuQW1vdW50RnJhY3Rpb25SC3RyYW5zYWN0aW9u');

@$core.Deprecated('Use bakerPoolInfoDescriptor instead')
const BakerPoolInfo$json = {
  '1': 'BakerPoolInfo',
  '2': [
    {'1': 'open_status', '3': 1, '4': 1, '5': 14, '6': '.concordium.v2.OpenStatus', '10': 'openStatus'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {'1': 'commission_rates', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.CommissionRates', '10': 'commissionRates'},
  ],
};

/// Descriptor for `BakerPoolInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerPoolInfoDescriptor = $convert.base64Decode(
    'Cg1CYWtlclBvb2xJbmZvEjoKC29wZW5fc3RhdHVzGAEgASgOMhkuY29uY29yZGl1bS52Mi5PcG'
    'VuU3RhdHVzUgpvcGVuU3RhdHVzEhAKA3VybBgCIAEoCVIDdXJsEkkKEGNvbW1pc3Npb25fcmF0'
    'ZXMYAyABKAsyHi5jb25jb3JkaXVtLnYyLkNvbW1pc3Npb25SYXRlc1IPY29tbWlzc2lvblJhdG'
    'Vz');

@$core.Deprecated('Use accountStakingInfoDescriptor instead')
const AccountStakingInfo$json = {
  '1': 'AccountStakingInfo',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountStakingInfo.Baker', '9': 0, '10': 'baker'},
    {'1': 'delegator', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountStakingInfo.Delegator', '9': 0, '10': 'delegator'},
  ],
  '3': [AccountStakingInfo_Baker$json, AccountStakingInfo_Delegator$json],
  '8': [
    {'1': 'staking_info'},
  ],
};

@$core.Deprecated('Use accountStakingInfoDescriptor instead')
const AccountStakingInfo_Baker$json = {
  '1': 'Baker',
  '2': [
    {'1': 'staked_amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'stakedAmount'},
    {'1': 'restake_earnings', '3': 2, '4': 1, '5': 8, '10': 'restakeEarnings'},
    {'1': 'baker_info', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BakerInfo', '10': 'bakerInfo'},
    {'1': 'pending_change', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.StakePendingChange', '9': 0, '10': 'pendingChange', '17': true},
    {'1': 'pool_info', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.BakerPoolInfo', '9': 1, '10': 'poolInfo', '17': true},
  ],
  '8': [
    {'1': '_pending_change'},
    {'1': '_pool_info'},
  ],
};

@$core.Deprecated('Use accountStakingInfoDescriptor instead')
const AccountStakingInfo_Delegator$json = {
  '1': 'Delegator',
  '2': [
    {'1': 'staked_amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'stakedAmount'},
    {'1': 'restake_earnings', '3': 2, '4': 1, '5': 8, '10': 'restakeEarnings'},
    {'1': 'target', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.DelegationTarget', '10': 'target'},
    {'1': 'pending_change', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.StakePendingChange', '9': 0, '10': 'pendingChange', '17': true},
  ],
  '8': [
    {'1': '_pending_change'},
  ],
};

/// Descriptor for `AccountStakingInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountStakingInfoDescriptor = $convert.base64Decode(
    'ChJBY2NvdW50U3Rha2luZ0luZm8SPwoFYmFrZXIYASABKAsyJy5jb25jb3JkaXVtLnYyLkFjY2'
    '91bnRTdGFraW5nSW5mby5CYWtlckgAUgViYWtlchJLCglkZWxlZ2F0b3IYAiABKAsyKy5jb25j'
    'b3JkaXVtLnYyLkFjY291bnRTdGFraW5nSW5mby5EZWxlZ2F0b3JIAFIJZGVsZWdhdG9yGtcCCg'
    'VCYWtlchI6Cg1zdGFrZWRfYW1vdW50GAEgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSDHN0'
    'YWtlZEFtb3VudBIpChByZXN0YWtlX2Vhcm5pbmdzGAIgASgIUg9yZXN0YWtlRWFybmluZ3MSNw'
    'oKYmFrZXJfaW5mbxgDIAEoCzIYLmNvbmNvcmRpdW0udjIuQmFrZXJJbmZvUgliYWtlckluZm8S'
    'TQoOcGVuZGluZ19jaGFuZ2UYBCABKAsyIS5jb25jb3JkaXVtLnYyLlN0YWtlUGVuZGluZ0NoYW'
    '5nZUgAUg1wZW5kaW5nQ2hhbmdliAEBEj4KCXBvb2xfaW5mbxgFIAEoCzIcLmNvbmNvcmRpdW0u'
    'djIuQmFrZXJQb29sSW5mb0gBUghwb29sSW5mb4gBAUIRCg9fcGVuZGluZ19jaGFuZ2VCDAoKX3'
    'Bvb2xfaW5mbxqNAgoJRGVsZWdhdG9yEjoKDXN0YWtlZF9hbW91bnQYASABKAsyFS5jb25jb3Jk'
    'aXVtLnYyLkFtb3VudFIMc3Rha2VkQW1vdW50EikKEHJlc3Rha2VfZWFybmluZ3MYAiABKAhSD3'
    'Jlc3Rha2VFYXJuaW5ncxI3CgZ0YXJnZXQYAyABKAsyHy5jb25jb3JkaXVtLnYyLkRlbGVnYXRp'
    'b25UYXJnZXRSBnRhcmdldBJNCg5wZW5kaW5nX2NoYW5nZRgEIAEoCzIhLmNvbmNvcmRpdW0udj'
    'IuU3Rha2VQZW5kaW5nQ2hhbmdlSABSDXBlbmRpbmdDaGFuZ2WIAQFCEQoPX3BlbmRpbmdfY2hh'
    'bmdlQg4KDHN0YWtpbmdfaW5mbw==');

@$core.Deprecated('Use sequenceNumberDescriptor instead')
const SequenceNumber$json = {
  '1': 'SequenceNumber',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `SequenceNumber`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sequenceNumberDescriptor = $convert.base64Decode(
    'Cg5TZXF1ZW5jZU51bWJlchIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');

@$core.Deprecated('Use updateSequenceNumberDescriptor instead')
const UpdateSequenceNumber$json = {
  '1': 'UpdateSequenceNumber',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `UpdateSequenceNumber`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateSequenceNumberDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVTZXF1ZW5jZU51bWJlchIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');

@$core.Deprecated('Use amountDescriptor instead')
const Amount$json = {
  '1': 'Amount',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `Amount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List amountDescriptor = $convert.base64Decode(
    'CgZBbW91bnQSFAoFdmFsdWUYASABKARSBXZhbHVl');

@$core.Deprecated('Use credentialIndexDescriptor instead')
const CredentialIndex$json = {
  '1': 'CredentialIndex',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `CredentialIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List credentialIndexDescriptor = $convert.base64Decode(
    'Cg9DcmVkZW50aWFsSW5kZXgSFAoFdmFsdWUYASABKA1SBXZhbHVl');

@$core.Deprecated('Use signatureThresholdDescriptor instead')
const SignatureThreshold$json = {
  '1': 'SignatureThreshold',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `SignatureThreshold`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signatureThresholdDescriptor = $convert.base64Decode(
    'ChJTaWduYXR1cmVUaHJlc2hvbGQSFAoFdmFsdWUYASABKA1SBXZhbHVl');

@$core.Deprecated('Use accountThresholdDescriptor instead')
const AccountThreshold$json = {
  '1': 'AccountThreshold',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `AccountThreshold`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountThresholdDescriptor = $convert.base64Decode(
    'ChBBY2NvdW50VGhyZXNob2xkEhQKBXZhbHVlGAEgASgNUgV2YWx1ZQ==');

@$core.Deprecated('Use encryptionKeyDescriptor instead')
const EncryptionKey$json = {
  '1': 'EncryptionKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `EncryptionKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encryptionKeyDescriptor = $convert.base64Decode(
    'Cg1FbmNyeXB0aW9uS2V5EhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use accountAddressDescriptor instead')
const AccountAddress$json = {
  '1': 'AccountAddress',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `AccountAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountAddressDescriptor = $convert.base64Decode(
    'Cg5BY2NvdW50QWRkcmVzcxIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use addressDescriptor instead')
const Address$json = {
  '1': 'Address',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'account'},
    {'1': 'contract', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '9': 0, '10': 'contract'},
  ],
  '8': [
    {'1': 'type'},
  ],
};

/// Descriptor for `Address`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressDescriptor = $convert.base64Decode(
    'CgdBZGRyZXNzEjkKB2FjY291bnQYASABKAsyHS5jb25jb3JkaXVtLnYyLkFjY291bnRBZGRyZX'
    'NzSABSB2FjY291bnQSPAoIY29udHJhY3QYAiABKAsyHi5jb25jb3JkaXVtLnYyLkNvbnRyYWN0'
    'QWRkcmVzc0gAUghjb250cmFjdEIGCgR0eXBl');

@$core.Deprecated('Use accountVerifyKeyDescriptor instead')
const AccountVerifyKey$json = {
  '1': 'AccountVerifyKey',
  '2': [
    {'1': 'ed25519_key', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'ed25519Key'},
  ],
  '8': [
    {'1': 'key'},
  ],
};

/// Descriptor for `AccountVerifyKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountVerifyKeyDescriptor = $convert.base64Decode(
    'ChBBY2NvdW50VmVyaWZ5S2V5EiEKC2VkMjU1MTlfa2V5GAEgASgMSABSCmVkMjU1MTlLZXlCBQ'
    'oDa2V5');

@$core.Deprecated('Use credentialPublicKeysDescriptor instead')
const CredentialPublicKeys$json = {
  '1': 'CredentialPublicKeys',
  '2': [
    {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.CredentialPublicKeys.KeysEntry', '10': 'keys'},
    {'1': 'threshold', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.SignatureThreshold', '10': 'threshold'},
  ],
  '3': [CredentialPublicKeys_KeysEntry$json],
};

@$core.Deprecated('Use credentialPublicKeysDescriptor instead')
const CredentialPublicKeys_KeysEntry$json = {
  '1': 'KeysEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountVerifyKey', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CredentialPublicKeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List credentialPublicKeysDescriptor = $convert.base64Decode(
    'ChRDcmVkZW50aWFsUHVibGljS2V5cxJBCgRrZXlzGAEgAygLMi0uY29uY29yZGl1bS52Mi5Dcm'
    'VkZW50aWFsUHVibGljS2V5cy5LZXlzRW50cnlSBGtleXMSPwoJdGhyZXNob2xkGAIgASgLMiEu'
    'Y29uY29yZGl1bS52Mi5TaWduYXR1cmVUaHJlc2hvbGRSCXRocmVzaG9sZBpYCglLZXlzRW50cn'
    'kSEAoDa2V5GAEgASgNUgNrZXkSNQoFdmFsdWUYAiABKAsyHy5jb25jb3JkaXVtLnYyLkFjY291'
    'bnRWZXJpZnlLZXlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use credentialRegistrationIdDescriptor instead')
const CredentialRegistrationId$json = {
  '1': 'CredentialRegistrationId',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `CredentialRegistrationId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List credentialRegistrationIdDescriptor = $convert.base64Decode(
    'ChhDcmVkZW50aWFsUmVnaXN0cmF0aW9uSWQSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use identityProviderIdentityDescriptor instead')
const IdentityProviderIdentity$json = {
  '1': 'IdentityProviderIdentity',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `IdentityProviderIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List identityProviderIdentityDescriptor = $convert.base64Decode(
    'ChhJZGVudGl0eVByb3ZpZGVySWRlbnRpdHkSFAoFdmFsdWUYASABKA1SBXZhbHVl');

@$core.Deprecated('Use yearMonthDescriptor instead')
const YearMonth$json = {
  '1': 'YearMonth',
  '2': [
    {'1': 'year', '3': 1, '4': 1, '5': 13, '10': 'year'},
    {'1': 'month', '3': 2, '4': 1, '5': 13, '10': 'month'},
  ],
};

/// Descriptor for `YearMonth`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List yearMonthDescriptor = $convert.base64Decode(
    'CglZZWFyTW9udGgSEgoEeWVhchgBIAEoDVIEeWVhchIUCgVtb250aBgCIAEoDVIFbW9udGg=');

@$core.Deprecated('Use policyDescriptor instead')
const Policy$json = {
  '1': 'Policy',
  '2': [
    {'1': 'created_at', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.YearMonth', '10': 'createdAt'},
    {'1': 'valid_to', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.YearMonth', '10': 'validTo'},
    {'1': 'attributes', '3': 3, '4': 3, '5': 11, '6': '.concordium.v2.Policy.AttributesEntry', '10': 'attributes'},
  ],
  '3': [Policy_AttributesEntry$json],
};

@$core.Deprecated('Use policyDescriptor instead')
const Policy_AttributesEntry$json = {
  '1': 'AttributesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Policy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyDescriptor = $convert.base64Decode(
    'CgZQb2xpY3kSNwoKY3JlYXRlZF9hdBgBIAEoCzIYLmNvbmNvcmRpdW0udjIuWWVhck1vbnRoUg'
    'ljcmVhdGVkQXQSMwoIdmFsaWRfdG8YAiABKAsyGC5jb25jb3JkaXVtLnYyLlllYXJNb250aFIH'
    'dmFsaWRUbxJFCgphdHRyaWJ1dGVzGAMgAygLMiUuY29uY29yZGl1bS52Mi5Qb2xpY3kuQXR0cm'
    'lidXRlc0VudHJ5UgphdHRyaWJ1dGVzGj0KD0F0dHJpYnV0ZXNFbnRyeRIQCgNrZXkYASABKA1S'
    'A2tleRIUCgV2YWx1ZRgCIAEoDFIFdmFsdWU6AjgB');

@$core.Deprecated('Use initialCredentialValuesDescriptor instead')
const InitialCredentialValues$json = {
  '1': 'InitialCredentialValues',
  '2': [
    {'1': 'keys', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.CredentialPublicKeys', '10': 'keys'},
    {'1': 'cred_id', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '10': 'credId'},
    {'1': 'ip_id', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.IdentityProviderIdentity', '10': 'ipId'},
    {'1': 'policy', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Policy', '10': 'policy'},
  ],
};

/// Descriptor for `InitialCredentialValues`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initialCredentialValuesDescriptor = $convert.base64Decode(
    'ChdJbml0aWFsQ3JlZGVudGlhbFZhbHVlcxI3CgRrZXlzGAEgASgLMiMuY29uY29yZGl1bS52Mi'
    '5DcmVkZW50aWFsUHVibGljS2V5c1IEa2V5cxJACgdjcmVkX2lkGAIgASgLMicuY29uY29yZGl1'
    'bS52Mi5DcmVkZW50aWFsUmVnaXN0cmF0aW9uSWRSBmNyZWRJZBI8CgVpcF9pZBgDIAEoCzInLm'
    'NvbmNvcmRpdW0udjIuSWRlbnRpdHlQcm92aWRlcklkZW50aXR5UgRpcElkEi0KBnBvbGljeRgE'
    'IAEoCzIVLmNvbmNvcmRpdW0udjIuUG9saWN5UgZwb2xpY3k=');

@$core.Deprecated('Use chainArDataDescriptor instead')
const ChainArData$json = {
  '1': 'ChainArData',
  '2': [
    {'1': 'enc_id_cred_pub_share', '3': 1, '4': 1, '5': 12, '10': 'encIdCredPubShare'},
  ],
};

/// Descriptor for `ChainArData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chainArDataDescriptor = $convert.base64Decode(
    'CgtDaGFpbkFyRGF0YRIwChVlbmNfaWRfY3JlZF9wdWJfc2hhcmUYASABKAxSEWVuY0lkQ3JlZF'
    'B1YlNoYXJl');

@$core.Deprecated('Use arThresholdDescriptor instead')
const ArThreshold$json = {
  '1': 'ArThreshold',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `ArThreshold`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arThresholdDescriptor = $convert.base64Decode(
    'CgtBclRocmVzaG9sZBIUCgV2YWx1ZRgBIAEoDVIFdmFsdWU=');

@$core.Deprecated('Use commitmentDescriptor instead')
const Commitment$json = {
  '1': 'Commitment',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Commitment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commitmentDescriptor = $convert.base64Decode(
    'CgpDb21taXRtZW50EhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use credentialCommitmentsDescriptor instead')
const CredentialCommitments$json = {
  '1': 'CredentialCommitments',
  '2': [
    {'1': 'prf', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Commitment', '10': 'prf'},
    {'1': 'cred_counter', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Commitment', '10': 'credCounter'},
    {'1': 'max_accounts', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Commitment', '10': 'maxAccounts'},
    {'1': 'attributes', '3': 4, '4': 3, '5': 11, '6': '.concordium.v2.CredentialCommitments.AttributesEntry', '10': 'attributes'},
    {'1': 'id_cred_sec_sharing_coeff', '3': 5, '4': 3, '5': 11, '6': '.concordium.v2.Commitment', '10': 'idCredSecSharingCoeff'},
  ],
  '3': [CredentialCommitments_AttributesEntry$json],
};

@$core.Deprecated('Use credentialCommitmentsDescriptor instead')
const CredentialCommitments_AttributesEntry$json = {
  '1': 'AttributesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Commitment', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `CredentialCommitments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List credentialCommitmentsDescriptor = $convert.base64Decode(
    'ChVDcmVkZW50aWFsQ29tbWl0bWVudHMSKwoDcHJmGAEgASgLMhkuY29uY29yZGl1bS52Mi5Db2'
    '1taXRtZW50UgNwcmYSPAoMY3JlZF9jb3VudGVyGAIgASgLMhkuY29uY29yZGl1bS52Mi5Db21t'
    'aXRtZW50UgtjcmVkQ291bnRlchI8CgxtYXhfYWNjb3VudHMYAyABKAsyGS5jb25jb3JkaXVtLn'
    'YyLkNvbW1pdG1lbnRSC21heEFjY291bnRzElQKCmF0dHJpYnV0ZXMYBCADKAsyNC5jb25jb3Jk'
    'aXVtLnYyLkNyZWRlbnRpYWxDb21taXRtZW50cy5BdHRyaWJ1dGVzRW50cnlSCmF0dHJpYnV0ZX'
    'MSUwoZaWRfY3JlZF9zZWNfc2hhcmluZ19jb2VmZhgFIAMoCzIZLmNvbmNvcmRpdW0udjIuQ29t'
    'bWl0bWVudFIVaWRDcmVkU2VjU2hhcmluZ0NvZWZmGlgKD0F0dHJpYnV0ZXNFbnRyeRIQCgNrZX'
    'kYASABKA1SA2tleRIvCgV2YWx1ZRgCIAEoCzIZLmNvbmNvcmRpdW0udjIuQ29tbWl0bWVudFIF'
    'dmFsdWU6AjgB');

@$core.Deprecated('Use normalCredentialValuesDescriptor instead')
const NormalCredentialValues$json = {
  '1': 'NormalCredentialValues',
  '2': [
    {'1': 'keys', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.CredentialPublicKeys', '10': 'keys'},
    {'1': 'cred_id', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '10': 'credId'},
    {'1': 'ip_id', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.IdentityProviderIdentity', '10': 'ipId'},
    {'1': 'policy', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Policy', '10': 'policy'},
    {'1': 'ar_threshold', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.ArThreshold', '10': 'arThreshold'},
    {'1': 'ar_data', '3': 6, '4': 3, '5': 11, '6': '.concordium.v2.NormalCredentialValues.ArDataEntry', '10': 'arData'},
    {'1': 'commitments', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.CredentialCommitments', '10': 'commitments'},
  ],
  '3': [NormalCredentialValues_ArDataEntry$json],
};

@$core.Deprecated('Use normalCredentialValuesDescriptor instead')
const NormalCredentialValues_ArDataEntry$json = {
  '1': 'ArDataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ChainArData', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NormalCredentialValues`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List normalCredentialValuesDescriptor = $convert.base64Decode(
    'ChZOb3JtYWxDcmVkZW50aWFsVmFsdWVzEjcKBGtleXMYASABKAsyIy5jb25jb3JkaXVtLnYyLk'
    'NyZWRlbnRpYWxQdWJsaWNLZXlzUgRrZXlzEkAKB2NyZWRfaWQYAiABKAsyJy5jb25jb3JkaXVt'
    'LnYyLkNyZWRlbnRpYWxSZWdpc3RyYXRpb25JZFIGY3JlZElkEjwKBWlwX2lkGAMgASgLMicuY2'
    '9uY29yZGl1bS52Mi5JZGVudGl0eVByb3ZpZGVySWRlbnRpdHlSBGlwSWQSLQoGcG9saWN5GAQg'
    'ASgLMhUuY29uY29yZGl1bS52Mi5Qb2xpY3lSBnBvbGljeRI9Cgxhcl90aHJlc2hvbGQYBSABKA'
    'syGi5jb25jb3JkaXVtLnYyLkFyVGhyZXNob2xkUgthclRocmVzaG9sZBJKCgdhcl9kYXRhGAYg'
    'AygLMjEuY29uY29yZGl1bS52Mi5Ob3JtYWxDcmVkZW50aWFsVmFsdWVzLkFyRGF0YUVudHJ5Ug'
    'ZhckRhdGESRgoLY29tbWl0bWVudHMYByABKAsyJC5jb25jb3JkaXVtLnYyLkNyZWRlbnRpYWxD'
    'b21taXRtZW50c1ILY29tbWl0bWVudHMaVQoLQXJEYXRhRW50cnkSEAoDa2V5GAEgASgNUgNrZX'
    'kSMAoFdmFsdWUYAiABKAsyGi5jb25jb3JkaXVtLnYyLkNoYWluQXJEYXRhUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use accountCredentialDescriptor instead')
const AccountCredential$json = {
  '1': 'AccountCredential',
  '2': [
    {'1': 'initial', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.InitialCredentialValues', '9': 0, '10': 'initial'},
    {'1': 'normal', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.NormalCredentialValues', '9': 0, '10': 'normal'},
  ],
  '8': [
    {'1': 'credential_values'},
  ],
};

/// Descriptor for `AccountCredential`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountCredentialDescriptor = $convert.base64Decode(
    'ChFBY2NvdW50Q3JlZGVudGlhbBJCCgdpbml0aWFsGAEgASgLMiYuY29uY29yZGl1bS52Mi5Jbm'
    'l0aWFsQ3JlZGVudGlhbFZhbHVlc0gAUgdpbml0aWFsEj8KBm5vcm1hbBgCIAEoCzIlLmNvbmNv'
    'cmRpdW0udjIuTm9ybWFsQ3JlZGVudGlhbFZhbHVlc0gAUgZub3JtYWxCEwoRY3JlZGVudGlhbF'
    '92YWx1ZXM=');

@$core.Deprecated('Use accountInfoDescriptor instead')
const AccountInfo$json = {
  '1': 'AccountInfo',
  '2': [
    {'1': 'sequence_number', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'sequenceNumber'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'schedule', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ReleaseSchedule', '10': 'schedule'},
    {'1': 'creds', '3': 4, '4': 3, '5': 11, '6': '.concordium.v2.AccountInfo.CredsEntry', '10': 'creds'},
    {'1': 'threshold', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.AccountThreshold', '10': 'threshold'},
    {'1': 'encrypted_balance', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedBalance', '10': 'encryptedBalance'},
    {'1': 'encryption_key', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.EncryptionKey', '10': 'encryptionKey'},
    {'1': 'index', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.AccountIndex', '10': 'index'},
    {'1': 'stake', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.AccountStakingInfo', '9': 0, '10': 'stake', '17': true},
    {'1': 'address', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'address'},
  ],
  '3': [AccountInfo_CredsEntry$json],
  '8': [
    {'1': '_stake'},
  ],
};

@$core.Deprecated('Use accountInfoDescriptor instead')
const AccountInfo_CredsEntry$json = {
  '1': 'CredsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountCredential', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `AccountInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountInfoDescriptor = $convert.base64Decode(
    'CgtBY2NvdW50SW5mbxJGCg9zZXF1ZW5jZV9udW1iZXIYASABKAsyHS5jb25jb3JkaXVtLnYyLl'
    'NlcXVlbmNlTnVtYmVyUg5zZXF1ZW5jZU51bWJlchItCgZhbW91bnQYAiABKAsyFS5jb25jb3Jk'
    'aXVtLnYyLkFtb3VudFIGYW1vdW50EjoKCHNjaGVkdWxlGAMgASgLMh4uY29uY29yZGl1bS52Mi'
    '5SZWxlYXNlU2NoZWR1bGVSCHNjaGVkdWxlEjsKBWNyZWRzGAQgAygLMiUuY29uY29yZGl1bS52'
    'Mi5BY2NvdW50SW5mby5DcmVkc0VudHJ5UgVjcmVkcxI9Cgl0aHJlc2hvbGQYBSABKAsyHy5jb2'
    '5jb3JkaXVtLnYyLkFjY291bnRUaHJlc2hvbGRSCXRocmVzaG9sZBJMChFlbmNyeXB0ZWRfYmFs'
    'YW5jZRgGIAEoCzIfLmNvbmNvcmRpdW0udjIuRW5jcnlwdGVkQmFsYW5jZVIQZW5jcnlwdGVkQm'
    'FsYW5jZRJDCg5lbmNyeXB0aW9uX2tleRgHIAEoCzIcLmNvbmNvcmRpdW0udjIuRW5jcnlwdGlv'
    'bktleVINZW5jcnlwdGlvbktleRIxCgVpbmRleBgIIAEoCzIbLmNvbmNvcmRpdW0udjIuQWNjb3'
    'VudEluZGV4UgVpbmRleBI8CgVzdGFrZRgJIAEoCzIhLmNvbmNvcmRpdW0udjIuQWNjb3VudFN0'
    'YWtpbmdJbmZvSABSBXN0YWtliAEBEjcKB2FkZHJlc3MYCiABKAsyHS5jb25jb3JkaXVtLnYyLk'
    'FjY291bnRBZGRyZXNzUgdhZGRyZXNzGloKCkNyZWRzRW50cnkSEAoDa2V5GAEgASgNUgNrZXkS'
    'NgoFdmFsdWUYAiABKAsyIC5jb25jb3JkaXVtLnYyLkFjY291bnRDcmVkZW50aWFsUgV2YWx1ZT'
    'oCOAFCCAoGX3N0YWtl');

@$core.Deprecated('Use blockHashInputDescriptor instead')
const BlockHashInput$json = {
  '1': 'BlockHashInput',
  '2': [
    {'1': 'best', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'best'},
    {'1': 'last_final', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'lastFinal'},
    {'1': 'given', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '9': 0, '10': 'given'},
    {'1': 'absolute_height', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AbsoluteBlockHeight', '9': 0, '10': 'absoluteHeight'},
    {'1': 'relative_height', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput.RelativeHeight', '9': 0, '10': 'relativeHeight'},
  ],
  '3': [BlockHashInput_RelativeHeight$json],
  '8': [
    {'1': 'block_hash_input'},
  ],
};

@$core.Deprecated('Use blockHashInputDescriptor instead')
const BlockHashInput_RelativeHeight$json = {
  '1': 'RelativeHeight',
  '2': [
    {'1': 'genesis_index', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.GenesisIndex', '10': 'genesisIndex'},
    {'1': 'height', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockHeight', '10': 'height'},
    {'1': 'restrict', '3': 3, '4': 1, '5': 8, '10': 'restrict'},
  ],
};

/// Descriptor for `BlockHashInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockHashInputDescriptor = $convert.base64Decode(
    'Cg5CbG9ja0hhc2hJbnB1dBIqCgRiZXN0GAEgASgLMhQuY29uY29yZGl1bS52Mi5FbXB0eUgAUg'
    'RiZXN0EjUKCmxhc3RfZmluYWwYAiABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SABSCWxhc3RG'
    'aW5hbBIwCgVnaXZlbhgDIAEoCzIYLmNvbmNvcmRpdW0udjIuQmxvY2tIYXNoSABSBWdpdmVuEk'
    '0KD2Fic29sdXRlX2hlaWdodBgEIAEoCzIiLmNvbmNvcmRpdW0udjIuQWJzb2x1dGVCbG9ja0hl'
    'aWdodEgAUg5hYnNvbHV0ZUhlaWdodBJXCg9yZWxhdGl2ZV9oZWlnaHQYBSABKAsyLC5jb25jb3'
    'JkaXVtLnYyLkJsb2NrSGFzaElucHV0LlJlbGF0aXZlSGVpZ2h0SABSDnJlbGF0aXZlSGVpZ2h0'
    'GqIBCg5SZWxhdGl2ZUhlaWdodBJACg1nZW5lc2lzX2luZGV4GAEgASgLMhsuY29uY29yZGl1bS'
    '52Mi5HZW5lc2lzSW5kZXhSDGdlbmVzaXNJbmRleBIyCgZoZWlnaHQYAiABKAsyGi5jb25jb3Jk'
    'aXVtLnYyLkJsb2NrSGVpZ2h0UgZoZWlnaHQSGgoIcmVzdHJpY3QYAyABKAhSCHJlc3RyaWN0Qh'
    'IKEGJsb2NrX2hhc2hfaW5wdXQ=');

@$core.Deprecated('Use epochRequestDescriptor instead')
const EpochRequest$json = {
  '1': 'EpochRequest',
  '2': [
    {'1': 'relative_epoch', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.EpochRequest.RelativeEpoch', '9': 0, '10': 'relativeEpoch'},
    {'1': 'block_hash', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '9': 0, '10': 'blockHash'},
  ],
  '3': [EpochRequest_RelativeEpoch$json],
  '8': [
    {'1': 'epoch_request_input'},
  ],
};

@$core.Deprecated('Use epochRequestDescriptor instead')
const EpochRequest_RelativeEpoch$json = {
  '1': 'RelativeEpoch',
  '2': [
    {'1': 'genesis_index', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.GenesisIndex', '10': 'genesisIndex'},
    {'1': 'epoch', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Epoch', '10': 'epoch'},
  ],
};

/// Descriptor for `EpochRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List epochRequestDescriptor = $convert.base64Decode(
    'CgxFcG9jaFJlcXVlc3QSUgoOcmVsYXRpdmVfZXBvY2gYASABKAsyKS5jb25jb3JkaXVtLnYyLk'
    'Vwb2NoUmVxdWVzdC5SZWxhdGl2ZUVwb2NoSABSDXJlbGF0aXZlRXBvY2gSPgoKYmxvY2tfaGFz'
    'aBgCIAEoCzIdLmNvbmNvcmRpdW0udjIuQmxvY2tIYXNoSW5wdXRIAFIJYmxvY2tIYXNoGn0KDV'
    'JlbGF0aXZlRXBvY2gSQAoNZ2VuZXNpc19pbmRleBgBIAEoCzIbLmNvbmNvcmRpdW0udjIuR2Vu'
    'ZXNpc0luZGV4UgxnZW5lc2lzSW5kZXgSKgoFZXBvY2gYAiABKAsyFC5jb25jb3JkaXVtLnYyLk'
    'Vwb2NoUgVlcG9jaEIVChNlcG9jaF9yZXF1ZXN0X2lucHV0');

@$core.Deprecated('Use accountIdentifierInputDescriptor instead')
const AccountIdentifierInput$json = {
  '1': 'AccountIdentifierInput',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'address'},
    {'1': 'cred_id', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '9': 0, '10': 'credId'},
    {'1': 'account_index', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccountIndex', '9': 0, '10': 'accountIndex'},
  ],
  '8': [
    {'1': 'account_identifier_input'},
  ],
};

/// Descriptor for `AccountIdentifierInput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountIdentifierInputDescriptor = $convert.base64Decode(
    'ChZBY2NvdW50SWRlbnRpZmllcklucHV0EjkKB2FkZHJlc3MYASABKAsyHS5jb25jb3JkaXVtLn'
    'YyLkFjY291bnRBZGRyZXNzSABSB2FkZHJlc3MSQgoHY3JlZF9pZBgCIAEoCzInLmNvbmNvcmRp'
    'dW0udjIuQ3JlZGVudGlhbFJlZ2lzdHJhdGlvbklkSABSBmNyZWRJZBJCCg1hY2NvdW50X2luZG'
    'V4GAMgASgLMhsuY29uY29yZGl1bS52Mi5BY2NvdW50SW5kZXhIAFIMYWNjb3VudEluZGV4QhoK'
    'GGFjY291bnRfaWRlbnRpZmllcl9pbnB1dA==');

@$core.Deprecated('Use accountInfoRequestDescriptor instead')
const AccountInfoRequest$json = {
  '1': 'AccountInfoRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'account_identifier', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountIdentifierInput', '10': 'accountIdentifier'},
  ],
};

/// Descriptor for `AccountInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountInfoRequestDescriptor = $convert.base64Decode(
    'ChJBY2NvdW50SW5mb1JlcXVlc3QSPAoKYmxvY2tfaGFzaBgBIAEoCzIdLmNvbmNvcmRpdW0udj'
    'IuQmxvY2tIYXNoSW5wdXRSCWJsb2NrSGFzaBJUChJhY2NvdW50X2lkZW50aWZpZXIYAiABKAsy'
    'JS5jb25jb3JkaXVtLnYyLkFjY291bnRJZGVudGlmaWVySW5wdXRSEWFjY291bnRJZGVudGlmaW'
    'Vy');

@$core.Deprecated('Use finalizedBlockInfoDescriptor instead')
const FinalizedBlockInfo$json = {
  '1': 'FinalizedBlockInfo',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'hash'},
    {'1': 'height', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AbsoluteBlockHeight', '10': 'height'},
  ],
};

/// Descriptor for `FinalizedBlockInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizedBlockInfoDescriptor = $convert.base64Decode(
    'ChJGaW5hbGl6ZWRCbG9ja0luZm8SLAoEaGFzaBgBIAEoCzIYLmNvbmNvcmRpdW0udjIuQmxvY2'
    'tIYXNoUgRoYXNoEjoKBmhlaWdodBgCIAEoCzIiLmNvbmNvcmRpdW0udjIuQWJzb2x1dGVCbG9j'
    'a0hlaWdodFIGaGVpZ2h0');

@$core.Deprecated('Use ancestorsRequestDescriptor instead')
const AncestorsRequest$json = {
  '1': 'AncestorsRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
  ],
};

/// Descriptor for `AncestorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ancestorsRequestDescriptor = $convert.base64Decode(
    'ChBBbmNlc3RvcnNSZXF1ZXN0EjwKCmJsb2NrX2hhc2gYASABKAsyHS5jb25jb3JkaXVtLnYyLk'
    'Jsb2NrSGFzaElucHV0UglibG9ja0hhc2gSFgoGYW1vdW50GAIgASgEUgZhbW91bnQ=');

@$core.Deprecated('Use moduleSourceRequestDescriptor instead')
const ModuleSourceRequest$json = {
  '1': 'ModuleSourceRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'module_ref', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'moduleRef'},
  ],
};

/// Descriptor for `ModuleSourceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moduleSourceRequestDescriptor = $convert.base64Decode(
    'ChNNb2R1bGVTb3VyY2VSZXF1ZXN0EjwKCmJsb2NrX2hhc2gYASABKAsyHS5jb25jb3JkaXVtLn'
    'YyLkJsb2NrSGFzaElucHV0UglibG9ja0hhc2gSNwoKbW9kdWxlX3JlZhgCIAEoCzIYLmNvbmNv'
    'cmRpdW0udjIuTW9kdWxlUmVmUgltb2R1bGVSZWY=');

@$core.Deprecated('Use contractAddressDescriptor instead')
const ContractAddress$json = {
  '1': 'ContractAddress',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 4, '10': 'index'},
    {'1': 'subindex', '3': 2, '4': 1, '5': 4, '10': 'subindex'},
  ],
};

/// Descriptor for `ContractAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contractAddressDescriptor = $convert.base64Decode(
    'Cg9Db250cmFjdEFkZHJlc3MSFAoFaW5kZXgYASABKARSBWluZGV4EhoKCHN1YmluZGV4GAIgAS'
    'gEUghzdWJpbmRleA==');

@$core.Deprecated('Use instanceInfoRequestDescriptor instead')
const InstanceInfoRequest$json = {
  '1': 'InstanceInfoRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
  ],
};

/// Descriptor for `InstanceInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceInfoRequestDescriptor = $convert.base64Decode(
    'ChNJbnN0YW5jZUluZm9SZXF1ZXN0EjwKCmJsb2NrX2hhc2gYASABKAsyHS5jb25jb3JkaXVtLn'
    'YyLkJsb2NrSGFzaElucHV0UglibG9ja0hhc2gSOAoHYWRkcmVzcxgCIAEoCzIeLmNvbmNvcmRp'
    'dW0udjIuQ29udHJhY3RBZGRyZXNzUgdhZGRyZXNz');

@$core.Deprecated('Use instanceInfoDescriptor instead')
const InstanceInfo$json = {
  '1': 'InstanceInfo',
  '2': [
    {'1': 'v0', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.InstanceInfo.V0', '9': 0, '10': 'v0'},
    {'1': 'v1', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.InstanceInfo.V1', '9': 0, '10': 'v1'},
  ],
  '3': [InstanceInfo_V0$json, InstanceInfo_V1$json],
  '8': [
    {'1': 'version'},
  ],
};

@$core.Deprecated('Use instanceInfoDescriptor instead')
const InstanceInfo_V0$json = {
  '1': 'V0',
  '2': [
    {'1': 'model', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ContractStateV0', '10': 'model'},
    {'1': 'owner', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'owner'},
    {'1': 'amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'methods', '3': 4, '4': 3, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'methods'},
    {'1': 'name', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.InitName', '10': 'name'},
    {'1': 'source_module', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'sourceModule'},
  ],
};

@$core.Deprecated('Use instanceInfoDescriptor instead')
const InstanceInfo_V1$json = {
  '1': 'V1',
  '2': [
    {'1': 'owner', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'owner'},
    {'1': 'amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'methods', '3': 4, '4': 3, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'methods'},
    {'1': 'name', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.InitName', '10': 'name'},
    {'1': 'source_module', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'sourceModule'},
  ],
};

/// Descriptor for `InstanceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceInfoDescriptor = $convert.base64Decode(
    'CgxJbnN0YW5jZUluZm8SMAoCdjAYASABKAsyHi5jb25jb3JkaXVtLnYyLkluc3RhbmNlSW5mby'
    '5WMEgAUgJ2MBIwCgJ2MRgCIAEoCzIeLmNvbmNvcmRpdW0udjIuSW5zdGFuY2VJbmZvLlYxSABS'
    'AnYxGsACCgJWMBI0CgVtb2RlbBgBIAEoCzIeLmNvbmNvcmRpdW0udjIuQ29udHJhY3RTdGF0ZV'
    'YwUgVtb2RlbBIzCgVvd25lchgCIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NS'
    'BW93bmVyEi0KBmFtb3VudBgDIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UgZhbW91bnQSNA'
    'oHbWV0aG9kcxgEIAMoCzIaLmNvbmNvcmRpdW0udjIuUmVjZWl2ZU5hbWVSB21ldGhvZHMSKwoE'
    'bmFtZRgFIAEoCzIXLmNvbmNvcmRpdW0udjIuSW5pdE5hbWVSBG5hbWUSPQoNc291cmNlX21vZH'
    'VsZRgGIAEoCzIYLmNvbmNvcmRpdW0udjIuTW9kdWxlUmVmUgxzb3VyY2VNb2R1bGUaigIKAlYx'
    'EjMKBW93bmVyGAIgASgLMh0uY29uY29yZGl1bS52Mi5BY2NvdW50QWRkcmVzc1IFb3duZXISLQ'
    'oGYW1vdW50GAMgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSBmFtb3VudBI0CgdtZXRob2Rz'
    'GAQgAygLMhouY29uY29yZGl1bS52Mi5SZWNlaXZlTmFtZVIHbWV0aG9kcxIrCgRuYW1lGAUgAS'
    'gLMhcuY29uY29yZGl1bS52Mi5Jbml0TmFtZVIEbmFtZRI9Cg1zb3VyY2VfbW9kdWxlGAYgASgL'
    'MhguY29uY29yZGl1bS52Mi5Nb2R1bGVSZWZSDHNvdXJjZU1vZHVsZUIJCgd2ZXJzaW9u');

@$core.Deprecated('Use instanceStateKVPairDescriptor instead')
const InstanceStateKVPair$json = {
  '1': 'InstanceStateKVPair',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `InstanceStateKVPair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceStateKVPairDescriptor = $convert.base64Decode(
    'ChNJbnN0YW5jZVN0YXRlS1ZQYWlyEhAKA2tleRgBIAEoDFIDa2V5EhQKBXZhbHVlGAIgASgMUg'
    'V2YWx1ZQ==');

@$core.Deprecated('Use instanceStateLookupRequestDescriptor instead')
const InstanceStateLookupRequest$json = {
  '1': 'InstanceStateLookupRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
    {'1': 'key', '3': 3, '4': 1, '5': 12, '10': 'key'},
  ],
};

/// Descriptor for `InstanceStateLookupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceStateLookupRequestDescriptor = $convert.base64Decode(
    'ChpJbnN0YW5jZVN0YXRlTG9va3VwUmVxdWVzdBI8CgpibG9ja19oYXNoGAEgASgLMh0uY29uY2'
    '9yZGl1bS52Mi5CbG9ja0hhc2hJbnB1dFIJYmxvY2tIYXNoEjgKB2FkZHJlc3MYAiABKAsyHi5j'
    'b25jb3JkaXVtLnYyLkNvbnRyYWN0QWRkcmVzc1IHYWRkcmVzcxIQCgNrZXkYAyABKAxSA2tleQ'
    '==');

@$core.Deprecated('Use instanceStateValueAtKeyDescriptor instead')
const InstanceStateValueAtKey$json = {
  '1': 'InstanceStateValueAtKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `InstanceStateValueAtKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceStateValueAtKeyDescriptor = $convert.base64Decode(
    'ChdJbnN0YW5jZVN0YXRlVmFsdWVBdEtleRIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use receiveNameDescriptor instead')
const ReceiveName$json = {
  '1': 'ReceiveName',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `ReceiveName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiveNameDescriptor = $convert.base64Decode(
    'CgtSZWNlaXZlTmFtZRIUCgV2YWx1ZRgBIAEoCVIFdmFsdWU=');

@$core.Deprecated('Use initNameDescriptor instead')
const InitName$json = {
  '1': 'InitName',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `InitName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initNameDescriptor = $convert.base64Decode(
    'CghJbml0TmFtZRIUCgV2YWx1ZRgBIAEoCVIFdmFsdWU=');

@$core.Deprecated('Use parameterDescriptor instead')
const Parameter$json = {
  '1': 'Parameter',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Parameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List parameterDescriptor = $convert.base64Decode(
    'CglQYXJhbWV0ZXISFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use contractStateV0Descriptor instead')
const ContractStateV0$json = {
  '1': 'ContractStateV0',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `ContractStateV0`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contractStateV0Descriptor = $convert.base64Decode(
    'Cg9Db250cmFjdFN0YXRlVjASFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use blockItemStatusDescriptor instead')
const BlockItemStatus$json = {
  '1': 'BlockItemStatus',
  '2': [
    {'1': 'received', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'received'},
    {'1': 'committed', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockItemStatus.Committed', '9': 0, '10': 'committed'},
    {'1': 'finalized', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BlockItemStatus.Finalized', '9': 0, '10': 'finalized'},
  ],
  '3': [BlockItemStatus_Committed$json, BlockItemStatus_Finalized$json],
  '8': [
    {'1': 'status'},
  ],
};

@$core.Deprecated('Use blockItemStatusDescriptor instead')
const BlockItemStatus_Committed$json = {
  '1': 'Committed',
  '2': [
    {'1': 'outcomes', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.BlockItemSummaryInBlock', '10': 'outcomes'},
  ],
};

@$core.Deprecated('Use blockItemStatusDescriptor instead')
const BlockItemStatus_Finalized$json = {
  '1': 'Finalized',
  '2': [
    {'1': 'outcome', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockItemSummaryInBlock', '10': 'outcome'},
  ],
};

/// Descriptor for `BlockItemStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockItemStatusDescriptor = $convert.base64Decode(
    'Cg9CbG9ja0l0ZW1TdGF0dXMSMgoIcmVjZWl2ZWQYASABKAsyFC5jb25jb3JkaXVtLnYyLkVtcH'
    'R5SABSCHJlY2VpdmVkEkgKCWNvbW1pdHRlZBgCIAEoCzIoLmNvbmNvcmRpdW0udjIuQmxvY2tJ'
    'dGVtU3RhdHVzLkNvbW1pdHRlZEgAUgljb21taXR0ZWQSSAoJZmluYWxpemVkGAMgASgLMiguY2'
    '9uY29yZGl1bS52Mi5CbG9ja0l0ZW1TdGF0dXMuRmluYWxpemVkSABSCWZpbmFsaXplZBpPCglD'
    'b21taXR0ZWQSQgoIb3V0Y29tZXMYASADKAsyJi5jb25jb3JkaXVtLnYyLkJsb2NrSXRlbVN1bW'
    '1hcnlJbkJsb2NrUghvdXRjb21lcxpNCglGaW5hbGl6ZWQSQAoHb3V0Y29tZRgBIAEoCzImLmNv'
    'bmNvcmRpdW0udjIuQmxvY2tJdGVtU3VtbWFyeUluQmxvY2tSB291dGNvbWVCCAoGc3RhdHVz');

@$core.Deprecated('Use blockItemSummaryInBlockDescriptor instead')
const BlockItemSummaryInBlock$json = {
  '1': 'BlockItemSummaryInBlock',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'blockHash'},
    {'1': 'outcome', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockItemSummary', '10': 'outcome'},
  ],
};

/// Descriptor for `BlockItemSummaryInBlock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockItemSummaryInBlockDescriptor = $convert.base64Decode(
    'ChdCbG9ja0l0ZW1TdW1tYXJ5SW5CbG9jaxI3CgpibG9ja19oYXNoGAEgASgLMhguY29uY29yZG'
    'l1bS52Mi5CbG9ja0hhc2hSCWJsb2NrSGFzaBI5CgdvdXRjb21lGAIgASgLMh8uY29uY29yZGl1'
    'bS52Mi5CbG9ja0l0ZW1TdW1tYXJ5UgdvdXRjb21l');

@$core.Deprecated('Use energyDescriptor instead')
const Energy$json = {
  '1': 'Energy',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `Energy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List energyDescriptor = $convert.base64Decode(
    'CgZFbmVyZ3kSFAoFdmFsdWUYASABKARSBXZhbHVl');

@$core.Deprecated('Use slotDescriptor instead')
const Slot$json = {
  '1': 'Slot',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `Slot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List slotDescriptor = $convert.base64Decode(
    'CgRTbG90EhQKBXZhbHVlGAEgASgEUgV2YWx1ZQ==');

@$core.Deprecated('Use nextAccountSequenceNumberDescriptor instead')
const NextAccountSequenceNumber$json = {
  '1': 'NextAccountSequenceNumber',
  '2': [
    {'1': 'sequence_number', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'sequenceNumber'},
    {'1': 'all_final', '3': 2, '4': 1, '5': 8, '10': 'allFinal'},
  ],
};

/// Descriptor for `NextAccountSequenceNumber`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nextAccountSequenceNumberDescriptor = $convert.base64Decode(
    'ChlOZXh0QWNjb3VudFNlcXVlbmNlTnVtYmVyEkYKD3NlcXVlbmNlX251bWJlchgBIAEoCzIdLm'
    'NvbmNvcmRpdW0udjIuU2VxdWVuY2VOdW1iZXJSDnNlcXVlbmNlTnVtYmVyEhsKCWFsbF9maW5h'
    'bBgCIAEoCFIIYWxsRmluYWw=');

@$core.Deprecated('Use durationDescriptor instead')
const Duration$json = {
  '1': 'Duration',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `Duration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List durationDescriptor = $convert.base64Decode(
    'CghEdXJhdGlvbhIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason$json = {
  '1': 'RejectReason',
  '2': [
    {'1': 'module_not_wf', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'moduleNotWf'},
    {'1': 'module_hash_already_exists', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '9': 0, '10': 'moduleHashAlreadyExists'},
    {'1': 'invalid_account_reference', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'invalidAccountReference'},
    {'1': 'invalid_init_method', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason.InvalidInitMethod', '9': 0, '10': 'invalidInitMethod'},
    {'1': 'invalid_receive_method', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason.InvalidReceiveMethod', '9': 0, '10': 'invalidReceiveMethod'},
    {'1': 'invalid_module_reference', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '9': 0, '10': 'invalidModuleReference'},
    {'1': 'invalid_contract_address', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '9': 0, '10': 'invalidContractAddress'},
    {'1': 'runtime_failure', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'runtimeFailure'},
    {'1': 'amount_too_large', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason.AmountTooLarge', '9': 0, '10': 'amountTooLarge'},
    {'1': 'serialization_failure', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'serializationFailure'},
    {'1': 'out_of_energy', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'outOfEnergy'},
    {'1': 'rejected_init', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason.RejectedInit', '9': 0, '10': 'rejectedInit'},
    {'1': 'rejected_receive', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason.RejectedReceive', '9': 0, '10': 'rejectedReceive'},
    {'1': 'invalid_proof', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'invalidProof'},
    {'1': 'already_a_baker', '3': 15, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '9': 0, '10': 'alreadyABaker'},
    {'1': 'not_a_baker', '3': 16, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'notABaker'},
    {'1': 'insufficient_balance_for_baker_stake', '3': 17, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'insufficientBalanceForBakerStake'},
    {'1': 'stake_under_minimum_threshold_for_baking', '3': 18, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'stakeUnderMinimumThresholdForBaking'},
    {'1': 'baker_in_cooldown', '3': 19, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'bakerInCooldown'},
    {'1': 'duplicate_aggregation_key', '3': 20, '4': 1, '5': 11, '6': '.concordium.v2.BakerAggregationVerifyKey', '9': 0, '10': 'duplicateAggregationKey'},
    {'1': 'non_existent_credential_id', '3': 21, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'nonExistentCredentialId'},
    {'1': 'key_index_already_in_use', '3': 22, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'keyIndexAlreadyInUse'},
    {'1': 'invalid_account_threshold', '3': 23, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'invalidAccountThreshold'},
    {'1': 'invalid_credential_key_sign_threshold', '3': 24, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'invalidCredentialKeySignThreshold'},
    {'1': 'invalid_encrypted_amount_transfer_proof', '3': 25, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'invalidEncryptedAmountTransferProof'},
    {'1': 'invalid_transfer_to_public_proof', '3': 26, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'invalidTransferToPublicProof'},
    {'1': 'encrypted_amount_self_transfer', '3': 27, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'encryptedAmountSelfTransfer'},
    {'1': 'invalid_index_on_encrypted_transfer', '3': 28, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'invalidIndexOnEncryptedTransfer'},
    {'1': 'zero_scheduledAmount', '3': 29, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'zeroScheduledAmount'},
    {'1': 'non_increasing_schedule', '3': 30, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'nonIncreasingSchedule'},
    {'1': 'first_scheduled_release_expired', '3': 31, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'firstScheduledReleaseExpired'},
    {'1': 'scheduled_self_transfer', '3': 32, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'scheduledSelfTransfer'},
    {'1': 'invalid_credentials', '3': 33, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'invalidCredentials'},
    {'1': 'duplicate_cred_ids', '3': 34, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason.DuplicateCredIds', '9': 0, '10': 'duplicateCredIds'},
    {'1': 'non_existent_cred_ids', '3': 35, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason.NonExistentCredIds', '9': 0, '10': 'nonExistentCredIds'},
    {'1': 'remove_first_credential', '3': 36, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'removeFirstCredential'},
    {'1': 'credential_holder_did_not_sign', '3': 37, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'credentialHolderDidNotSign'},
    {'1': 'not_allowed_multiple_credentials', '3': 38, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'notAllowedMultipleCredentials'},
    {'1': 'not_allowed_to_receive_encrypted', '3': 39, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'notAllowedToReceiveEncrypted'},
    {'1': 'not_allowed_to_handle_encrypted', '3': 40, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'notAllowedToHandleEncrypted'},
    {'1': 'missing_baker_add_parameters', '3': 41, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'missingBakerAddParameters'},
    {'1': 'finalization_reward_commission_not_in_range', '3': 42, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'finalizationRewardCommissionNotInRange'},
    {'1': 'baking_reward_commission_not_in_range', '3': 43, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'bakingRewardCommissionNotInRange'},
    {'1': 'transaction_fee_commission_not_in_range', '3': 44, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'transactionFeeCommissionNotInRange'},
    {'1': 'already_a_delegator', '3': 45, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'alreadyADelegator'},
    {'1': 'insufficient_balance_for_delegation_stake', '3': 46, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'insufficientBalanceForDelegationStake'},
    {'1': 'missing_delegation_add_parameters', '3': 47, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'missingDelegationAddParameters'},
    {'1': 'insufficient_delegation_stake', '3': 48, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'insufficientDelegationStake'},
    {'1': 'delegator_in_cooldown', '3': 49, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'delegatorInCooldown'},
    {'1': 'not_a_delegator', '3': 50, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'notADelegator'},
    {'1': 'delegation_target_not_a_baker', '3': 51, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '9': 0, '10': 'delegationTargetNotABaker'},
    {'1': 'stake_over_maximum_threshold_for_pool', '3': 52, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'stakeOverMaximumThresholdForPool'},
    {'1': 'pool_would_become_over_delegated', '3': 53, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'poolWouldBecomeOverDelegated'},
    {'1': 'pool_closed', '3': 54, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'poolClosed'},
  ],
  '3': [RejectReason_InvalidInitMethod$json, RejectReason_InvalidReceiveMethod$json, RejectReason_AmountTooLarge$json, RejectReason_RejectedInit$json, RejectReason_RejectedReceive$json, RejectReason_DuplicateCredIds$json, RejectReason_NonExistentCredIds$json],
  '8': [
    {'1': 'reason'},
  ],
};

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason_InvalidInitMethod$json = {
  '1': 'InvalidInitMethod',
  '2': [
    {'1': 'module_ref', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'moduleRef'},
    {'1': 'init_name', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.InitName', '10': 'initName'},
  ],
};

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason_InvalidReceiveMethod$json = {
  '1': 'InvalidReceiveMethod',
  '2': [
    {'1': 'module_ref', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'moduleRef'},
    {'1': 'receive_name', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'receiveName'},
  ],
};

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason_AmountTooLarge$json = {
  '1': 'AmountTooLarge',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Address', '10': 'address'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
  ],
};

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason_RejectedInit$json = {
  '1': 'RejectedInit',
  '2': [
    {'1': 'reject_reason', '3': 1, '4': 1, '5': 5, '10': 'rejectReason'},
  ],
};

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason_RejectedReceive$json = {
  '1': 'RejectedReceive',
  '2': [
    {'1': 'reject_reason', '3': 1, '4': 1, '5': 5, '10': 'rejectReason'},
    {'1': 'contract_address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'contractAddress'},
    {'1': 'receive_name', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'receiveName'},
    {'1': 'parameter', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Parameter', '10': 'parameter'},
  ],
};

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason_DuplicateCredIds$json = {
  '1': 'DuplicateCredIds',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '10': 'ids'},
  ],
};

@$core.Deprecated('Use rejectReasonDescriptor instead')
const RejectReason_NonExistentCredIds$json = {
  '1': 'NonExistentCredIds',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '10': 'ids'},
  ],
};

/// Descriptor for `RejectReason`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rejectReasonDescriptor = $convert.base64Decode(
    'CgxSZWplY3RSZWFzb24SOgoNbW9kdWxlX25vdF93ZhgBIAEoCzIULmNvbmNvcmRpdW0udjIuRW'
    '1wdHlIAFILbW9kdWxlTm90V2YSVwoabW9kdWxlX2hhc2hfYWxyZWFkeV9leGlzdHMYAiABKAsy'
    'GC5jb25jb3JkaXVtLnYyLk1vZHVsZVJlZkgAUhdtb2R1bGVIYXNoQWxyZWFkeUV4aXN0cxJbCh'
    'lpbnZhbGlkX2FjY291bnRfcmVmZXJlbmNlGAMgASgLMh0uY29uY29yZGl1bS52Mi5BY2NvdW50'
    'QWRkcmVzc0gAUhdpbnZhbGlkQWNjb3VudFJlZmVyZW5jZRJfChNpbnZhbGlkX2luaXRfbWV0aG'
    '9kGAQgASgLMi0uY29uY29yZGl1bS52Mi5SZWplY3RSZWFzb24uSW52YWxpZEluaXRNZXRob2RI'
    'AFIRaW52YWxpZEluaXRNZXRob2QSaAoWaW52YWxpZF9yZWNlaXZlX21ldGhvZBgFIAEoCzIwLm'
    'NvbmNvcmRpdW0udjIuUmVqZWN0UmVhc29uLkludmFsaWRSZWNlaXZlTWV0aG9kSABSFGludmFs'
    'aWRSZWNlaXZlTWV0aG9kElQKGGludmFsaWRfbW9kdWxlX3JlZmVyZW5jZRgGIAEoCzIYLmNvbm'
    'NvcmRpdW0udjIuTW9kdWxlUmVmSABSFmludmFsaWRNb2R1bGVSZWZlcmVuY2USWgoYaW52YWxp'
    'ZF9jb250cmFjdF9hZGRyZXNzGAcgASgLMh4uY29uY29yZGl1bS52Mi5Db250cmFjdEFkZHJlc3'
    'NIAFIWaW52YWxpZENvbnRyYWN0QWRkcmVzcxI/Cg9ydW50aW1lX2ZhaWx1cmUYCCABKAsyFC5j'
    'b25jb3JkaXVtLnYyLkVtcHR5SABSDnJ1bnRpbWVGYWlsdXJlElYKEGFtb3VudF90b29fbGFyZ2'
    'UYCSABKAsyKi5jb25jb3JkaXVtLnYyLlJlamVjdFJlYXNvbi5BbW91bnRUb29MYXJnZUgAUg5h'
    'bW91bnRUb29MYXJnZRJLChVzZXJpYWxpemF0aW9uX2ZhaWx1cmUYCiABKAsyFC5jb25jb3JkaX'
    'VtLnYyLkVtcHR5SABSFHNlcmlhbGl6YXRpb25GYWlsdXJlEjoKDW91dF9vZl9lbmVyZ3kYCyAB'
    'KAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SABSC291dE9mRW5lcmd5Ek8KDXJlamVjdGVkX2luaX'
    'QYDCABKAsyKC5jb25jb3JkaXVtLnYyLlJlamVjdFJlYXNvbi5SZWplY3RlZEluaXRIAFIMcmVq'
    'ZWN0ZWRJbml0ElgKEHJlamVjdGVkX3JlY2VpdmUYDSABKAsyKy5jb25jb3JkaXVtLnYyLlJlam'
    'VjdFJlYXNvbi5SZWplY3RlZFJlY2VpdmVIAFIPcmVqZWN0ZWRSZWNlaXZlEjsKDWludmFsaWRf'
    'cHJvb2YYDiABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SABSDGludmFsaWRQcm9vZhJACg9hbH'
    'JlYWR5X2FfYmFrZXIYDyABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRIAFINYWxyZWFkeUFC'
    'YWtlchI/Cgtub3RfYV9iYWtlchgQIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3'
    'NIAFIJbm90QUJha2VyEmYKJGluc3VmZmljaWVudF9iYWxhbmNlX2Zvcl9iYWtlcl9zdGFrZRgR'
    'IAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIgaW5zdWZmaWNpZW50QmFsYW5jZUZvckJha2'
    'VyU3Rha2USbQooc3Rha2VfdW5kZXJfbWluaW11bV90aHJlc2hvbGRfZm9yX2Jha2luZxgSIAEo'
    'CzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIjc3Rha2VVbmRlck1pbmltdW1UaHJlc2hvbGRGb3'
    'JCYWtpbmcSQgoRYmFrZXJfaW5fY29vbGRvd24YEyABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5'
    'SABSD2Jha2VySW5Db29sZG93bhJmChlkdXBsaWNhdGVfYWdncmVnYXRpb25fa2V5GBQgASgLMi'
    'guY29uY29yZGl1bS52Mi5CYWtlckFnZ3JlZ2F0aW9uVmVyaWZ5S2V5SABSF2R1cGxpY2F0ZUFn'
    'Z3JlZ2F0aW9uS2V5ElMKGm5vbl9leGlzdGVudF9jcmVkZW50aWFsX2lkGBUgASgLMhQuY29uY2'
    '9yZGl1bS52Mi5FbXB0eUgAUhdub25FeGlzdGVudENyZWRlbnRpYWxJZBJOChhrZXlfaW5kZXhf'
    'YWxyZWFkeV9pbl91c2UYFiABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SABSFGtleUluZGV4QW'
    'xyZWFkeUluVXNlElIKGWludmFsaWRfYWNjb3VudF90aHJlc2hvbGQYFyABKAsyFC5jb25jb3Jk'
    'aXVtLnYyLkVtcHR5SABSF2ludmFsaWRBY2NvdW50VGhyZXNob2xkEmgKJWludmFsaWRfY3JlZG'
    'VudGlhbF9rZXlfc2lnbl90aHJlc2hvbGQYGCABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SABS'
    'IWludmFsaWRDcmVkZW50aWFsS2V5U2lnblRocmVzaG9sZBJsCidpbnZhbGlkX2VuY3J5cHRlZF'
    '9hbW91bnRfdHJhbnNmZXJfcHJvb2YYGSABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SABSI2lu'
    'dmFsaWRFbmNyeXB0ZWRBbW91bnRUcmFuc2ZlclByb29mEl4KIGludmFsaWRfdHJhbnNmZXJfdG'
    '9fcHVibGljX3Byb29mGBogASgLMhQuY29uY29yZGl1bS52Mi5FbXB0eUgAUhxpbnZhbGlkVHJh'
    'bnNmZXJUb1B1YmxpY1Byb29mEmQKHmVuY3J5cHRlZF9hbW91bnRfc2VsZl90cmFuc2ZlchgbIA'
    'EoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NIAFIbZW5jcnlwdGVkQW1vdW50U2Vs'
    'ZlRyYW5zZmVyEmQKI2ludmFsaWRfaW5kZXhfb25fZW5jcnlwdGVkX3RyYW5zZmVyGBwgASgLMh'
    'QuY29uY29yZGl1bS52Mi5FbXB0eUgAUh9pbnZhbGlkSW5kZXhPbkVuY3J5cHRlZFRyYW5zZmVy'
    'EkkKFHplcm9fc2NoZWR1bGVkQW1vdW50GB0gASgLMhQuY29uY29yZGl1bS52Mi5FbXB0eUgAUh'
    'N6ZXJvU2NoZWR1bGVkQW1vdW50Ek4KF25vbl9pbmNyZWFzaW5nX3NjaGVkdWxlGB4gASgLMhQu'
    'Y29uY29yZGl1bS52Mi5FbXB0eUgAUhVub25JbmNyZWFzaW5nU2NoZWR1bGUSXQofZmlyc3Rfc2'
    'NoZWR1bGVkX3JlbGVhc2VfZXhwaXJlZBgfIAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIc'
    'Zmlyc3RTY2hlZHVsZWRSZWxlYXNlRXhwaXJlZBJXChdzY2hlZHVsZWRfc2VsZl90cmFuc2Zlch'
    'ggIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NIAFIVc2NoZWR1bGVkU2VsZlRy'
    'YW5zZmVyEkcKE2ludmFsaWRfY3JlZGVudGlhbHMYISABKAsyFC5jb25jb3JkaXVtLnYyLkVtcH'
    'R5SABSEmludmFsaWRDcmVkZW50aWFscxJcChJkdXBsaWNhdGVfY3JlZF9pZHMYIiABKAsyLC5j'
    'b25jb3JkaXVtLnYyLlJlamVjdFJlYXNvbi5EdXBsaWNhdGVDcmVkSWRzSABSEGR1cGxpY2F0ZU'
    'NyZWRJZHMSYwoVbm9uX2V4aXN0ZW50X2NyZWRfaWRzGCMgASgLMi4uY29uY29yZGl1bS52Mi5S'
    'ZWplY3RSZWFzb24uTm9uRXhpc3RlbnRDcmVkSWRzSABSEm5vbkV4aXN0ZW50Q3JlZElkcxJOCh'
    'dyZW1vdmVfZmlyc3RfY3JlZGVudGlhbBgkIAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIV'
    'cmVtb3ZlRmlyc3RDcmVkZW50aWFsEloKHmNyZWRlbnRpYWxfaG9sZGVyX2RpZF9ub3Rfc2lnbh'
    'glIAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIaY3JlZGVudGlhbEhvbGRlckRpZE5vdFNp'
    'Z24SXwogbm90X2FsbG93ZWRfbXVsdGlwbGVfY3JlZGVudGlhbHMYJiABKAsyFC5jb25jb3JkaX'
    'VtLnYyLkVtcHR5SABSHW5vdEFsbG93ZWRNdWx0aXBsZUNyZWRlbnRpYWxzEl4KIG5vdF9hbGxv'
    'd2VkX3RvX3JlY2VpdmVfZW5jcnlwdGVkGCcgASgLMhQuY29uY29yZGl1bS52Mi5FbXB0eUgAUh'
    'xub3RBbGxvd2VkVG9SZWNlaXZlRW5jcnlwdGVkElwKH25vdF9hbGxvd2VkX3RvX2hhbmRsZV9l'
    'bmNyeXB0ZWQYKCABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SABSG25vdEFsbG93ZWRUb0hhbm'
    'RsZUVuY3J5cHRlZBJXChxtaXNzaW5nX2Jha2VyX2FkZF9wYXJhbWV0ZXJzGCkgASgLMhQuY29u'
    'Y29yZGl1bS52Mi5FbXB0eUgAUhltaXNzaW5nQmFrZXJBZGRQYXJhbWV0ZXJzEnMKK2ZpbmFsaX'
    'phdGlvbl9yZXdhcmRfY29tbWlzc2lvbl9ub3RfaW5fcmFuZ2UYKiABKAsyFC5jb25jb3JkaXVt'
    'LnYyLkVtcHR5SABSJmZpbmFsaXphdGlvblJld2FyZENvbW1pc3Npb25Ob3RJblJhbmdlEmcKJW'
    'Jha2luZ19yZXdhcmRfY29tbWlzc2lvbl9ub3RfaW5fcmFuZ2UYKyABKAsyFC5jb25jb3JkaXVt'
    'LnYyLkVtcHR5SABSIGJha2luZ1Jld2FyZENvbW1pc3Npb25Ob3RJblJhbmdlEmsKJ3RyYW5zYW'
    'N0aW9uX2ZlZV9jb21taXNzaW9uX25vdF9pbl9yYW5nZRgsIAEoCzIULmNvbmNvcmRpdW0udjIu'
    'RW1wdHlIAFIidHJhbnNhY3Rpb25GZWVDb21taXNzaW9uTm90SW5SYW5nZRJGChNhbHJlYWR5X2'
    'FfZGVsZWdhdG9yGC0gASgLMhQuY29uY29yZGl1bS52Mi5FbXB0eUgAUhFhbHJlYWR5QURlbGVn'
    'YXRvchJwCilpbnN1ZmZpY2llbnRfYmFsYW5jZV9mb3JfZGVsZWdhdGlvbl9zdGFrZRguIAEoCz'
    'IULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIlaW5zdWZmaWNpZW50QmFsYW5jZUZvckRlbGVnYXRp'
    'b25TdGFrZRJhCiFtaXNzaW5nX2RlbGVnYXRpb25fYWRkX3BhcmFtZXRlcnMYLyABKAsyFC5jb2'
    '5jb3JkaXVtLnYyLkVtcHR5SABSHm1pc3NpbmdEZWxlZ2F0aW9uQWRkUGFyYW1ldGVycxJaCh1p'
    'bnN1ZmZpY2llbnRfZGVsZWdhdGlvbl9zdGFrZRgwIAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdH'
    'lIAFIbaW5zdWZmaWNpZW50RGVsZWdhdGlvblN0YWtlEkoKFWRlbGVnYXRvcl9pbl9jb29sZG93'
    'bhgxIAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFITZGVsZWdhdG9ySW5Db29sZG93bhJHCg'
    '9ub3RfYV9kZWxlZ2F0b3IYMiABKAsyHS5jb25jb3JkaXVtLnYyLkFjY291bnRBZGRyZXNzSABS'
    'DW5vdEFEZWxlZ2F0b3ISWgodZGVsZWdhdGlvbl90YXJnZXRfbm90X2FfYmFrZXIYMyABKAsyFi'
    '5jb25jb3JkaXVtLnYyLkJha2VySWRIAFIZZGVsZWdhdGlvblRhcmdldE5vdEFCYWtlchJnCiVz'
    'dGFrZV9vdmVyX21heGltdW1fdGhyZXNob2xkX2Zvcl9wb29sGDQgASgLMhQuY29uY29yZGl1bS'
    '52Mi5FbXB0eUgAUiBzdGFrZU92ZXJNYXhpbXVtVGhyZXNob2xkRm9yUG9vbBJeCiBwb29sX3dv'
    'dWxkX2JlY29tZV9vdmVyX2RlbGVnYXRlZBg1IAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAF'
    'IccG9vbFdvdWxkQmVjb21lT3ZlckRlbGVnYXRlZBI3Cgtwb29sX2Nsb3NlZBg2IAEoCzIULmNv'
    'bmNvcmRpdW0udjIuRW1wdHlIAFIKcG9vbENsb3NlZBqCAQoRSW52YWxpZEluaXRNZXRob2QSNw'
    'oKbW9kdWxlX3JlZhgBIAEoCzIYLmNvbmNvcmRpdW0udjIuTW9kdWxlUmVmUgltb2R1bGVSZWYS'
    'NAoJaW5pdF9uYW1lGAIgASgLMhcuY29uY29yZGl1bS52Mi5Jbml0TmFtZVIIaW5pdE5hbWUajg'
    'EKFEludmFsaWRSZWNlaXZlTWV0aG9kEjcKCm1vZHVsZV9yZWYYASABKAsyGC5jb25jb3JkaXVt'
    'LnYyLk1vZHVsZVJlZlIJbW9kdWxlUmVmEj0KDHJlY2VpdmVfbmFtZRgCIAEoCzIaLmNvbmNvcm'
    'RpdW0udjIuUmVjZWl2ZU5hbWVSC3JlY2VpdmVOYW1lGnEKDkFtb3VudFRvb0xhcmdlEjAKB2Fk'
    'ZHJlc3MYASABKAsyFi5jb25jb3JkaXVtLnYyLkFkZHJlc3NSB2FkZHJlc3MSLQoGYW1vdW50GA'
    'IgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSBmFtb3VudBozCgxSZWplY3RlZEluaXQSIwoN'
    'cmVqZWN0X3JlYXNvbhgBIAEoBVIMcmVqZWN0UmVhc29uGvgBCg9SZWplY3RlZFJlY2VpdmUSIw'
    'oNcmVqZWN0X3JlYXNvbhgBIAEoBVIMcmVqZWN0UmVhc29uEkkKEGNvbnRyYWN0X2FkZHJlc3MY'
    'AiABKAsyHi5jb25jb3JkaXVtLnYyLkNvbnRyYWN0QWRkcmVzc1IPY29udHJhY3RBZGRyZXNzEj'
    '0KDHJlY2VpdmVfbmFtZRgDIAEoCzIaLmNvbmNvcmRpdW0udjIuUmVjZWl2ZU5hbWVSC3JlY2Vp'
    'dmVOYW1lEjYKCXBhcmFtZXRlchgEIAEoCzIYLmNvbmNvcmRpdW0udjIuUGFyYW1ldGVyUglwYX'
    'JhbWV0ZXIaTQoQRHVwbGljYXRlQ3JlZElkcxI5CgNpZHMYASADKAsyJy5jb25jb3JkaXVtLnYy'
    'LkNyZWRlbnRpYWxSZWdpc3RyYXRpb25JZFIDaWRzGk8KEk5vbkV4aXN0ZW50Q3JlZElkcxI5Cg'
    'NpZHMYASADKAsyJy5jb25jb3JkaXVtLnYyLkNyZWRlbnRpYWxSZWdpc3RyYXRpb25JZFIDaWRz'
    'QggKBnJlYXNvbg==');

@$core.Deprecated('Use contractInitializedEventDescriptor instead')
const ContractInitializedEvent$json = {
  '1': 'ContractInitializedEvent',
  '2': [
    {'1': 'contract_version', '3': 1, '4': 1, '5': 14, '6': '.concordium.v2.ContractVersion', '10': 'contractVersion'},
    {'1': 'origin_ref', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'originRef'},
    {'1': 'address', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
    {'1': 'amount', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'init_name', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.InitName', '10': 'initName'},
    {'1': 'events', '3': 6, '4': 3, '5': 11, '6': '.concordium.v2.ContractEvent', '10': 'events'},
  ],
};

/// Descriptor for `ContractInitializedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contractInitializedEventDescriptor = $convert.base64Decode(
    'ChhDb250cmFjdEluaXRpYWxpemVkRXZlbnQSSQoQY29udHJhY3RfdmVyc2lvbhgBIAEoDjIeLm'
    'NvbmNvcmRpdW0udjIuQ29udHJhY3RWZXJzaW9uUg9jb250cmFjdFZlcnNpb24SNwoKb3JpZ2lu'
    'X3JlZhgCIAEoCzIYLmNvbmNvcmRpdW0udjIuTW9kdWxlUmVmUglvcmlnaW5SZWYSOAoHYWRkcm'
    'VzcxgDIAEoCzIeLmNvbmNvcmRpdW0udjIuQ29udHJhY3RBZGRyZXNzUgdhZGRyZXNzEi0KBmFt'
    'b3VudBgEIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UgZhbW91bnQSNAoJaW5pdF9uYW1lGA'
    'UgASgLMhcuY29uY29yZGl1bS52Mi5Jbml0TmFtZVIIaW5pdE5hbWUSNAoGZXZlbnRzGAYgAygL'
    'MhwuY29uY29yZGl1bS52Mi5Db250cmFjdEV2ZW50UgZldmVudHM=');

@$core.Deprecated('Use contractEventDescriptor instead')
const ContractEvent$json = {
  '1': 'ContractEvent',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `ContractEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contractEventDescriptor = $convert.base64Decode(
    'Cg1Db250cmFjdEV2ZW50EhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use instanceUpdatedEventDescriptor instead')
const InstanceUpdatedEvent$json = {
  '1': 'InstanceUpdatedEvent',
  '2': [
    {'1': 'contract_version', '3': 1, '4': 1, '5': 14, '6': '.concordium.v2.ContractVersion', '10': 'contractVersion'},
    {'1': 'address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
    {'1': 'instigator', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Address', '10': 'instigator'},
    {'1': 'amount', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'parameter', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Parameter', '10': 'parameter'},
    {'1': 'receive_name', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'receiveName'},
    {'1': 'events', '3': 7, '4': 3, '5': 11, '6': '.concordium.v2.ContractEvent', '10': 'events'},
  ],
};

/// Descriptor for `InstanceUpdatedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instanceUpdatedEventDescriptor = $convert.base64Decode(
    'ChRJbnN0YW5jZVVwZGF0ZWRFdmVudBJJChBjb250cmFjdF92ZXJzaW9uGAEgASgOMh4uY29uY2'
    '9yZGl1bS52Mi5Db250cmFjdFZlcnNpb25SD2NvbnRyYWN0VmVyc2lvbhI4CgdhZGRyZXNzGAIg'
    'ASgLMh4uY29uY29yZGl1bS52Mi5Db250cmFjdEFkZHJlc3NSB2FkZHJlc3MSNgoKaW5zdGlnYX'
    'RvchgDIAEoCzIWLmNvbmNvcmRpdW0udjIuQWRkcmVzc1IKaW5zdGlnYXRvchItCgZhbW91bnQY'
    'BCABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIGYW1vdW50EjYKCXBhcmFtZXRlchgFIAEoCz'
    'IYLmNvbmNvcmRpdW0udjIuUGFyYW1ldGVyUglwYXJhbWV0ZXISPQoMcmVjZWl2ZV9uYW1lGAYg'
    'ASgLMhouY29uY29yZGl1bS52Mi5SZWNlaXZlTmFtZVILcmVjZWl2ZU5hbWUSNAoGZXZlbnRzGA'
    'cgAygLMhwuY29uY29yZGl1bS52Mi5Db250cmFjdEV2ZW50UgZldmVudHM=');

@$core.Deprecated('Use contractTraceElementDescriptor instead')
const ContractTraceElement$json = {
  '1': 'ContractTraceElement',
  '2': [
    {'1': 'updated', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.InstanceUpdatedEvent', '9': 0, '10': 'updated'},
    {'1': 'transferred', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractTraceElement.Transferred', '9': 0, '10': 'transferred'},
    {'1': 'interrupted', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ContractTraceElement.Interrupted', '9': 0, '10': 'interrupted'},
    {'1': 'resumed', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.ContractTraceElement.Resumed', '9': 0, '10': 'resumed'},
    {'1': 'upgraded', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.ContractTraceElement.Upgraded', '9': 0, '10': 'upgraded'},
  ],
  '3': [ContractTraceElement_Transferred$json, ContractTraceElement_Interrupted$json, ContractTraceElement_Resumed$json, ContractTraceElement_Upgraded$json],
  '8': [
    {'1': 'element'},
  ],
};

@$core.Deprecated('Use contractTraceElementDescriptor instead')
const ContractTraceElement_Transferred$json = {
  '1': 'Transferred',
  '2': [
    {'1': 'sender', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'sender'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'receiver', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'receiver'},
  ],
};

@$core.Deprecated('Use contractTraceElementDescriptor instead')
const ContractTraceElement_Interrupted$json = {
  '1': 'Interrupted',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
    {'1': 'events', '3': 2, '4': 3, '5': 11, '6': '.concordium.v2.ContractEvent', '10': 'events'},
  ],
};

@$core.Deprecated('Use contractTraceElementDescriptor instead')
const ContractTraceElement_Resumed$json = {
  '1': 'Resumed',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

@$core.Deprecated('Use contractTraceElementDescriptor instead')
const ContractTraceElement_Upgraded$json = {
  '1': 'Upgraded',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
    {'1': 'from', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'from'},
    {'1': 'to', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'to'},
  ],
};

/// Descriptor for `ContractTraceElement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contractTraceElementDescriptor = $convert.base64Decode(
    'ChRDb250cmFjdFRyYWNlRWxlbWVudBI/Cgd1cGRhdGVkGAEgASgLMiMuY29uY29yZGl1bS52Mi'
    '5JbnN0YW5jZVVwZGF0ZWRFdmVudEgAUgd1cGRhdGVkElMKC3RyYW5zZmVycmVkGAIgASgLMi8u'
    'Y29uY29yZGl1bS52Mi5Db250cmFjdFRyYWNlRWxlbWVudC5UcmFuc2ZlcnJlZEgAUgt0cmFuc2'
    'ZlcnJlZBJTCgtpbnRlcnJ1cHRlZBgDIAEoCzIvLmNvbmNvcmRpdW0udjIuQ29udHJhY3RUcmFj'
    'ZUVsZW1lbnQuSW50ZXJydXB0ZWRIAFILaW50ZXJydXB0ZWQSRwoHcmVzdW1lZBgEIAEoCzIrLm'
    'NvbmNvcmRpdW0udjIuQ29udHJhY3RUcmFjZUVsZW1lbnQuUmVzdW1lZEgAUgdyZXN1bWVkEkoK'
    'CHVwZ3JhZGVkGAUgASgLMiwuY29uY29yZGl1bS52Mi5Db250cmFjdFRyYWNlRWxlbWVudC5VcG'
    'dyYWRlZEgAUgh1cGdyYWRlZBqvAQoLVHJhbnNmZXJyZWQSNgoGc2VuZGVyGAEgASgLMh4uY29u'
    'Y29yZGl1bS52Mi5Db250cmFjdEFkZHJlc3NSBnNlbmRlchItCgZhbW91bnQYAiABKAsyFS5jb2'
    '5jb3JkaXVtLnYyLkFtb3VudFIGYW1vdW50EjkKCHJlY2VpdmVyGAMgASgLMh0uY29uY29yZGl1'
    'bS52Mi5BY2NvdW50QWRkcmVzc1IIcmVjZWl2ZXIafQoLSW50ZXJydXB0ZWQSOAoHYWRkcmVzcx'
    'gBIAEoCzIeLmNvbmNvcmRpdW0udjIuQ29udHJhY3RBZGRyZXNzUgdhZGRyZXNzEjQKBmV2ZW50'
    'cxgCIAMoCzIcLmNvbmNvcmRpdW0udjIuQ29udHJhY3RFdmVudFIGZXZlbnRzGl0KB1Jlc3VtZW'
    'QSOAoHYWRkcmVzcxgBIAEoCzIeLmNvbmNvcmRpdW0udjIuQ29udHJhY3RBZGRyZXNzUgdhZGRy'
    'ZXNzEhgKB3N1Y2Nlc3MYAiABKAhSB3N1Y2Nlc3ManAEKCFVwZ3JhZGVkEjgKB2FkZHJlc3MYAS'
    'ABKAsyHi5jb25jb3JkaXVtLnYyLkNvbnRyYWN0QWRkcmVzc1IHYWRkcmVzcxIsCgRmcm9tGAIg'
    'ASgLMhguY29uY29yZGl1bS52Mi5Nb2R1bGVSZWZSBGZyb20SKAoCdG8YAyABKAsyGC5jb25jb3'
    'JkaXVtLnYyLk1vZHVsZVJlZlICdG9CCQoHZWxlbWVudA==');

@$core.Deprecated('Use bakerKeysEventDescriptor instead')
const BakerKeysEvent$json = {
  '1': 'BakerKeysEvent',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'account', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'sign_key', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BakerSignatureVerifyKey', '10': 'signKey'},
    {'1': 'election_key', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.BakerElectionVerifyKey', '10': 'electionKey'},
    {'1': 'aggregation_key', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.BakerAggregationVerifyKey', '10': 'aggregationKey'},
  ],
};

/// Descriptor for `BakerKeysEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerKeysEventDescriptor = $convert.base64Decode(
    'Cg5CYWtlcktleXNFdmVudBIxCghiYWtlcl9pZBgBIAEoCzIWLmNvbmNvcmRpdW0udjIuQmFrZX'
    'JJZFIHYmFrZXJJZBI3CgdhY2NvdW50GAIgASgLMh0uY29uY29yZGl1bS52Mi5BY2NvdW50QWRk'
    'cmVzc1IHYWNjb3VudBJBCghzaWduX2tleRgDIAEoCzImLmNvbmNvcmRpdW0udjIuQmFrZXJTaW'
    'duYXR1cmVWZXJpZnlLZXlSB3NpZ25LZXkSSAoMZWxlY3Rpb25fa2V5GAQgASgLMiUuY29uY29y'
    'ZGl1bS52Mi5CYWtlckVsZWN0aW9uVmVyaWZ5S2V5UgtlbGVjdGlvbktleRJRCg9hZ2dyZWdhdG'
    'lvbl9rZXkYBSABKAsyKC5jb25jb3JkaXVtLnYyLkJha2VyQWdncmVnYXRpb25WZXJpZnlLZXlS'
    'DmFnZ3JlZ2F0aW9uS2V5');

@$core.Deprecated('Use memoDescriptor instead')
const Memo$json = {
  '1': 'Memo',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Memo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memoDescriptor = $convert.base64Decode(
    'CgRNZW1vEhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use bakerStakeUpdatedDataDescriptor instead')
const BakerStakeUpdatedData$json = {
  '1': 'BakerStakeUpdatedData',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'new_stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newStake'},
    {'1': 'increased', '3': 3, '4': 1, '5': 8, '10': 'increased'},
  ],
};

/// Descriptor for `BakerStakeUpdatedData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerStakeUpdatedDataDescriptor = $convert.base64Decode(
    'ChVCYWtlclN0YWtlVXBkYXRlZERhdGESMQoIYmFrZXJfaWQYASABKAsyFi5jb25jb3JkaXVtLn'
    'YyLkJha2VySWRSB2Jha2VySWQSMgoJbmV3X3N0YWtlGAIgASgLMhUuY29uY29yZGl1bS52Mi5B'
    'bW91bnRSCG5ld1N0YWtlEhwKCWluY3JlYXNlZBgDIAEoCFIJaW5jcmVhc2Vk');

@$core.Deprecated('Use encryptedAmountRemovedEventDescriptor instead')
const EncryptedAmountRemovedEvent$json = {
  '1': 'EncryptedAmountRemovedEvent',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'new_amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmount', '10': 'newAmount'},
    {'1': 'input_amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmount', '10': 'inputAmount'},
    {'1': 'up_to_index', '3': 4, '4': 1, '5': 4, '10': 'upToIndex'},
  ],
};

/// Descriptor for `EncryptedAmountRemovedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encryptedAmountRemovedEventDescriptor = $convert.base64Decode(
    'ChtFbmNyeXB0ZWRBbW91bnRSZW1vdmVkRXZlbnQSNwoHYWNjb3VudBgBIAEoCzIdLmNvbmNvcm'
    'RpdW0udjIuQWNjb3VudEFkZHJlc3NSB2FjY291bnQSPQoKbmV3X2Ftb3VudBgCIAEoCzIeLmNv'
    'bmNvcmRpdW0udjIuRW5jcnlwdGVkQW1vdW50UgluZXdBbW91bnQSQQoMaW5wdXRfYW1vdW50GA'
    'MgASgLMh4uY29uY29yZGl1bS52Mi5FbmNyeXB0ZWRBbW91bnRSC2lucHV0QW1vdW50Eh4KC3Vw'
    'X3RvX2luZGV4GAQgASgEUgl1cFRvSW5kZXg=');

@$core.Deprecated('Use newEncryptedAmountEventDescriptor instead')
const NewEncryptedAmountEvent$json = {
  '1': 'NewEncryptedAmountEvent',
  '2': [
    {'1': 'receiver', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'receiver'},
    {'1': 'new_index', '3': 2, '4': 1, '5': 4, '10': 'newIndex'},
    {'1': 'encrypted_amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmount', '10': 'encryptedAmount'},
  ],
};

/// Descriptor for `NewEncryptedAmountEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newEncryptedAmountEventDescriptor = $convert.base64Decode(
    'ChdOZXdFbmNyeXB0ZWRBbW91bnRFdmVudBI5CghyZWNlaXZlchgBIAEoCzIdLmNvbmNvcmRpdW'
    '0udjIuQWNjb3VudEFkZHJlc3NSCHJlY2VpdmVyEhsKCW5ld19pbmRleBgCIAEoBFIIbmV3SW5k'
    'ZXgSSQoQZW5jcnlwdGVkX2Ftb3VudBgDIAEoCzIeLmNvbmNvcmRpdW0udjIuRW5jcnlwdGVkQW'
    '1vdW50Ug9lbmNyeXB0ZWRBbW91bnQ=');

@$core.Deprecated('Use encryptedSelfAmountAddedEventDescriptor instead')
const EncryptedSelfAmountAddedEvent$json = {
  '1': 'EncryptedSelfAmountAddedEvent',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'new_amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmount', '10': 'newAmount'},
    {'1': 'amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
  ],
};

/// Descriptor for `EncryptedSelfAmountAddedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encryptedSelfAmountAddedEventDescriptor = $convert.base64Decode(
    'Ch1FbmNyeXB0ZWRTZWxmQW1vdW50QWRkZWRFdmVudBI3CgdhY2NvdW50GAEgASgLMh0uY29uY2'
    '9yZGl1bS52Mi5BY2NvdW50QWRkcmVzc1IHYWNjb3VudBI9CgpuZXdfYW1vdW50GAIgASgLMh4u'
    'Y29uY29yZGl1bS52Mi5FbmNyeXB0ZWRBbW91bnRSCW5ld0Ftb3VudBItCgZhbW91bnQYAyABKA'
    'syFS5jb25jb3JkaXVtLnYyLkFtb3VudFIGYW1vdW50');

@$core.Deprecated('Use registeredDataDescriptor instead')
const RegisteredData$json = {
  '1': 'RegisteredData',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `RegisteredData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registeredDataDescriptor = $convert.base64Decode(
    'Cg5SZWdpc3RlcmVkRGF0YRIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent$json = {
  '1': 'BakerEvent',
  '2': [
    {'1': 'baker_added', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerAdded', '9': 0, '10': 'bakerAdded'},
    {'1': 'baker_removed', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '9': 0, '10': 'bakerRemoved'},
    {'1': 'baker_stake_increased', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerStakeIncreased', '9': 0, '10': 'bakerStakeIncreased'},
    {'1': 'baker_stake_decreased', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerStakeDecreased', '9': 0, '10': 'bakerStakeDecreased'},
    {'1': 'baker_restake_earnings_updated', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerRestakeEarningsUpdated', '9': 0, '10': 'bakerRestakeEarningsUpdated'},
    {'1': 'baker_keys_updated', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.BakerKeysEvent', '9': 0, '10': 'bakerKeysUpdated'},
    {'1': 'baker_set_open_status', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerSetOpenStatus', '9': 0, '10': 'bakerSetOpenStatus'},
    {'1': 'baker_set_metadata_url', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerSetMetadataUrl', '9': 0, '10': 'bakerSetMetadataUrl'},
    {'1': 'baker_set_transaction_fee_commission', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerSetTransactionFeeCommission', '9': 0, '10': 'bakerSetTransactionFeeCommission'},
    {'1': 'baker_set_baking_reward_commission', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerSetBakingRewardCommission', '9': 0, '10': 'bakerSetBakingRewardCommission'},
    {'1': 'baker_set_finalization_reward_commission', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerSetFinalizationRewardCommission', '9': 0, '10': 'bakerSetFinalizationRewardCommission'},
  ],
  '3': [BakerEvent_BakerAdded$json, BakerEvent_BakerStakeIncreased$json, BakerEvent_BakerStakeDecreased$json, BakerEvent_BakerRestakeEarningsUpdated$json, BakerEvent_BakerSetOpenStatus$json, BakerEvent_BakerSetMetadataUrl$json, BakerEvent_BakerSetTransactionFeeCommission$json, BakerEvent_BakerSetBakingRewardCommission$json, BakerEvent_BakerSetFinalizationRewardCommission$json],
  '8': [
    {'1': 'event'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerAdded$json = {
  '1': 'BakerAdded',
  '2': [
    {'1': 'keys_event', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerKeysEvent', '10': 'keysEvent'},
    {'1': 'stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'stake'},
    {'1': 'restake_earnings', '3': 3, '4': 1, '5': 8, '10': 'restakeEarnings'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerStakeIncreased$json = {
  '1': 'BakerStakeIncreased',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'new_stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newStake'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerStakeDecreased$json = {
  '1': 'BakerStakeDecreased',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'new_stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newStake'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerRestakeEarningsUpdated$json = {
  '1': 'BakerRestakeEarningsUpdated',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'restake_earnings', '3': 2, '4': 1, '5': 8, '10': 'restakeEarnings'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerSetOpenStatus$json = {
  '1': 'BakerSetOpenStatus',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'open_status', '3': 2, '4': 1, '5': 14, '6': '.concordium.v2.OpenStatus', '10': 'openStatus'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerSetMetadataUrl$json = {
  '1': 'BakerSetMetadataUrl',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerSetTransactionFeeCommission$json = {
  '1': 'BakerSetTransactionFeeCommission',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'transaction_fee_commission', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'transactionFeeCommission'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerSetBakingRewardCommission$json = {
  '1': 'BakerSetBakingRewardCommission',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'baking_reward_commission', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'bakingRewardCommission'},
  ],
};

@$core.Deprecated('Use bakerEventDescriptor instead')
const BakerEvent_BakerSetFinalizationRewardCommission$json = {
  '1': 'BakerSetFinalizationRewardCommission',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'finalization_reward_commission', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'finalizationRewardCommission'},
  ],
};

/// Descriptor for `BakerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerEventDescriptor = $convert.base64Decode(
    'CgpCYWtlckV2ZW50EkcKC2Jha2VyX2FkZGVkGAEgASgLMiQuY29uY29yZGl1bS52Mi5CYWtlck'
    'V2ZW50LkJha2VyQWRkZWRIAFIKYmFrZXJBZGRlZBI9Cg1iYWtlcl9yZW1vdmVkGAIgASgLMhYu'
    'Y29uY29yZGl1bS52Mi5CYWtlcklkSABSDGJha2VyUmVtb3ZlZBJjChViYWtlcl9zdGFrZV9pbm'
    'NyZWFzZWQYAyABKAsyLS5jb25jb3JkaXVtLnYyLkJha2VyRXZlbnQuQmFrZXJTdGFrZUluY3Jl'
    'YXNlZEgAUhNiYWtlclN0YWtlSW5jcmVhc2VkEmMKFWJha2VyX3N0YWtlX2RlY3JlYXNlZBgEIA'
    'EoCzItLmNvbmNvcmRpdW0udjIuQmFrZXJFdmVudC5CYWtlclN0YWtlRGVjcmVhc2VkSABSE2Jh'
    'a2VyU3Rha2VEZWNyZWFzZWQSfAoeYmFrZXJfcmVzdGFrZV9lYXJuaW5nc191cGRhdGVkGAUgAS'
    'gLMjUuY29uY29yZGl1bS52Mi5CYWtlckV2ZW50LkJha2VyUmVzdGFrZUVhcm5pbmdzVXBkYXRl'
    'ZEgAUhtiYWtlclJlc3Rha2VFYXJuaW5nc1VwZGF0ZWQSTQoSYmFrZXJfa2V5c191cGRhdGVkGA'
    'YgASgLMh0uY29uY29yZGl1bS52Mi5CYWtlcktleXNFdmVudEgAUhBiYWtlcktleXNVcGRhdGVk'
    'EmEKFWJha2VyX3NldF9vcGVuX3N0YXR1cxgHIAEoCzIsLmNvbmNvcmRpdW0udjIuQmFrZXJFdm'
    'VudC5CYWtlclNldE9wZW5TdGF0dXNIAFISYmFrZXJTZXRPcGVuU3RhdHVzEmQKFmJha2VyX3Nl'
    'dF9tZXRhZGF0YV91cmwYCCABKAsyLS5jb25jb3JkaXVtLnYyLkJha2VyRXZlbnQuQmFrZXJTZX'
    'RNZXRhZGF0YVVybEgAUhNiYWtlclNldE1ldGFkYXRhVXJsEowBCiRiYWtlcl9zZXRfdHJhbnNh'
    'Y3Rpb25fZmVlX2NvbW1pc3Npb24YCSABKAsyOi5jb25jb3JkaXVtLnYyLkJha2VyRXZlbnQuQm'
    'FrZXJTZXRUcmFuc2FjdGlvbkZlZUNvbW1pc3Npb25IAFIgYmFrZXJTZXRUcmFuc2FjdGlvbkZl'
    'ZUNvbW1pc3Npb24ShgEKImJha2VyX3NldF9iYWtpbmdfcmV3YXJkX2NvbW1pc3Npb24YCiABKA'
    'syOC5jb25jb3JkaXVtLnYyLkJha2VyRXZlbnQuQmFrZXJTZXRCYWtpbmdSZXdhcmRDb21taXNz'
    'aW9uSABSHmJha2VyU2V0QmFraW5nUmV3YXJkQ29tbWlzc2lvbhKYAQooYmFrZXJfc2V0X2Zpbm'
    'FsaXphdGlvbl9yZXdhcmRfY29tbWlzc2lvbhgLIAEoCzI+LmNvbmNvcmRpdW0udjIuQmFrZXJF'
    'dmVudC5CYWtlclNldEZpbmFsaXphdGlvblJld2FyZENvbW1pc3Npb25IAFIkYmFrZXJTZXRGaW'
    '5hbGl6YXRpb25SZXdhcmRDb21taXNzaW9uGqIBCgpCYWtlckFkZGVkEjwKCmtleXNfZXZlbnQY'
    'ASABKAsyHS5jb25jb3JkaXVtLnYyLkJha2VyS2V5c0V2ZW50UglrZXlzRXZlbnQSKwoFc3Rha2'
    'UYAiABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIFc3Rha2USKQoQcmVzdGFrZV9lYXJuaW5n'
    'cxgDIAEoCFIPcmVzdGFrZUVhcm5pbmdzGnwKE0Jha2VyU3Rha2VJbmNyZWFzZWQSMQoIYmFrZX'
    'JfaWQYASABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRSB2Jha2VySWQSMgoJbmV3X3N0YWtl'
    'GAIgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSCG5ld1N0YWtlGnwKE0Jha2VyU3Rha2VEZW'
    'NyZWFzZWQSMQoIYmFrZXJfaWQYASABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRSB2Jha2Vy'
    'SWQSMgoJbmV3X3N0YWtlGAIgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSCG5ld1N0YWtlGn'
    'sKG0Jha2VyUmVzdGFrZUVhcm5pbmdzVXBkYXRlZBIxCghiYWtlcl9pZBgBIAEoCzIWLmNvbmNv'
    'cmRpdW0udjIuQmFrZXJJZFIHYmFrZXJJZBIpChByZXN0YWtlX2Vhcm5pbmdzGAIgASgIUg9yZX'
    'N0YWtlRWFybmluZ3MagwEKEkJha2VyU2V0T3BlblN0YXR1cxIxCghiYWtlcl9pZBgBIAEoCzIW'
    'LmNvbmNvcmRpdW0udjIuQmFrZXJJZFIHYmFrZXJJZBI6CgtvcGVuX3N0YXR1cxgCIAEoDjIZLm'
    'NvbmNvcmRpdW0udjIuT3BlblN0YXR1c1IKb3BlblN0YXR1cxpaChNCYWtlclNldE1ldGFkYXRh'
    'VXJsEjEKCGJha2VyX2lkGAEgASgLMhYuY29uY29yZGl1bS52Mi5CYWtlcklkUgdiYWtlcklkEh'
    'AKA3VybBgCIAEoCVIDdXJsGrIBCiBCYWtlclNldFRyYW5zYWN0aW9uRmVlQ29tbWlzc2lvbhIx'
    'CghiYWtlcl9pZBgBIAEoCzIWLmNvbmNvcmRpdW0udjIuQmFrZXJJZFIHYmFrZXJJZBJbChp0cm'
    'Fuc2FjdGlvbl9mZWVfY29tbWlzc2lvbhgCIAEoCzIdLmNvbmNvcmRpdW0udjIuQW1vdW50RnJh'
    'Y3Rpb25SGHRyYW5zYWN0aW9uRmVlQ29tbWlzc2lvbhqsAQoeQmFrZXJTZXRCYWtpbmdSZXdhcm'
    'RDb21taXNzaW9uEjEKCGJha2VyX2lkGAEgASgLMhYuY29uY29yZGl1bS52Mi5CYWtlcklkUgdi'
    'YWtlcklkElcKGGJha2luZ19yZXdhcmRfY29tbWlzc2lvbhgCIAEoCzIdLmNvbmNvcmRpdW0udj'
    'IuQW1vdW50RnJhY3Rpb25SFmJha2luZ1Jld2FyZENvbW1pc3Npb24avgEKJEJha2VyU2V0Rmlu'
    'YWxpemF0aW9uUmV3YXJkQ29tbWlzc2lvbhIxCghiYWtlcl9pZBgBIAEoCzIWLmNvbmNvcmRpdW'
    '0udjIuQmFrZXJJZFIHYmFrZXJJZBJjCh5maW5hbGl6YXRpb25fcmV3YXJkX2NvbW1pc3Npb24Y'
    'AiABKAsyHS5jb25jb3JkaXVtLnYyLkFtb3VudEZyYWN0aW9uUhxmaW5hbGl6YXRpb25SZXdhcm'
    'RDb21taXNzaW9uQgcKBWV2ZW50');

@$core.Deprecated('Use delegatorIdDescriptor instead')
const DelegatorId$json = {
  '1': 'DelegatorId',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountIndex', '10': 'id'},
  ],
};

/// Descriptor for `DelegatorId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delegatorIdDescriptor = $convert.base64Decode(
    'CgtEZWxlZ2F0b3JJZBIrCgJpZBgBIAEoCzIbLmNvbmNvcmRpdW0udjIuQWNjb3VudEluZGV4Ug'
    'JpZA==');

@$core.Deprecated('Use delegationEventDescriptor instead')
const DelegationEvent$json = {
  '1': 'DelegationEvent',
  '2': [
    {'1': 'delegation_stake_increased', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DelegationEvent.DelegationStakeIncreased', '9': 0, '10': 'delegationStakeIncreased'},
    {'1': 'delegation_stake_decreased', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.DelegationEvent.DelegationStakeDecreased', '9': 0, '10': 'delegationStakeDecreased'},
    {'1': 'delegation_set_restake_earnings', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.DelegationEvent.DelegationSetRestakeEarnings', '9': 0, '10': 'delegationSetRestakeEarnings'},
    {'1': 'delegation_set_delegation_target', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.DelegationEvent.DelegationSetDelegationTarget', '9': 0, '10': 'delegationSetDelegationTarget'},
    {'1': 'delegation_added', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.DelegatorId', '9': 0, '10': 'delegationAdded'},
    {'1': 'delegation_removed', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.DelegatorId', '9': 0, '10': 'delegationRemoved'},
  ],
  '3': [DelegationEvent_DelegationStakeIncreased$json, DelegationEvent_DelegationStakeDecreased$json, DelegationEvent_DelegationSetRestakeEarnings$json, DelegationEvent_DelegationSetDelegationTarget$json],
  '8': [
    {'1': 'event'},
  ],
};

@$core.Deprecated('Use delegationEventDescriptor instead')
const DelegationEvent_DelegationStakeIncreased$json = {
  '1': 'DelegationStakeIncreased',
  '2': [
    {'1': 'delegator_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DelegatorId', '10': 'delegatorId'},
    {'1': 'new_stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newStake'},
  ],
};

@$core.Deprecated('Use delegationEventDescriptor instead')
const DelegationEvent_DelegationStakeDecreased$json = {
  '1': 'DelegationStakeDecreased',
  '2': [
    {'1': 'delegator_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DelegatorId', '10': 'delegatorId'},
    {'1': 'new_stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newStake'},
  ],
};

@$core.Deprecated('Use delegationEventDescriptor instead')
const DelegationEvent_DelegationSetRestakeEarnings$json = {
  '1': 'DelegationSetRestakeEarnings',
  '2': [
    {'1': 'delegator_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DelegatorId', '10': 'delegatorId'},
    {'1': 'restake_earnings', '3': 2, '4': 1, '5': 8, '10': 'restakeEarnings'},
  ],
};

@$core.Deprecated('Use delegationEventDescriptor instead')
const DelegationEvent_DelegationSetDelegationTarget$json = {
  '1': 'DelegationSetDelegationTarget',
  '2': [
    {'1': 'delegator_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DelegatorId', '10': 'delegatorId'},
    {'1': 'delegation_target', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.DelegationTarget', '10': 'delegationTarget'},
  ],
};

/// Descriptor for `DelegationEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delegationEventDescriptor = $convert.base64Decode(
    'Cg9EZWxlZ2F0aW9uRXZlbnQSdwoaZGVsZWdhdGlvbl9zdGFrZV9pbmNyZWFzZWQYASABKAsyNy'
    '5jb25jb3JkaXVtLnYyLkRlbGVnYXRpb25FdmVudC5EZWxlZ2F0aW9uU3Rha2VJbmNyZWFzZWRI'
    'AFIYZGVsZWdhdGlvblN0YWtlSW5jcmVhc2VkEncKGmRlbGVnYXRpb25fc3Rha2VfZGVjcmVhc2'
    'VkGAIgASgLMjcuY29uY29yZGl1bS52Mi5EZWxlZ2F0aW9uRXZlbnQuRGVsZWdhdGlvblN0YWtl'
    'RGVjcmVhc2VkSABSGGRlbGVnYXRpb25TdGFrZURlY3JlYXNlZBKEAQofZGVsZWdhdGlvbl9zZX'
    'RfcmVzdGFrZV9lYXJuaW5ncxgDIAEoCzI7LmNvbmNvcmRpdW0udjIuRGVsZWdhdGlvbkV2ZW50'
    'LkRlbGVnYXRpb25TZXRSZXN0YWtlRWFybmluZ3NIAFIcZGVsZWdhdGlvblNldFJlc3Rha2VFYX'
    'JuaW5ncxKHAQogZGVsZWdhdGlvbl9zZXRfZGVsZWdhdGlvbl90YXJnZXQYBCABKAsyPC5jb25j'
    'b3JkaXVtLnYyLkRlbGVnYXRpb25FdmVudC5EZWxlZ2F0aW9uU2V0RGVsZWdhdGlvblRhcmdldE'
    'gAUh1kZWxlZ2F0aW9uU2V0RGVsZWdhdGlvblRhcmdldBJHChBkZWxlZ2F0aW9uX2FkZGVkGAUg'
    'ASgLMhouY29uY29yZGl1bS52Mi5EZWxlZ2F0b3JJZEgAUg9kZWxlZ2F0aW9uQWRkZWQSSwoSZG'
    'VsZWdhdGlvbl9yZW1vdmVkGAYgASgLMhouY29uY29yZGl1bS52Mi5EZWxlZ2F0b3JJZEgAUhFk'
    'ZWxlZ2F0aW9uUmVtb3ZlZBqNAQoYRGVsZWdhdGlvblN0YWtlSW5jcmVhc2VkEj0KDGRlbGVnYX'
    'Rvcl9pZBgBIAEoCzIaLmNvbmNvcmRpdW0udjIuRGVsZWdhdG9ySWRSC2RlbGVnYXRvcklkEjIK'
    'CW5ld19zdGFrZRgCIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UghuZXdTdGFrZRqNAQoYRG'
    'VsZWdhdGlvblN0YWtlRGVjcmVhc2VkEj0KDGRlbGVnYXRvcl9pZBgBIAEoCzIaLmNvbmNvcmRp'
    'dW0udjIuRGVsZWdhdG9ySWRSC2RlbGVnYXRvcklkEjIKCW5ld19zdGFrZRgCIAEoCzIVLmNvbm'
    'NvcmRpdW0udjIuQW1vdW50UghuZXdTdGFrZRqIAQocRGVsZWdhdGlvblNldFJlc3Rha2VFYXJu'
    'aW5ncxI9CgxkZWxlZ2F0b3JfaWQYASABKAsyGi5jb25jb3JkaXVtLnYyLkRlbGVnYXRvcklkUg'
    'tkZWxlZ2F0b3JJZBIpChByZXN0YWtlX2Vhcm5pbmdzGAIgASgIUg9yZXN0YWtlRWFybmluZ3Ma'
    'rAEKHURlbGVnYXRpb25TZXREZWxlZ2F0aW9uVGFyZ2V0Ej0KDGRlbGVnYXRvcl9pZBgBIAEoCz'
    'IaLmNvbmNvcmRpdW0udjIuRGVsZWdhdG9ySWRSC2RlbGVnYXRvcklkEkwKEWRlbGVnYXRpb25f'
    'dGFyZ2V0GAIgASgLMh8uY29uY29yZGl1bS52Mi5EZWxlZ2F0aW9uVGFyZ2V0UhBkZWxlZ2F0aW'
    '9uVGFyZ2V0QgcKBWV2ZW50');

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects$json = {
  '1': 'AccountTransactionEffects',
  '2': [
    {'1': 'none', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.None', '9': 0, '10': 'none'},
    {'1': 'module_deployed', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '9': 0, '10': 'moduleDeployed'},
    {'1': 'contract_initialized', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ContractInitializedEvent', '9': 0, '10': 'contractInitialized'},
    {'1': 'contract_update_issued', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.ContractUpdateIssued', '9': 0, '10': 'contractUpdateIssued'},
    {'1': 'account_transfer', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.AccountTransfer', '9': 0, '10': 'accountTransfer'},
    {'1': 'baker_added', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerAdded', '9': 0, '10': 'bakerAdded'},
    {'1': 'baker_removed', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '9': 0, '10': 'bakerRemoved'},
    {'1': 'baker_stake_updated', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.BakerStakeUpdated', '9': 0, '10': 'bakerStakeUpdated'},
    {'1': 'baker_restake_earnings_updated', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.BakerEvent.BakerRestakeEarningsUpdated', '9': 0, '10': 'bakerRestakeEarningsUpdated'},
    {'1': 'baker_keys_updated', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.BakerKeysEvent', '9': 0, '10': 'bakerKeysUpdated'},
    {'1': 'encrypted_amount_transferred', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.EncryptedAmountTransferred', '9': 0, '10': 'encryptedAmountTransferred'},
    {'1': 'transferred_to_encrypted', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedSelfAmountAddedEvent', '9': 0, '10': 'transferredToEncrypted'},
    {'1': 'transferred_to_public', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.TransferredToPublic', '9': 0, '10': 'transferredToPublic'},
    {'1': 'transferred_with_schedule', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.TransferredWithSchedule', '9': 0, '10': 'transferredWithSchedule'},
    {'1': 'credential_keys_updated', '3': 15, '4': 1, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '9': 0, '10': 'credentialKeysUpdated'},
    {'1': 'credentials_updated', '3': 16, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.CredentialsUpdated', '9': 0, '10': 'credentialsUpdated'},
    {'1': 'data_registered', '3': 17, '4': 1, '5': 11, '6': '.concordium.v2.RegisteredData', '9': 0, '10': 'dataRegistered'},
    {'1': 'baker_configured', '3': 18, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.BakerConfigured', '9': 0, '10': 'bakerConfigured'},
    {'1': 'delegation_configured', '3': 19, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects.DelegationConfigured', '9': 0, '10': 'delegationConfigured'},
  ],
  '3': [AccountTransactionEffects_None$json, AccountTransactionEffects_ContractUpdateIssued$json, AccountTransactionEffects_AccountTransfer$json, AccountTransactionEffects_BakerStakeUpdated$json, AccountTransactionEffects_EncryptedAmountTransferred$json, AccountTransactionEffects_TransferredToPublic$json, AccountTransactionEffects_TransferredWithSchedule$json, AccountTransactionEffects_CredentialsUpdated$json, AccountTransactionEffects_BakerConfigured$json, AccountTransactionEffects_DelegationConfigured$json],
  '8': [
    {'1': 'effect'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_None$json = {
  '1': 'None',
  '2': [
    {'1': 'transaction_type', '3': 1, '4': 1, '5': 14, '6': '.concordium.v2.TransactionType', '9': 0, '10': 'transactionType', '17': true},
    {'1': 'reject_reason', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason', '10': 'rejectReason'},
  ],
  '8': [
    {'1': '_transaction_type'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_ContractUpdateIssued$json = {
  '1': 'ContractUpdateIssued',
  '2': [
    {'1': 'effects', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.ContractTraceElement', '10': 'effects'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_AccountTransfer$json = {
  '1': 'AccountTransfer',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'receiver', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'receiver'},
    {'1': 'memo', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Memo', '9': 0, '10': 'memo', '17': true},
  ],
  '8': [
    {'1': '_memo'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_BakerStakeUpdated$json = {
  '1': 'BakerStakeUpdated',
  '2': [
    {'1': 'update', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerStakeUpdatedData', '9': 0, '10': 'update', '17': true},
  ],
  '8': [
    {'1': '_update'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_EncryptedAmountTransferred$json = {
  '1': 'EncryptedAmountTransferred',
  '2': [
    {'1': 'removed', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmountRemovedEvent', '10': 'removed'},
    {'1': 'added', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.NewEncryptedAmountEvent', '10': 'added'},
    {'1': 'memo', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Memo', '9': 0, '10': 'memo', '17': true},
  ],
  '8': [
    {'1': '_memo'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_TransferredToPublic$json = {
  '1': 'TransferredToPublic',
  '2': [
    {'1': 'removed', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.EncryptedAmountRemovedEvent', '10': 'removed'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_TransferredWithSchedule$json = {
  '1': 'TransferredWithSchedule',
  '2': [
    {'1': 'receiver', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'receiver'},
    {'1': 'amount', '3': 2, '4': 3, '5': 11, '6': '.concordium.v2.NewRelease', '10': 'amount'},
    {'1': 'memo', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Memo', '9': 0, '10': 'memo', '17': true},
  ],
  '8': [
    {'1': '_memo'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_CredentialsUpdated$json = {
  '1': 'CredentialsUpdated',
  '2': [
    {'1': 'new_cred_ids', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '10': 'newCredIds'},
    {'1': 'removed_cred_ids', '3': 2, '4': 3, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '10': 'removedCredIds'},
    {'1': 'new_threshold', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccountThreshold', '10': 'newThreshold'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_BakerConfigured$json = {
  '1': 'BakerConfigured',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.BakerEvent', '10': 'events'},
  ],
};

@$core.Deprecated('Use accountTransactionEffectsDescriptor instead')
const AccountTransactionEffects_DelegationConfigured$json = {
  '1': 'DelegationConfigured',
  '2': [
    {'1': 'events', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.DelegationEvent', '10': 'events'},
  ],
};

/// Descriptor for `AccountTransactionEffects`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountTransactionEffectsDescriptor = $convert.base64Decode(
    'ChlBY2NvdW50VHJhbnNhY3Rpb25FZmZlY3RzEkMKBG5vbmUYASABKAsyLS5jb25jb3JkaXVtLn'
    'YyLkFjY291bnRUcmFuc2FjdGlvbkVmZmVjdHMuTm9uZUgAUgRub25lEkMKD21vZHVsZV9kZXBs'
    'b3llZBgCIAEoCzIYLmNvbmNvcmRpdW0udjIuTW9kdWxlUmVmSABSDm1vZHVsZURlcGxveWVkEl'
    'wKFGNvbnRyYWN0X2luaXRpYWxpemVkGAMgASgLMicuY29uY29yZGl1bS52Mi5Db250cmFjdElu'
    'aXRpYWxpemVkRXZlbnRIAFITY29udHJhY3RJbml0aWFsaXplZBJ1ChZjb250cmFjdF91cGRhdG'
    'VfaXNzdWVkGAQgASgLMj0uY29uY29yZGl1bS52Mi5BY2NvdW50VHJhbnNhY3Rpb25FZmZlY3Rz'
    'LkNvbnRyYWN0VXBkYXRlSXNzdWVkSABSFGNvbnRyYWN0VXBkYXRlSXNzdWVkEmUKEGFjY291bn'
    'RfdHJhbnNmZXIYBSABKAsyOC5jb25jb3JkaXVtLnYyLkFjY291bnRUcmFuc2FjdGlvbkVmZmVj'
    'dHMuQWNjb3VudFRyYW5zZmVySABSD2FjY291bnRUcmFuc2ZlchJHCgtiYWtlcl9hZGRlZBgGIA'
    'EoCzIkLmNvbmNvcmRpdW0udjIuQmFrZXJFdmVudC5CYWtlckFkZGVkSABSCmJha2VyQWRkZWQS'
    'PQoNYmFrZXJfcmVtb3ZlZBgHIAEoCzIWLmNvbmNvcmRpdW0udjIuQmFrZXJJZEgAUgxiYWtlcl'
    'JlbW92ZWQSbAoTYmFrZXJfc3Rha2VfdXBkYXRlZBgIIAEoCzI6LmNvbmNvcmRpdW0udjIuQWNj'
    'b3VudFRyYW5zYWN0aW9uRWZmZWN0cy5CYWtlclN0YWtlVXBkYXRlZEgAUhFiYWtlclN0YWtlVX'
    'BkYXRlZBJ8Ch5iYWtlcl9yZXN0YWtlX2Vhcm5pbmdzX3VwZGF0ZWQYCSABKAsyNS5jb25jb3Jk'
    'aXVtLnYyLkJha2VyRXZlbnQuQmFrZXJSZXN0YWtlRWFybmluZ3NVcGRhdGVkSABSG2Jha2VyUm'
    'VzdGFrZUVhcm5pbmdzVXBkYXRlZBJNChJiYWtlcl9rZXlzX3VwZGF0ZWQYCiABKAsyHS5jb25j'
    'b3JkaXVtLnYyLkJha2VyS2V5c0V2ZW50SABSEGJha2VyS2V5c1VwZGF0ZWQShwEKHGVuY3J5cH'
    'RlZF9hbW91bnRfdHJhbnNmZXJyZWQYCyABKAsyQy5jb25jb3JkaXVtLnYyLkFjY291bnRUcmFu'
    'c2FjdGlvbkVmZmVjdHMuRW5jcnlwdGVkQW1vdW50VHJhbnNmZXJyZWRIAFIaZW5jcnlwdGVkQW'
    '1vdW50VHJhbnNmZXJyZWQSaAoYdHJhbnNmZXJyZWRfdG9fZW5jcnlwdGVkGAwgASgLMiwuY29u'
    'Y29yZGl1bS52Mi5FbmNyeXB0ZWRTZWxmQW1vdW50QWRkZWRFdmVudEgAUhZ0cmFuc2ZlcnJlZF'
    'RvRW5jcnlwdGVkEnIKFXRyYW5zZmVycmVkX3RvX3B1YmxpYxgNIAEoCzI8LmNvbmNvcmRpdW0u'
    'djIuQWNjb3VudFRyYW5zYWN0aW9uRWZmZWN0cy5UcmFuc2ZlcnJlZFRvUHVibGljSABSE3RyYW'
    '5zZmVycmVkVG9QdWJsaWMSfgoZdHJhbnNmZXJyZWRfd2l0aF9zY2hlZHVsZRgOIAEoCzJALmNv'
    'bmNvcmRpdW0udjIuQWNjb3VudFRyYW5zYWN0aW9uRWZmZWN0cy5UcmFuc2ZlcnJlZFdpdGhTY2'
    'hlZHVsZUgAUhd0cmFuc2ZlcnJlZFdpdGhTY2hlZHVsZRJhChdjcmVkZW50aWFsX2tleXNfdXBk'
    'YXRlZBgPIAEoCzInLmNvbmNvcmRpdW0udjIuQ3JlZGVudGlhbFJlZ2lzdHJhdGlvbklkSABSFW'
    'NyZWRlbnRpYWxLZXlzVXBkYXRlZBJuChNjcmVkZW50aWFsc191cGRhdGVkGBAgASgLMjsuY29u'
    'Y29yZGl1bS52Mi5BY2NvdW50VHJhbnNhY3Rpb25FZmZlY3RzLkNyZWRlbnRpYWxzVXBkYXRlZE'
    'gAUhJjcmVkZW50aWFsc1VwZGF0ZWQSSAoPZGF0YV9yZWdpc3RlcmVkGBEgASgLMh0uY29uY29y'
    'ZGl1bS52Mi5SZWdpc3RlcmVkRGF0YUgAUg5kYXRhUmVnaXN0ZXJlZBJlChBiYWtlcl9jb25maW'
    'd1cmVkGBIgASgLMjguY29uY29yZGl1bS52Mi5BY2NvdW50VHJhbnNhY3Rpb25FZmZlY3RzLkJh'
    'a2VyQ29uZmlndXJlZEgAUg9iYWtlckNvbmZpZ3VyZWQSdAoVZGVsZWdhdGlvbl9jb25maWd1cm'
    'VkGBMgASgLMj0uY29uY29yZGl1bS52Mi5BY2NvdW50VHJhbnNhY3Rpb25FZmZlY3RzLkRlbGVn'
    'YXRpb25Db25maWd1cmVkSABSFGRlbGVnYXRpb25Db25maWd1cmVkGq0BCgROb25lEk4KEHRyYW'
    '5zYWN0aW9uX3R5cGUYASABKA4yHi5jb25jb3JkaXVtLnYyLlRyYW5zYWN0aW9uVHlwZUgAUg90'
    'cmFuc2FjdGlvblR5cGWIAQESQAoNcmVqZWN0X3JlYXNvbhgCIAEoCzIbLmNvbmNvcmRpdW0udj'
    'IuUmVqZWN0UmVhc29uUgxyZWplY3RSZWFzb25CEwoRX3RyYW5zYWN0aW9uX3R5cGUaVQoUQ29u'
    'dHJhY3RVcGRhdGVJc3N1ZWQSPQoHZWZmZWN0cxgBIAMoCzIjLmNvbmNvcmRpdW0udjIuQ29udH'
    'JhY3RUcmFjZUVsZW1lbnRSB2VmZmVjdHMasgEKD0FjY291bnRUcmFuc2ZlchItCgZhbW91bnQY'
    'ASABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIGYW1vdW50EjkKCHJlY2VpdmVyGAIgASgLMh'
    '0uY29uY29yZGl1bS52Mi5BY2NvdW50QWRkcmVzc1IIcmVjZWl2ZXISLAoEbWVtbxgDIAEoCzIT'
    'LmNvbmNvcmRpdW0udjIuTWVtb0gAUgRtZW1viAEBQgcKBV9tZW1vGmEKEUJha2VyU3Rha2VVcG'
    'RhdGVkEkEKBnVwZGF0ZRgBIAEoCzIkLmNvbmNvcmRpdW0udjIuQmFrZXJTdGFrZVVwZGF0ZWRE'
    'YXRhSABSBnVwZGF0ZYgBAUIJCgdfdXBkYXRlGtcBChpFbmNyeXB0ZWRBbW91bnRUcmFuc2Zlcn'
    'JlZBJECgdyZW1vdmVkGAEgASgLMiouY29uY29yZGl1bS52Mi5FbmNyeXB0ZWRBbW91bnRSZW1v'
    'dmVkRXZlbnRSB3JlbW92ZWQSPAoFYWRkZWQYAiABKAsyJi5jb25jb3JkaXVtLnYyLk5ld0VuY3'
    'J5cHRlZEFtb3VudEV2ZW50UgVhZGRlZBIsCgRtZW1vGAMgASgLMhMuY29uY29yZGl1bS52Mi5N'
    'ZW1vSABSBG1lbW+IAQFCBwoFX21lbW8aigEKE1RyYW5zZmVycmVkVG9QdWJsaWMSRAoHcmVtb3'
    'ZlZBgBIAEoCzIqLmNvbmNvcmRpdW0udjIuRW5jcnlwdGVkQW1vdW50UmVtb3ZlZEV2ZW50Ugdy'
    'ZW1vdmVkEi0KBmFtb3VudBgCIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UgZhbW91bnQavg'
    'EKF1RyYW5zZmVycmVkV2l0aFNjaGVkdWxlEjkKCHJlY2VpdmVyGAEgASgLMh0uY29uY29yZGl1'
    'bS52Mi5BY2NvdW50QWRkcmVzc1IIcmVjZWl2ZXISMQoGYW1vdW50GAIgAygLMhkuY29uY29yZG'
    'l1bS52Mi5OZXdSZWxlYXNlUgZhbW91bnQSLAoEbWVtbxgDIAEoCzITLmNvbmNvcmRpdW0udjIu'
    'TWVtb0gAUgRtZW1viAEBQgcKBV9tZW1vGvgBChJDcmVkZW50aWFsc1VwZGF0ZWQSSQoMbmV3X2'
    'NyZWRfaWRzGAEgAygLMicuY29uY29yZGl1bS52Mi5DcmVkZW50aWFsUmVnaXN0cmF0aW9uSWRS'
    'Cm5ld0NyZWRJZHMSUQoQcmVtb3ZlZF9jcmVkX2lkcxgCIAMoCzInLmNvbmNvcmRpdW0udjIuQ3'
    'JlZGVudGlhbFJlZ2lzdHJhdGlvbklkUg5yZW1vdmVkQ3JlZElkcxJECg1uZXdfdGhyZXNob2xk'
    'GAMgASgLMh8uY29uY29yZGl1bS52Mi5BY2NvdW50VGhyZXNob2xkUgxuZXdUaHJlc2hvbGQaRA'
    'oPQmFrZXJDb25maWd1cmVkEjEKBmV2ZW50cxgBIAMoCzIZLmNvbmNvcmRpdW0udjIuQmFrZXJF'
    'dmVudFIGZXZlbnRzGk4KFERlbGVnYXRpb25Db25maWd1cmVkEjYKBmV2ZW50cxgBIAMoCzIeLm'
    'NvbmNvcmRpdW0udjIuRGVsZWdhdGlvbkV2ZW50UgZldmVudHNCCAoGZWZmZWN0');

@$core.Deprecated('Use electionDifficultyDescriptor instead')
const ElectionDifficulty$json = {
  '1': 'ElectionDifficulty',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'value'},
  ],
};

/// Descriptor for `ElectionDifficulty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List electionDifficultyDescriptor = $convert.base64Decode(
    'ChJFbGVjdGlvbkRpZmZpY3VsdHkSMwoFdmFsdWUYASABKAsyHS5jb25jb3JkaXVtLnYyLkFtb3'
    'VudEZyYWN0aW9uUgV2YWx1ZQ==');

@$core.Deprecated('Use timeoutParametersDescriptor instead')
const TimeoutParameters$json = {
  '1': 'TimeoutParameters',
  '2': [
    {'1': 'timeout_base', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '10': 'timeoutBase'},
    {'1': 'timeout_increase', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Ratio', '10': 'timeoutIncrease'},
    {'1': 'timeout_decrease', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Ratio', '10': 'timeoutDecrease'},
  ],
};

/// Descriptor for `TimeoutParameters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeoutParametersDescriptor = $convert.base64Decode(
    'ChFUaW1lb3V0UGFyYW1ldGVycxI6Cgx0aW1lb3V0X2Jhc2UYASABKAsyFy5jb25jb3JkaXVtLn'
    'YyLkR1cmF0aW9uUgt0aW1lb3V0QmFzZRI/ChB0aW1lb3V0X2luY3JlYXNlGAIgASgLMhQuY29u'
    'Y29yZGl1bS52Mi5SYXRpb1IPdGltZW91dEluY3JlYXNlEj8KEHRpbWVvdXRfZGVjcmVhc2UYAy'
    'ABKAsyFC5jb25jb3JkaXVtLnYyLlJhdGlvUg90aW1lb3V0RGVjcmVhc2U=');

@$core.Deprecated('Use finalizationCommitteeParametersDescriptor instead')
const FinalizationCommitteeParameters$json = {
  '1': 'FinalizationCommitteeParameters',
  '2': [
    {'1': 'minimum_finalizers', '3': 1, '4': 1, '5': 13, '10': 'minimumFinalizers'},
    {'1': 'maximum_finalizers', '3': 2, '4': 1, '5': 13, '10': 'maximumFinalizers'},
    {'1': 'finalizer_relative_stake_threshold', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'finalizerRelativeStakeThreshold'},
  ],
};

/// Descriptor for `FinalizationCommitteeParameters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizationCommitteeParametersDescriptor = $convert.base64Decode(
    'Ch9GaW5hbGl6YXRpb25Db21taXR0ZWVQYXJhbWV0ZXJzEi0KEm1pbmltdW1fZmluYWxpemVycx'
    'gBIAEoDVIRbWluaW11bUZpbmFsaXplcnMSLQoSbWF4aW11bV9maW5hbGl6ZXJzGAIgASgNUhFt'
    'YXhpbXVtRmluYWxpemVycxJqCiJmaW5hbGl6ZXJfcmVsYXRpdmVfc3Rha2VfdGhyZXNob2xkGA'
    'MgASgLMh0uY29uY29yZGl1bS52Mi5BbW91bnRGcmFjdGlvblIfZmluYWxpemVyUmVsYXRpdmVT'
    'dGFrZVRocmVzaG9sZA==');

@$core.Deprecated('Use consensusParametersV1Descriptor instead')
const ConsensusParametersV1$json = {
  '1': 'ConsensusParametersV1',
  '2': [
    {'1': 'timeout_parameters', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.TimeoutParameters', '10': 'timeoutParameters'},
    {'1': 'min_block_time', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '10': 'minBlockTime'},
    {'1': 'block_energy_limit', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'blockEnergyLimit'},
  ],
};

/// Descriptor for `ConsensusParametersV1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List consensusParametersV1Descriptor = $convert.base64Decode(
    'ChVDb25zZW5zdXNQYXJhbWV0ZXJzVjESTwoSdGltZW91dF9wYXJhbWV0ZXJzGAEgASgLMiAuY2'
    '9uY29yZGl1bS52Mi5UaW1lb3V0UGFyYW1ldGVyc1IRdGltZW91dFBhcmFtZXRlcnMSPQoObWlu'
    'X2Jsb2NrX3RpbWUYAiABKAsyFy5jb25jb3JkaXVtLnYyLkR1cmF0aW9uUgxtaW5CbG9ja1RpbW'
    'USQwoSYmxvY2tfZW5lcmd5X2xpbWl0GAMgASgLMhUuY29uY29yZGl1bS52Mi5FbmVyZ3lSEGJs'
    'b2NrRW5lcmd5TGltaXQ=');

@$core.Deprecated('Use exchangeRateDescriptor instead')
const ExchangeRate$json = {
  '1': 'ExchangeRate',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Ratio', '10': 'value'},
  ],
};

/// Descriptor for `ExchangeRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exchangeRateDescriptor = $convert.base64Decode(
    'CgxFeGNoYW5nZVJhdGUSKgoFdmFsdWUYASABKAsyFC5jb25jb3JkaXVtLnYyLlJhdGlvUgV2YW'
    'x1ZQ==');

@$core.Deprecated('Use ratioDescriptor instead')
const Ratio$json = {
  '1': 'Ratio',
  '2': [
    {'1': 'numerator', '3': 1, '4': 1, '5': 4, '10': 'numerator'},
    {'1': 'denominator', '3': 2, '4': 1, '5': 4, '10': 'denominator'},
  ],
};

/// Descriptor for `Ratio`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ratioDescriptor = $convert.base64Decode(
    'CgVSYXRpbxIcCgludW1lcmF0b3IYASABKARSCW51bWVyYXRvchIgCgtkZW5vbWluYXRvchgCIA'
    'EoBFILZGVub21pbmF0b3I=');

@$core.Deprecated('Use updatePublicKeyDescriptor instead')
const UpdatePublicKey$json = {
  '1': 'UpdatePublicKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `UpdatePublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePublicKeyDescriptor = $convert.base64Decode(
    'Cg9VcGRhdGVQdWJsaWNLZXkSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use updateKeysThresholdDescriptor instead')
const UpdateKeysThreshold$json = {
  '1': 'UpdateKeysThreshold',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `UpdateKeysThreshold`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateKeysThresholdDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVLZXlzVGhyZXNob2xkEhQKBXZhbHVlGAEgASgNUgV2YWx1ZQ==');

@$core.Deprecated('Use updateKeysIndexDescriptor instead')
const UpdateKeysIndex$json = {
  '1': 'UpdateKeysIndex',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `UpdateKeysIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateKeysIndexDescriptor = $convert.base64Decode(
    'Cg9VcGRhdGVLZXlzSW5kZXgSFAoFdmFsdWUYASABKA1SBXZhbHVl');

@$core.Deprecated('Use higherLevelKeysDescriptor instead')
const HigherLevelKeys$json = {
  '1': 'HigherLevelKeys',
  '2': [
    {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.UpdatePublicKey', '10': 'keys'},
    {'1': 'threshold', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.UpdateKeysThreshold', '10': 'threshold'},
  ],
};

/// Descriptor for `HigherLevelKeys`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List higherLevelKeysDescriptor = $convert.base64Decode(
    'Cg9IaWdoZXJMZXZlbEtleXMSMgoEa2V5cxgBIAMoCzIeLmNvbmNvcmRpdW0udjIuVXBkYXRlUH'
    'VibGljS2V5UgRrZXlzEkAKCXRocmVzaG9sZBgCIAEoCzIiLmNvbmNvcmRpdW0udjIuVXBkYXRl'
    'S2V5c1RocmVzaG9sZFIJdGhyZXNob2xk');

@$core.Deprecated('Use accessStructureDescriptor instead')
const AccessStructure$json = {
  '1': 'AccessStructure',
  '2': [
    {'1': 'access_public_keys', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.UpdateKeysIndex', '10': 'accessPublicKeys'},
    {'1': 'access_threshold', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.UpdateKeysThreshold', '10': 'accessThreshold'},
  ],
};

/// Descriptor for `AccessStructure`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accessStructureDescriptor = $convert.base64Decode(
    'Cg9BY2Nlc3NTdHJ1Y3R1cmUSTAoSYWNjZXNzX3B1YmxpY19rZXlzGAEgAygLMh4uY29uY29yZG'
    'l1bS52Mi5VcGRhdGVLZXlzSW5kZXhSEGFjY2Vzc1B1YmxpY0tleXMSTQoQYWNjZXNzX3RocmVz'
    'aG9sZBgCIAEoCzIiLmNvbmNvcmRpdW0udjIuVXBkYXRlS2V5c1RocmVzaG9sZFIPYWNjZXNzVG'
    'hyZXNob2xk');

@$core.Deprecated('Use authorizationsV0Descriptor instead')
const AuthorizationsV0$json = {
  '1': 'AuthorizationsV0',
  '2': [
    {'1': 'keys', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.UpdatePublicKey', '10': 'keys'},
    {'1': 'emergency', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'emergency'},
    {'1': 'protocol', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'protocol'},
    {'1': 'parameter_consensus', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterConsensus'},
    {'1': 'parameter_euro_per_energy', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterEuroPerEnergy'},
    {'1': 'parameter_micro_CCD_per_euro', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterMicroCCDPerEuro'},
    {'1': 'parameter_foundation_account', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterFoundationAccount'},
    {'1': 'parameter_mint_distribution', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterMintDistribution'},
    {'1': 'parameter_transaction_fee_distribution', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterTransactionFeeDistribution'},
    {'1': 'parameter_gas_rewards', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterGasRewards'},
    {'1': 'pool_parameters', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'poolParameters'},
    {'1': 'add_anonymity_revoker', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'addAnonymityRevoker'},
    {'1': 'add_identity_provider', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'addIdentityProvider'},
  ],
};

/// Descriptor for `AuthorizationsV0`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizationsV0Descriptor = $convert.base64Decode(
    'ChBBdXRob3JpemF0aW9uc1YwEjIKBGtleXMYASADKAsyHi5jb25jb3JkaXVtLnYyLlVwZGF0ZV'
    'B1YmxpY0tleVIEa2V5cxI8CgllbWVyZ2VuY3kYAiABKAsyHi5jb25jb3JkaXVtLnYyLkFjY2Vz'
    'c1N0cnVjdHVyZVIJZW1lcmdlbmN5EjoKCHByb3RvY29sGAMgASgLMh4uY29uY29yZGl1bS52Mi'
    '5BY2Nlc3NTdHJ1Y3R1cmVSCHByb3RvY29sEk8KE3BhcmFtZXRlcl9jb25zZW5zdXMYBCABKAsy'
    'Hi5jb25jb3JkaXVtLnYyLkFjY2Vzc1N0cnVjdHVyZVIScGFyYW1ldGVyQ29uc2Vuc3VzElkKGX'
    'BhcmFtZXRlcl9ldXJvX3Blcl9lbmVyZ3kYBSABKAsyHi5jb25jb3JkaXVtLnYyLkFjY2Vzc1N0'
    'cnVjdHVyZVIWcGFyYW1ldGVyRXVyb1BlckVuZXJneRJeChxwYXJhbWV0ZXJfbWljcm9fQ0NEX3'
    'Blcl9ldXJvGAYgASgLMh4uY29uY29yZGl1bS52Mi5BY2Nlc3NTdHJ1Y3R1cmVSGHBhcmFtZXRl'
    'ck1pY3JvQ0NEUGVyRXVybxJgChxwYXJhbWV0ZXJfZm91bmRhdGlvbl9hY2NvdW50GAcgASgLMh'
    '4uY29uY29yZGl1bS52Mi5BY2Nlc3NTdHJ1Y3R1cmVSGnBhcmFtZXRlckZvdW5kYXRpb25BY2Nv'
    'dW50El4KG3BhcmFtZXRlcl9taW50X2Rpc3RyaWJ1dGlvbhgIIAEoCzIeLmNvbmNvcmRpdW0udj'
    'IuQWNjZXNzU3RydWN0dXJlUhlwYXJhbWV0ZXJNaW50RGlzdHJpYnV0aW9uEnMKJnBhcmFtZXRl'
    'cl90cmFuc2FjdGlvbl9mZWVfZGlzdHJpYnV0aW9uGAkgASgLMh4uY29uY29yZGl1bS52Mi5BY2'
    'Nlc3NTdHJ1Y3R1cmVSI3BhcmFtZXRlclRyYW5zYWN0aW9uRmVlRGlzdHJpYnV0aW9uElIKFXBh'
    'cmFtZXRlcl9nYXNfcmV3YXJkcxgKIAEoCzIeLmNvbmNvcmRpdW0udjIuQWNjZXNzU3RydWN0dX'
    'JlUhNwYXJhbWV0ZXJHYXNSZXdhcmRzEkcKD3Bvb2xfcGFyYW1ldGVycxgLIAEoCzIeLmNvbmNv'
    'cmRpdW0udjIuQWNjZXNzU3RydWN0dXJlUg5wb29sUGFyYW1ldGVycxJSChVhZGRfYW5vbnltaX'
    'R5X3Jldm9rZXIYDCABKAsyHi5jb25jb3JkaXVtLnYyLkFjY2Vzc1N0cnVjdHVyZVITYWRkQW5v'
    'bnltaXR5UmV2b2tlchJSChVhZGRfaWRlbnRpdHlfcHJvdmlkZXIYDSABKAsyHi5jb25jb3JkaX'
    'VtLnYyLkFjY2Vzc1N0cnVjdHVyZVITYWRkSWRlbnRpdHlQcm92aWRlcg==');

@$core.Deprecated('Use authorizationsV1Descriptor instead')
const AuthorizationsV1$json = {
  '1': 'AuthorizationsV1',
  '2': [
    {'1': 'v0', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV0', '10': 'v0'},
    {'1': 'parameter_cooldown', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterCooldown'},
    {'1': 'parameter_time', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccessStructure', '10': 'parameterTime'},
  ],
};

/// Descriptor for `AuthorizationsV1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizationsV1Descriptor = $convert.base64Decode(
    'ChBBdXRob3JpemF0aW9uc1YxEi8KAnYwGAEgASgLMh8uY29uY29yZGl1bS52Mi5BdXRob3Jpem'
    'F0aW9uc1YwUgJ2MBJNChJwYXJhbWV0ZXJfY29vbGRvd24YAiABKAsyHi5jb25jb3JkaXVtLnYy'
    'LkFjY2Vzc1N0cnVjdHVyZVIRcGFyYW1ldGVyQ29vbGRvd24SRQoOcGFyYW1ldGVyX3RpbWUYAy'
    'ABKAsyHi5jb25jb3JkaXVtLnYyLkFjY2Vzc1N0cnVjdHVyZVINcGFyYW1ldGVyVGltZQ==');

@$core.Deprecated('Use descriptionDescriptor instead')
const Description$json = {
  '1': 'Description',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
  ],
};

/// Descriptor for `Description`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List descriptionDescriptor = $convert.base64Decode(
    'CgtEZXNjcmlwdGlvbhISCgRuYW1lGAEgASgJUgRuYW1lEhAKA3VybBgCIAEoCVIDdXJsEiAKC2'
    'Rlc2NyaXB0aW9uGAMgASgJUgtkZXNjcmlwdGlvbg==');

@$core.Deprecated('Use arInfoDescriptor instead')
const ArInfo$json = {
  '1': 'ArInfo',
  '2': [
    {'1': 'identity', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ArInfo.ArIdentity', '10': 'identity'},
    {'1': 'description', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Description', '10': 'description'},
    {'1': 'public_key', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ArInfo.ArPublicKey', '10': 'publicKey'},
  ],
  '3': [ArInfo_ArIdentity$json, ArInfo_ArPublicKey$json],
};

@$core.Deprecated('Use arInfoDescriptor instead')
const ArInfo_ArIdentity$json = {
  '1': 'ArIdentity',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

@$core.Deprecated('Use arInfoDescriptor instead')
const ArInfo_ArPublicKey$json = {
  '1': 'ArPublicKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `ArInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arInfoDescriptor = $convert.base64Decode(
    'CgZBckluZm8SPAoIaWRlbnRpdHkYASABKAsyIC5jb25jb3JkaXVtLnYyLkFySW5mby5BcklkZW'
    '50aXR5UghpZGVudGl0eRI8CgtkZXNjcmlwdGlvbhgCIAEoCzIaLmNvbmNvcmRpdW0udjIuRGVz'
    'Y3JpcHRpb25SC2Rlc2NyaXB0aW9uEkAKCnB1YmxpY19rZXkYAyABKAsyIS5jb25jb3JkaXVtLn'
    'YyLkFySW5mby5BclB1YmxpY0tleVIJcHVibGljS2V5GiIKCkFySWRlbnRpdHkSFAoFdmFsdWUY'
    'ASABKA1SBXZhbHVlGiMKC0FyUHVibGljS2V5EhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use ipIdentityDescriptor instead')
const IpIdentity$json = {
  '1': 'IpIdentity',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `IpIdentity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ipIdentityDescriptor = $convert.base64Decode(
    'CgpJcElkZW50aXR5EhQKBXZhbHVlGAEgASgNUgV2YWx1ZQ==');

@$core.Deprecated('Use ipInfoDescriptor instead')
const IpInfo$json = {
  '1': 'IpInfo',
  '2': [
    {'1': 'identity', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.IpIdentity', '10': 'identity'},
    {'1': 'description', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Description', '10': 'description'},
    {'1': 'verify_key', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.IpInfo.IpVerifyKey', '10': 'verifyKey'},
    {'1': 'cdi_verify_key', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.IpInfo.IpCdiVerifyKey', '10': 'cdiVerifyKey'},
  ],
  '3': [IpInfo_IpVerifyKey$json, IpInfo_IpCdiVerifyKey$json],
};

@$core.Deprecated('Use ipInfoDescriptor instead')
const IpInfo_IpVerifyKey$json = {
  '1': 'IpVerifyKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

@$core.Deprecated('Use ipInfoDescriptor instead')
const IpInfo_IpCdiVerifyKey$json = {
  '1': 'IpCdiVerifyKey',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `IpInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ipInfoDescriptor = $convert.base64Decode(
    'CgZJcEluZm8SNQoIaWRlbnRpdHkYASABKAsyGS5jb25jb3JkaXVtLnYyLklwSWRlbnRpdHlSCG'
    'lkZW50aXR5EjwKC2Rlc2NyaXB0aW9uGAIgASgLMhouY29uY29yZGl1bS52Mi5EZXNjcmlwdGlv'
    'blILZGVzY3JpcHRpb24SQAoKdmVyaWZ5X2tleRgDIAEoCzIhLmNvbmNvcmRpdW0udjIuSXBJbm'
    'ZvLklwVmVyaWZ5S2V5Ugl2ZXJpZnlLZXkSSgoOY2RpX3ZlcmlmeV9rZXkYBCABKAsyJC5jb25j'
    'b3JkaXVtLnYyLklwSW5mby5JcENkaVZlcmlmeUtleVIMY2RpVmVyaWZ5S2V5GiMKC0lwVmVyaW'
    'Z5S2V5EhQKBXZhbHVlGAEgASgMUgV2YWx1ZRomCg5JcENkaVZlcmlmeUtleRIUCgV2YWx1ZRgB'
    'IAEoDFIFdmFsdWU=');

@$core.Deprecated('Use durationSecondsDescriptor instead')
const DurationSeconds$json = {
  '1': 'DurationSeconds',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `DurationSeconds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List durationSecondsDescriptor = $convert.base64Decode(
    'Cg9EdXJhdGlvblNlY29uZHMSFAoFdmFsdWUYASABKARSBXZhbHVl');

@$core.Deprecated('Use inclusiveRangeAmountFractionDescriptor instead')
const InclusiveRangeAmountFraction$json = {
  '1': 'InclusiveRangeAmountFraction',
  '2': [
    {'1': 'min', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'min'},
    {'1': 'max_', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'max'},
  ],
};

/// Descriptor for `InclusiveRangeAmountFraction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inclusiveRangeAmountFractionDescriptor = $convert.base64Decode(
    'ChxJbmNsdXNpdmVSYW5nZUFtb3VudEZyYWN0aW9uEi8KA21pbhgBIAEoCzIdLmNvbmNvcmRpdW'
    '0udjIuQW1vdW50RnJhY3Rpb25SA21pbhIwCgRtYXhfGAIgASgLMh0uY29uY29yZGl1bS52Mi5B'
    'bW91bnRGcmFjdGlvblIDbWF4');

@$core.Deprecated('Use commissionRangesDescriptor instead')
const CommissionRanges$json = {
  '1': 'CommissionRanges',
  '2': [
    {'1': 'finalization', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.InclusiveRangeAmountFraction', '10': 'finalization'},
    {'1': 'baking', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.InclusiveRangeAmountFraction', '10': 'baking'},
    {'1': 'transaction', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.InclusiveRangeAmountFraction', '10': 'transaction'},
  ],
};

/// Descriptor for `CommissionRanges`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commissionRangesDescriptor = $convert.base64Decode(
    'ChBDb21taXNzaW9uUmFuZ2VzEk8KDGZpbmFsaXphdGlvbhgBIAEoCzIrLmNvbmNvcmRpdW0udj'
    'IuSW5jbHVzaXZlUmFuZ2VBbW91bnRGcmFjdGlvblIMZmluYWxpemF0aW9uEkMKBmJha2luZxgC'
    'IAEoCzIrLmNvbmNvcmRpdW0udjIuSW5jbHVzaXZlUmFuZ2VBbW91bnRGcmFjdGlvblIGYmFraW'
    '5nEk0KC3RyYW5zYWN0aW9uGAMgASgLMisuY29uY29yZGl1bS52Mi5JbmNsdXNpdmVSYW5nZUFt'
    'b3VudEZyYWN0aW9uUgt0cmFuc2FjdGlvbg==');

@$core.Deprecated('Use capitalBoundDescriptor instead')
const CapitalBound$json = {
  '1': 'CapitalBound',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'value'},
  ],
};

/// Descriptor for `CapitalBound`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List capitalBoundDescriptor = $convert.base64Decode(
    'CgxDYXBpdGFsQm91bmQSMwoFdmFsdWUYASABKAsyHS5jb25jb3JkaXVtLnYyLkFtb3VudEZyYW'
    'N0aW9uUgV2YWx1ZQ==');

@$core.Deprecated('Use leverageFactorDescriptor instead')
const LeverageFactor$json = {
  '1': 'LeverageFactor',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Ratio', '10': 'value'},
  ],
};

/// Descriptor for `LeverageFactor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leverageFactorDescriptor = $convert.base64Decode(
    'Cg5MZXZlcmFnZUZhY3RvchIqCgV2YWx1ZRgBIAEoCzIULmNvbmNvcmRpdW0udjIuUmF0aW9SBX'
    'ZhbHVl');

@$core.Deprecated('Use epochDescriptor instead')
const Epoch$json = {
  '1': 'Epoch',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `Epoch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List epochDescriptor = $convert.base64Decode(
    'CgVFcG9jaBIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');

@$core.Deprecated('Use roundDescriptor instead')
const Round$json = {
  '1': 'Round',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `Round`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roundDescriptor = $convert.base64Decode(
    'CgVSb3VuZBIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');

@$core.Deprecated('Use rewardPeriodLengthDescriptor instead')
const RewardPeriodLength$json = {
  '1': 'RewardPeriodLength',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Epoch', '10': 'value'},
  ],
};

/// Descriptor for `RewardPeriodLength`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rewardPeriodLengthDescriptor = $convert.base64Decode(
    'ChJSZXdhcmRQZXJpb2RMZW5ndGgSKgoFdmFsdWUYASABKAsyFC5jb25jb3JkaXVtLnYyLkVwb2'
    'NoUgV2YWx1ZQ==');

@$core.Deprecated('Use mintRateDescriptor instead')
const MintRate$json = {
  '1': 'MintRate',
  '2': [
    {'1': 'mantissa', '3': 1, '4': 1, '5': 13, '10': 'mantissa'},
    {'1': 'exponent', '3': 2, '4': 1, '5': 13, '10': 'exponent'},
  ],
};

/// Descriptor for `MintRate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mintRateDescriptor = $convert.base64Decode(
    'CghNaW50UmF0ZRIaCghtYW50aXNzYRgBIAEoDVIIbWFudGlzc2ESGgoIZXhwb25lbnQYAiABKA'
    '1SCGV4cG9uZW50');

@$core.Deprecated('Use cooldownParametersCpv1Descriptor instead')
const CooldownParametersCpv1$json = {
  '1': 'CooldownParametersCpv1',
  '2': [
    {'1': 'pool_owner_cooldown', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DurationSeconds', '10': 'poolOwnerCooldown'},
    {'1': 'delegator_cooldown', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.DurationSeconds', '10': 'delegatorCooldown'},
  ],
};

/// Descriptor for `CooldownParametersCpv1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cooldownParametersCpv1Descriptor = $convert.base64Decode(
    'ChZDb29sZG93blBhcmFtZXRlcnNDcHYxEk4KE3Bvb2xfb3duZXJfY29vbGRvd24YASABKAsyHi'
    '5jb25jb3JkaXVtLnYyLkR1cmF0aW9uU2Vjb25kc1IRcG9vbE93bmVyQ29vbGRvd24STQoSZGVs'
    'ZWdhdG9yX2Nvb2xkb3duGAIgASgLMh4uY29uY29yZGl1bS52Mi5EdXJhdGlvblNlY29uZHNSEW'
    'RlbGVnYXRvckNvb2xkb3du');

@$core.Deprecated('Use poolParametersCpv1Descriptor instead')
const PoolParametersCpv1$json = {
  '1': 'PoolParametersCpv1',
  '2': [
    {'1': 'passive_finalization_commission', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'passiveFinalizationCommission'},
    {'1': 'passive_baking_commission', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'passiveBakingCommission'},
    {'1': 'passive_transaction_commission', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'passiveTransactionCommission'},
    {'1': 'commission_bounds', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.CommissionRanges', '10': 'commissionBounds'},
    {'1': 'minimum_equity_capital', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'minimumEquityCapital'},
    {'1': 'capital_bound', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.CapitalBound', '10': 'capitalBound'},
    {'1': 'leverage_bound', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.LeverageFactor', '10': 'leverageBound'},
  ],
};

/// Descriptor for `PoolParametersCpv1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List poolParametersCpv1Descriptor = $convert.base64Decode(
    'ChJQb29sUGFyYW1ldGVyc0NwdjESZQofcGFzc2l2ZV9maW5hbGl6YXRpb25fY29tbWlzc2lvbh'
    'gBIAEoCzIdLmNvbmNvcmRpdW0udjIuQW1vdW50RnJhY3Rpb25SHXBhc3NpdmVGaW5hbGl6YXRp'
    'b25Db21taXNzaW9uElkKGXBhc3NpdmVfYmFraW5nX2NvbW1pc3Npb24YAiABKAsyHS5jb25jb3'
    'JkaXVtLnYyLkFtb3VudEZyYWN0aW9uUhdwYXNzaXZlQmFraW5nQ29tbWlzc2lvbhJjCh5wYXNz'
    'aXZlX3RyYW5zYWN0aW9uX2NvbW1pc3Npb24YAyABKAsyHS5jb25jb3JkaXVtLnYyLkFtb3VudE'
    'ZyYWN0aW9uUhxwYXNzaXZlVHJhbnNhY3Rpb25Db21taXNzaW9uEkwKEWNvbW1pc3Npb25fYm91'
    'bmRzGAQgASgLMh8uY29uY29yZGl1bS52Mi5Db21taXNzaW9uUmFuZ2VzUhBjb21taXNzaW9uQm'
    '91bmRzEksKFm1pbmltdW1fZXF1aXR5X2NhcGl0YWwYBSABKAsyFS5jb25jb3JkaXVtLnYyLkFt'
    'b3VudFIUbWluaW11bUVxdWl0eUNhcGl0YWwSQAoNY2FwaXRhbF9ib3VuZBgGIAEoCzIbLmNvbm'
    'NvcmRpdW0udjIuQ2FwaXRhbEJvdW5kUgxjYXBpdGFsQm91bmQSRAoObGV2ZXJhZ2VfYm91bmQY'
    'ByABKAsyHS5jb25jb3JkaXVtLnYyLkxldmVyYWdlRmFjdG9yUg1sZXZlcmFnZUJvdW5k');

@$core.Deprecated('Use timeParametersCpv1Descriptor instead')
const TimeParametersCpv1$json = {
  '1': 'TimeParametersCpv1',
  '2': [
    {'1': 'reward_period_length', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.RewardPeriodLength', '10': 'rewardPeriodLength'},
    {'1': 'mint_per_payday', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.MintRate', '10': 'mintPerPayday'},
  ],
};

/// Descriptor for `TimeParametersCpv1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeParametersCpv1Descriptor = $convert.base64Decode(
    'ChJUaW1lUGFyYW1ldGVyc0NwdjESUwoUcmV3YXJkX3BlcmlvZF9sZW5ndGgYASABKAsyIS5jb2'
    '5jb3JkaXVtLnYyLlJld2FyZFBlcmlvZExlbmd0aFIScmV3YXJkUGVyaW9kTGVuZ3RoEj8KD21p'
    'bnRfcGVyX3BheWRheRgCIAEoCzIXLmNvbmNvcmRpdW0udjIuTWludFJhdGVSDW1pbnRQZXJQYX'
    'lkYXk=');

@$core.Deprecated('Use mintDistributionCpv1Descriptor instead')
const MintDistributionCpv1$json = {
  '1': 'MintDistributionCpv1',
  '2': [
    {'1': 'baking_reward', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'bakingReward'},
    {'1': 'finalization_reward', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'finalizationReward'},
  ],
};

/// Descriptor for `MintDistributionCpv1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mintDistributionCpv1Descriptor = $convert.base64Decode(
    'ChRNaW50RGlzdHJpYnV0aW9uQ3B2MRJCCg1iYWtpbmdfcmV3YXJkGAEgASgLMh0uY29uY29yZG'
    'l1bS52Mi5BbW91bnRGcmFjdGlvblIMYmFraW5nUmV3YXJkEk4KE2ZpbmFsaXphdGlvbl9yZXdh'
    'cmQYAiABKAsyHS5jb25jb3JkaXVtLnYyLkFtb3VudEZyYWN0aW9uUhJmaW5hbGl6YXRpb25SZX'
    'dhcmQ=');

@$core.Deprecated('Use protocolUpdateDescriptor instead')
const ProtocolUpdate$json = {
  '1': 'ProtocolUpdate',
  '2': [
    {'1': 'message_', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'specification_url', '3': 2, '4': 1, '5': 9, '10': 'specificationUrl'},
    {'1': 'specificationHash', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Sha256Hash', '10': 'specificationHash'},
    {'1': 'specification_auxiliary_data', '3': 4, '4': 1, '5': 12, '10': 'specificationAuxiliaryData'},
  ],
};

/// Descriptor for `ProtocolUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List protocolUpdateDescriptor = $convert.base64Decode(
    'Cg5Qcm90b2NvbFVwZGF0ZRIZCghtZXNzYWdlXxgBIAEoCVIHbWVzc2FnZRIrChFzcGVjaWZpY2'
    'F0aW9uX3VybBgCIAEoCVIQc3BlY2lmaWNhdGlvblVybBJHChFzcGVjaWZpY2F0aW9uSGFzaBgD'
    'IAEoCzIZLmNvbmNvcmRpdW0udjIuU2hhMjU2SGFzaFIRc3BlY2lmaWNhdGlvbkhhc2gSQAocc3'
    'BlY2lmaWNhdGlvbl9hdXhpbGlhcnlfZGF0YRgEIAEoDFIac3BlY2lmaWNhdGlvbkF1eGlsaWFy'
    'eURhdGE=');

@$core.Deprecated('Use mintDistributionCpv0Descriptor instead')
const MintDistributionCpv0$json = {
  '1': 'MintDistributionCpv0',
  '2': [
    {'1': 'mint_per_slot', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.MintRate', '10': 'mintPerSlot'},
    {'1': 'baking_reward', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'bakingReward'},
    {'1': 'finalization_reward', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'finalizationReward'},
  ],
};

/// Descriptor for `MintDistributionCpv0`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mintDistributionCpv0Descriptor = $convert.base64Decode(
    'ChRNaW50RGlzdHJpYnV0aW9uQ3B2MBI7Cg1taW50X3Blcl9zbG90GAEgASgLMhcuY29uY29yZG'
    'l1bS52Mi5NaW50UmF0ZVILbWludFBlclNsb3QSQgoNYmFraW5nX3Jld2FyZBgCIAEoCzIdLmNv'
    'bmNvcmRpdW0udjIuQW1vdW50RnJhY3Rpb25SDGJha2luZ1Jld2FyZBJOChNmaW5hbGl6YXRpb2'
    '5fcmV3YXJkGAMgASgLMh0uY29uY29yZGl1bS52Mi5BbW91bnRGcmFjdGlvblISZmluYWxpemF0'
    'aW9uUmV3YXJk');

@$core.Deprecated('Use transactionFeeDistributionDescriptor instead')
const TransactionFeeDistribution$json = {
  '1': 'TransactionFeeDistribution',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'baker'},
    {'1': 'gas_account', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'gasAccount'},
  ],
};

/// Descriptor for `TransactionFeeDistribution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionFeeDistributionDescriptor = $convert.base64Decode(
    'ChpUcmFuc2FjdGlvbkZlZURpc3RyaWJ1dGlvbhIzCgViYWtlchgBIAEoCzIdLmNvbmNvcmRpdW'
    '0udjIuQW1vdW50RnJhY3Rpb25SBWJha2VyEj4KC2dhc19hY2NvdW50GAIgASgLMh0uY29uY29y'
    'ZGl1bS52Mi5BbW91bnRGcmFjdGlvblIKZ2FzQWNjb3VudA==');

@$core.Deprecated('Use gasRewardsDescriptor instead')
const GasRewards$json = {
  '1': 'GasRewards',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'baker'},
    {'1': 'finalization_proof', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'finalizationProof'},
    {'1': 'account_creation', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'accountCreation'},
    {'1': 'chain_update', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'chainUpdate'},
  ],
};

/// Descriptor for `GasRewards`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gasRewardsDescriptor = $convert.base64Decode(
    'CgpHYXNSZXdhcmRzEjMKBWJha2VyGAEgASgLMh0uY29uY29yZGl1bS52Mi5BbW91bnRGcmFjdG'
    'lvblIFYmFrZXISTAoSZmluYWxpemF0aW9uX3Byb29mGAIgASgLMh0uY29uY29yZGl1bS52Mi5B'
    'bW91bnRGcmFjdGlvblIRZmluYWxpemF0aW9uUHJvb2YSSAoQYWNjb3VudF9jcmVhdGlvbhgDIA'
    'EoCzIdLmNvbmNvcmRpdW0udjIuQW1vdW50RnJhY3Rpb25SD2FjY291bnRDcmVhdGlvbhJACgxj'
    'aGFpbl91cGRhdGUYBCABKAsyHS5jb25jb3JkaXVtLnYyLkFtb3VudEZyYWN0aW9uUgtjaGFpbl'
    'VwZGF0ZQ==');

@$core.Deprecated('Use gasRewardsCpv2Descriptor instead')
const GasRewardsCpv2$json = {
  '1': 'GasRewardsCpv2',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'baker'},
    {'1': 'account_creation', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'accountCreation'},
    {'1': 'chain_update', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AmountFraction', '10': 'chainUpdate'},
  ],
};

/// Descriptor for `GasRewardsCpv2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gasRewardsCpv2Descriptor = $convert.base64Decode(
    'Cg5HYXNSZXdhcmRzQ3B2MhIzCgViYWtlchgBIAEoCzIdLmNvbmNvcmRpdW0udjIuQW1vdW50Rn'
    'JhY3Rpb25SBWJha2VyEkgKEGFjY291bnRfY3JlYXRpb24YAyABKAsyHS5jb25jb3JkaXVtLnYy'
    'LkFtb3VudEZyYWN0aW9uUg9hY2NvdW50Q3JlYXRpb24SQAoMY2hhaW5fdXBkYXRlGAQgASgLMh'
    '0uY29uY29yZGl1bS52Mi5BbW91bnRGcmFjdGlvblILY2hhaW5VcGRhdGU=');

@$core.Deprecated('Use bakerStakeThresholdDescriptor instead')
const BakerStakeThreshold$json = {
  '1': 'BakerStakeThreshold',
  '2': [
    {'1': 'baker_stake_threshold', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakerStakeThreshold'},
  ],
};

/// Descriptor for `BakerStakeThreshold`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerStakeThresholdDescriptor = $convert.base64Decode(
    'ChNCYWtlclN0YWtlVGhyZXNob2xkEkkKFWJha2VyX3N0YWtlX3RocmVzaG9sZBgBIAEoCzIVLm'
    'NvbmNvcmRpdW0udjIuQW1vdW50UhNiYWtlclN0YWtlVGhyZXNob2xk');

@$core.Deprecated('Use rootUpdateDescriptor instead')
const RootUpdate$json = {
  '1': 'RootUpdate',
  '2': [
    {'1': 'root_keys_update', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '9': 0, '10': 'rootKeysUpdate'},
    {'1': 'level_1_keys_update', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '9': 0, '10': 'level1KeysUpdate'},
    {'1': 'level_2_keys_update_v0', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV0', '9': 0, '10': 'level2KeysUpdateV0'},
    {'1': 'level_2_keys_update_v1', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV1', '9': 0, '10': 'level2KeysUpdateV1'},
  ],
  '8': [
    {'1': 'update_type'},
  ],
};

/// Descriptor for `RootUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rootUpdateDescriptor = $convert.base64Decode(
    'CgpSb290VXBkYXRlEkoKEHJvb3Rfa2V5c191cGRhdGUYASABKAsyHi5jb25jb3JkaXVtLnYyLk'
    'hpZ2hlckxldmVsS2V5c0gAUg5yb290S2V5c1VwZGF0ZRJPChNsZXZlbF8xX2tleXNfdXBkYXRl'
    'GAIgASgLMh4uY29uY29yZGl1bS52Mi5IaWdoZXJMZXZlbEtleXNIAFIQbGV2ZWwxS2V5c1VwZG'
    'F0ZRJVChZsZXZlbF8yX2tleXNfdXBkYXRlX3YwGAMgASgLMh8uY29uY29yZGl1bS52Mi5BdXRo'
    'b3JpemF0aW9uc1YwSABSEmxldmVsMktleXNVcGRhdGVWMBJVChZsZXZlbF8yX2tleXNfdXBkYX'
    'RlX3YxGAQgASgLMh8uY29uY29yZGl1bS52Mi5BdXRob3JpemF0aW9uc1YxSABSEmxldmVsMktl'
    'eXNVcGRhdGVWMUINCgt1cGRhdGVfdHlwZQ==');

@$core.Deprecated('Use level1UpdateDescriptor instead')
const Level1Update$json = {
  '1': 'Level1Update',
  '2': [
    {'1': 'level_1_keys_update', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '9': 0, '10': 'level1KeysUpdate'},
    {'1': 'level_2_keys_update_v0', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV0', '9': 0, '10': 'level2KeysUpdateV0'},
    {'1': 'level_2_keys_update_v1', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV1', '9': 0, '10': 'level2KeysUpdateV1'},
  ],
  '8': [
    {'1': 'update_type'},
  ],
};

/// Descriptor for `Level1Update`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List level1UpdateDescriptor = $convert.base64Decode(
    'CgxMZXZlbDFVcGRhdGUSTwoTbGV2ZWxfMV9rZXlzX3VwZGF0ZRgBIAEoCzIeLmNvbmNvcmRpdW'
    '0udjIuSGlnaGVyTGV2ZWxLZXlzSABSEGxldmVsMUtleXNVcGRhdGUSVQoWbGV2ZWxfMl9rZXlz'
    'X3VwZGF0ZV92MBgCIAEoCzIfLmNvbmNvcmRpdW0udjIuQXV0aG9yaXphdGlvbnNWMEgAUhJsZX'
    'ZlbDJLZXlzVXBkYXRlVjASVQoWbGV2ZWxfMl9rZXlzX3VwZGF0ZV92MRgDIAEoCzIfLmNvbmNv'
    'cmRpdW0udjIuQXV0aG9yaXphdGlvbnNWMUgAUhJsZXZlbDJLZXlzVXBkYXRlVjFCDQoLdXBkYX'
    'RlX3R5cGU=');

@$core.Deprecated('Use updatePayloadDescriptor instead')
const UpdatePayload$json = {
  '1': 'UpdatePayload',
  '2': [
    {'1': 'protocol_update', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ProtocolUpdate', '9': 0, '10': 'protocolUpdate'},
    {'1': 'election_difficulty_update', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ElectionDifficulty', '9': 0, '10': 'electionDifficultyUpdate'},
    {'1': 'euro_per_energy_update', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '9': 0, '10': 'euroPerEnergyUpdate'},
    {'1': 'micro_ccd_per_euro_update', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '9': 0, '10': 'microCcdPerEuroUpdate'},
    {'1': 'foundation_account_update', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'foundationAccountUpdate'},
    {'1': 'mint_distribution_update', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.MintDistributionCpv0', '9': 0, '10': 'mintDistributionUpdate'},
    {'1': 'transaction_fee_distribution_update', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.TransactionFeeDistribution', '9': 0, '10': 'transactionFeeDistributionUpdate'},
    {'1': 'gas_rewards_update', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.GasRewards', '9': 0, '10': 'gasRewardsUpdate'},
    {'1': 'baker_stake_threshold_update', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.BakerStakeThreshold', '9': 0, '10': 'bakerStakeThresholdUpdate'},
    {'1': 'root_update', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.RootUpdate', '9': 0, '10': 'rootUpdate'},
    {'1': 'level_1_update', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.Level1Update', '9': 0, '10': 'level1Update'},
    {'1': 'add_anonymity_revoker_update', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.ArInfo', '9': 0, '10': 'addAnonymityRevokerUpdate'},
    {'1': 'add_identity_provider_update', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.IpInfo', '9': 0, '10': 'addIdentityProviderUpdate'},
    {'1': 'cooldown_parameters_cpv_1_update', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.CooldownParametersCpv1', '9': 0, '10': 'cooldownParametersCpv1Update'},
    {'1': 'pool_parameters_cpv_1_update', '3': 15, '4': 1, '5': 11, '6': '.concordium.v2.PoolParametersCpv1', '9': 0, '10': 'poolParametersCpv1Update'},
    {'1': 'time_parameters_cpv_1_update', '3': 16, '4': 1, '5': 11, '6': '.concordium.v2.TimeParametersCpv1', '9': 0, '10': 'timeParametersCpv1Update'},
    {'1': 'mint_distribution_cpv_1_update', '3': 17, '4': 1, '5': 11, '6': '.concordium.v2.MintDistributionCpv1', '9': 0, '10': 'mintDistributionCpv1Update'},
    {'1': 'gas_rewards_cpv_2_update', '3': 18, '4': 1, '5': 11, '6': '.concordium.v2.GasRewardsCpv2', '9': 0, '10': 'gasRewardsCpv2Update'},
    {'1': 'timeout_parameters_update', '3': 19, '4': 1, '5': 11, '6': '.concordium.v2.TimeoutParameters', '9': 0, '10': 'timeoutParametersUpdate'},
    {'1': 'min_block_time_update', '3': 20, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '9': 0, '10': 'minBlockTimeUpdate'},
    {'1': 'block_energy_limit_update', '3': 21, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '9': 0, '10': 'blockEnergyLimitUpdate'},
    {'1': 'finalization_committee_parameters_update', '3': 22, '4': 1, '5': 11, '6': '.concordium.v2.FinalizationCommitteeParameters', '9': 0, '10': 'finalizationCommitteeParametersUpdate'},
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `UpdatePayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatePayloadDescriptor = $convert.base64Decode(
    'Cg1VcGRhdGVQYXlsb2FkEkgKD3Byb3RvY29sX3VwZGF0ZRgBIAEoCzIdLmNvbmNvcmRpdW0udj'
    'IuUHJvdG9jb2xVcGRhdGVIAFIOcHJvdG9jb2xVcGRhdGUSYQoaZWxlY3Rpb25fZGlmZmljdWx0'
    'eV91cGRhdGUYAiABKAsyIS5jb25jb3JkaXVtLnYyLkVsZWN0aW9uRGlmZmljdWx0eUgAUhhlbG'
    'VjdGlvbkRpZmZpY3VsdHlVcGRhdGUSUgoWZXVyb19wZXJfZW5lcmd5X3VwZGF0ZRgDIAEoCzIb'
    'LmNvbmNvcmRpdW0udjIuRXhjaGFuZ2VSYXRlSABSE2V1cm9QZXJFbmVyZ3lVcGRhdGUSVwoZbW'
    'ljcm9fY2NkX3Blcl9ldXJvX3VwZGF0ZRgEIAEoCzIbLmNvbmNvcmRpdW0udjIuRXhjaGFuZ2VS'
    'YXRlSABSFW1pY3JvQ2NkUGVyRXVyb1VwZGF0ZRJbChlmb3VuZGF0aW9uX2FjY291bnRfdXBkYX'
    'RlGAUgASgLMh0uY29uY29yZGl1bS52Mi5BY2NvdW50QWRkcmVzc0gAUhdmb3VuZGF0aW9uQWNj'
    'b3VudFVwZGF0ZRJfChhtaW50X2Rpc3RyaWJ1dGlvbl91cGRhdGUYBiABKAsyIy5jb25jb3JkaX'
    'VtLnYyLk1pbnREaXN0cmlidXRpb25DcHYwSABSFm1pbnREaXN0cmlidXRpb25VcGRhdGUSegoj'
    'dHJhbnNhY3Rpb25fZmVlX2Rpc3RyaWJ1dGlvbl91cGRhdGUYByABKAsyKS5jb25jb3JkaXVtLn'
    'YyLlRyYW5zYWN0aW9uRmVlRGlzdHJpYnV0aW9uSABSIHRyYW5zYWN0aW9uRmVlRGlzdHJpYnV0'
    'aW9uVXBkYXRlEkkKEmdhc19yZXdhcmRzX3VwZGF0ZRgIIAEoCzIZLmNvbmNvcmRpdW0udjIuR2'
    'FzUmV3YXJkc0gAUhBnYXNSZXdhcmRzVXBkYXRlEmUKHGJha2VyX3N0YWtlX3RocmVzaG9sZF91'
    'cGRhdGUYCSABKAsyIi5jb25jb3JkaXVtLnYyLkJha2VyU3Rha2VUaHJlc2hvbGRIAFIZYmFrZX'
    'JTdGFrZVRocmVzaG9sZFVwZGF0ZRI8Cgtyb290X3VwZGF0ZRgKIAEoCzIZLmNvbmNvcmRpdW0u'
    'djIuUm9vdFVwZGF0ZUgAUgpyb290VXBkYXRlEkMKDmxldmVsXzFfdXBkYXRlGAsgASgLMhsuY2'
    '9uY29yZGl1bS52Mi5MZXZlbDFVcGRhdGVIAFIMbGV2ZWwxVXBkYXRlElgKHGFkZF9hbm9ueW1p'
    'dHlfcmV2b2tlcl91cGRhdGUYDCABKAsyFS5jb25jb3JkaXVtLnYyLkFySW5mb0gAUhlhZGRBbm'
    '9ueW1pdHlSZXZva2VyVXBkYXRlElgKHGFkZF9pZGVudGl0eV9wcm92aWRlcl91cGRhdGUYDSAB'
    'KAsyFS5jb25jb3JkaXVtLnYyLklwSW5mb0gAUhlhZGRJZGVudGl0eVByb3ZpZGVyVXBkYXRlEm'
    '8KIGNvb2xkb3duX3BhcmFtZXRlcnNfY3B2XzFfdXBkYXRlGA4gASgLMiUuY29uY29yZGl1bS52'
    'Mi5Db29sZG93blBhcmFtZXRlcnNDcHYxSABSHGNvb2xkb3duUGFyYW1ldGVyc0NwdjFVcGRhdG'
    'USYwoccG9vbF9wYXJhbWV0ZXJzX2Nwdl8xX3VwZGF0ZRgPIAEoCzIhLmNvbmNvcmRpdW0udjIu'
    'UG9vbFBhcmFtZXRlcnNDcHYxSABSGHBvb2xQYXJhbWV0ZXJzQ3B2MVVwZGF0ZRJjChx0aW1lX3'
    'BhcmFtZXRlcnNfY3B2XzFfdXBkYXRlGBAgASgLMiEuY29uY29yZGl1bS52Mi5UaW1lUGFyYW1l'
    'dGVyc0NwdjFIAFIYdGltZVBhcmFtZXRlcnNDcHYxVXBkYXRlEmkKHm1pbnRfZGlzdHJpYnV0aW'
    '9uX2Nwdl8xX3VwZGF0ZRgRIAEoCzIjLmNvbmNvcmRpdW0udjIuTWludERpc3RyaWJ1dGlvbkNw'
    'djFIAFIabWludERpc3RyaWJ1dGlvbkNwdjFVcGRhdGUSVwoYZ2FzX3Jld2FyZHNfY3B2XzJfdX'
    'BkYXRlGBIgASgLMh0uY29uY29yZGl1bS52Mi5HYXNSZXdhcmRzQ3B2MkgAUhRnYXNSZXdhcmRz'
    'Q3B2MlVwZGF0ZRJeChl0aW1lb3V0X3BhcmFtZXRlcnNfdXBkYXRlGBMgASgLMiAuY29uY29yZG'
    'l1bS52Mi5UaW1lb3V0UGFyYW1ldGVyc0gAUhd0aW1lb3V0UGFyYW1ldGVyc1VwZGF0ZRJMChVt'
    'aW5fYmxvY2tfdGltZV91cGRhdGUYFCABKAsyFy5jb25jb3JkaXVtLnYyLkR1cmF0aW9uSABSEm'
    '1pbkJsb2NrVGltZVVwZGF0ZRJSChlibG9ja19lbmVyZ3lfbGltaXRfdXBkYXRlGBUgASgLMhUu'
    'Y29uY29yZGl1bS52Mi5FbmVyZ3lIAFIWYmxvY2tFbmVyZ3lMaW1pdFVwZGF0ZRKJAQooZmluYW'
    'xpemF0aW9uX2NvbW1pdHRlZV9wYXJhbWV0ZXJzX3VwZGF0ZRgWIAEoCzIuLmNvbmNvcmRpdW0u'
    'djIuRmluYWxpemF0aW9uQ29tbWl0dGVlUGFyYW1ldGVyc0gAUiVmaW5hbGl6YXRpb25Db21taX'
    'R0ZWVQYXJhbWV0ZXJzVXBkYXRlQgkKB3BheWxvYWQ=');

@$core.Deprecated('Use accountTransactionDetailsDescriptor instead')
const AccountTransactionDetails$json = {
  '1': 'AccountTransactionDetails',
  '2': [
    {'1': 'cost', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'cost'},
    {'1': 'sender', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'sender'},
    {'1': 'effects', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionEffects', '10': 'effects'},
  ],
};

/// Descriptor for `AccountTransactionDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountTransactionDetailsDescriptor = $convert.base64Decode(
    'ChlBY2NvdW50VHJhbnNhY3Rpb25EZXRhaWxzEikKBGNvc3QYASABKAsyFS5jb25jb3JkaXVtLn'
    'YyLkFtb3VudFIEY29zdBI1CgZzZW5kZXIYAiABKAsyHS5jb25jb3JkaXVtLnYyLkFjY291bnRB'
    'ZGRyZXNzUgZzZW5kZXISQgoHZWZmZWN0cxgDIAEoCzIoLmNvbmNvcmRpdW0udjIuQWNjb3VudF'
    'RyYW5zYWN0aW9uRWZmZWN0c1IHZWZmZWN0cw==');

@$core.Deprecated('Use accountCreationDetailsDescriptor instead')
const AccountCreationDetails$json = {
  '1': 'AccountCreationDetails',
  '2': [
    {'1': 'credential_type', '3': 1, '4': 1, '5': 14, '6': '.concordium.v2.CredentialType', '10': 'credentialType'},
    {'1': 'address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'address'},
    {'1': 'reg_id', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.CredentialRegistrationId', '10': 'regId'},
  ],
};

/// Descriptor for `AccountCreationDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountCreationDetailsDescriptor = $convert.base64Decode(
    'ChZBY2NvdW50Q3JlYXRpb25EZXRhaWxzEkYKD2NyZWRlbnRpYWxfdHlwZRgBIAEoDjIdLmNvbm'
    'NvcmRpdW0udjIuQ3JlZGVudGlhbFR5cGVSDmNyZWRlbnRpYWxUeXBlEjcKB2FkZHJlc3MYAiAB'
    'KAsyHS5jb25jb3JkaXVtLnYyLkFjY291bnRBZGRyZXNzUgdhZGRyZXNzEj4KBnJlZ19pZBgDIA'
    'EoCzInLmNvbmNvcmRpdW0udjIuQ3JlZGVudGlhbFJlZ2lzdHJhdGlvbklkUgVyZWdJZA==');

@$core.Deprecated('Use transactionTimeDescriptor instead')
const TransactionTime$json = {
  '1': 'TransactionTime',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `TransactionTime`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionTimeDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvblRpbWUSFAoFdmFsdWUYASABKARSBXZhbHVl');

@$core.Deprecated('Use updateDetailsDescriptor instead')
const UpdateDetails$json = {
  '1': 'UpdateDetails',
  '2': [
    {'1': 'effective_time', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.TransactionTime', '10': 'effectiveTime'},
    {'1': 'payload', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.UpdatePayload', '10': 'payload'},
  ],
};

/// Descriptor for `UpdateDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDetailsDescriptor = $convert.base64Decode(
    'Cg1VcGRhdGVEZXRhaWxzEkUKDmVmZmVjdGl2ZV90aW1lGAEgASgLMh4uY29uY29yZGl1bS52Mi'
    '5UcmFuc2FjdGlvblRpbWVSDWVmZmVjdGl2ZVRpbWUSNgoHcGF5bG9hZBgCIAEoCzIcLmNvbmNv'
    'cmRpdW0udjIuVXBkYXRlUGF5bG9hZFIHcGF5bG9hZA==');

@$core.Deprecated('Use blockItemSummaryDescriptor instead')
const BlockItemSummary$json = {
  '1': 'BlockItemSummary',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockItemSummary.TransactionIndex', '10': 'index'},
    {'1': 'energy_cost', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'energyCost'},
    {'1': 'hash', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.TransactionHash', '10': 'hash'},
    {'1': 'account_transaction', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionDetails', '9': 0, '10': 'accountTransaction'},
    {'1': 'account_creation', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.AccountCreationDetails', '9': 0, '10': 'accountCreation'},
    {'1': 'update', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.UpdateDetails', '9': 0, '10': 'update'},
  ],
  '3': [BlockItemSummary_TransactionIndex$json],
  '8': [
    {'1': 'details'},
  ],
};

@$core.Deprecated('Use blockItemSummaryDescriptor instead')
const BlockItemSummary_TransactionIndex$json = {
  '1': 'TransactionIndex',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `BlockItemSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockItemSummaryDescriptor = $convert.base64Decode(
    'ChBCbG9ja0l0ZW1TdW1tYXJ5EkYKBWluZGV4GAEgASgLMjAuY29uY29yZGl1bS52Mi5CbG9ja0'
    'l0ZW1TdW1tYXJ5LlRyYW5zYWN0aW9uSW5kZXhSBWluZGV4EjYKC2VuZXJneV9jb3N0GAIgASgL'
    'MhUuY29uY29yZGl1bS52Mi5FbmVyZ3lSCmVuZXJneUNvc3QSMgoEaGFzaBgDIAEoCzIeLmNvbm'
    'NvcmRpdW0udjIuVHJhbnNhY3Rpb25IYXNoUgRoYXNoElsKE2FjY291bnRfdHJhbnNhY3Rpb24Y'
    'BCABKAsyKC5jb25jb3JkaXVtLnYyLkFjY291bnRUcmFuc2FjdGlvbkRldGFpbHNIAFISYWNjb3'
    'VudFRyYW5zYWN0aW9uElIKEGFjY291bnRfY3JlYXRpb24YBSABKAsyJS5jb25jb3JkaXVtLnYy'
    'LkFjY291bnRDcmVhdGlvbkRldGFpbHNIAFIPYWNjb3VudENyZWF0aW9uEjYKBnVwZGF0ZRgGIA'
    'EoCzIcLmNvbmNvcmRpdW0udjIuVXBkYXRlRGV0YWlsc0gAUgZ1cGRhdGUaKAoQVHJhbnNhY3Rp'
    'b25JbmRleBIUCgV2YWx1ZRgBIAEoBFIFdmFsdWVCCQoHZGV0YWlscw==');

@$core.Deprecated('Use genesisIndexDescriptor instead')
const GenesisIndex$json = {
  '1': 'GenesisIndex',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `GenesisIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List genesisIndexDescriptor = $convert.base64Decode(
    'CgxHZW5lc2lzSW5kZXgSFAoFdmFsdWUYASABKA1SBXZhbHVl');

@$core.Deprecated('Use consensusInfoDescriptor instead')
const ConsensusInfo$json = {
  '1': 'ConsensusInfo',
  '2': [
    {'1': 'best_block', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'bestBlock'},
    {'1': 'genesis_block', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'genesisBlock'},
    {'1': 'genesis_time', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'genesisTime'},
    {'1': 'slot_duration', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '9': 0, '10': 'slotDuration', '17': true},
    {'1': 'epoch_duration', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '10': 'epochDuration'},
    {'1': 'last_finalized_block', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'lastFinalizedBlock'},
    {'1': 'best_block_height', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.AbsoluteBlockHeight', '10': 'bestBlockHeight'},
    {'1': 'last_finalized_block_height', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.AbsoluteBlockHeight', '10': 'lastFinalizedBlockHeight'},
    {'1': 'blocks_received_count', '3': 9, '4': 1, '5': 13, '10': 'blocksReceivedCount'},
    {'1': 'block_last_received_time', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '9': 1, '10': 'blockLastReceivedTime', '17': true},
    {'1': 'block_receive_latency_ema', '3': 11, '4': 1, '5': 1, '10': 'blockReceiveLatencyEma'},
    {'1': 'block_receive_latency_emsd', '3': 12, '4': 1, '5': 1, '10': 'blockReceiveLatencyEmsd'},
    {'1': 'block_receive_period_ema', '3': 13, '4': 1, '5': 1, '9': 2, '10': 'blockReceivePeriodEma', '17': true},
    {'1': 'block_receive_period_emsd', '3': 14, '4': 1, '5': 1, '9': 3, '10': 'blockReceivePeriodEmsd', '17': true},
    {'1': 'blocks_verified_count', '3': 15, '4': 1, '5': 13, '10': 'blocksVerifiedCount'},
    {'1': 'block_last_arrived_time', '3': 16, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '9': 4, '10': 'blockLastArrivedTime', '17': true},
    {'1': 'block_arrive_latency_ema', '3': 17, '4': 1, '5': 1, '10': 'blockArriveLatencyEma'},
    {'1': 'block_arrive_latency_emsd', '3': 18, '4': 1, '5': 1, '10': 'blockArriveLatencyEmsd'},
    {'1': 'block_arrive_period_ema', '3': 19, '4': 1, '5': 1, '9': 5, '10': 'blockArrivePeriodEma', '17': true},
    {'1': 'block_arrive_period_emsd', '3': 20, '4': 1, '5': 1, '9': 6, '10': 'blockArrivePeriodEmsd', '17': true},
    {'1': 'transactions_per_block_ema', '3': 21, '4': 1, '5': 1, '10': 'transactionsPerBlockEma'},
    {'1': 'transactions_per_block_emsd', '3': 22, '4': 1, '5': 1, '10': 'transactionsPerBlockEmsd'},
    {'1': 'finalization_count', '3': 23, '4': 1, '5': 13, '10': 'finalizationCount'},
    {'1': 'last_finalized_time', '3': 24, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '9': 7, '10': 'lastFinalizedTime', '17': true},
    {'1': 'finalization_period_ema', '3': 25, '4': 1, '5': 1, '9': 8, '10': 'finalizationPeriodEma', '17': true},
    {'1': 'finalization_period_emsd', '3': 26, '4': 1, '5': 1, '9': 9, '10': 'finalizationPeriodEmsd', '17': true},
    {'1': 'protocol_version', '3': 27, '4': 1, '5': 14, '6': '.concordium.v2.ProtocolVersion', '10': 'protocolVersion'},
    {'1': 'genesis_index', '3': 28, '4': 1, '5': 11, '6': '.concordium.v2.GenesisIndex', '10': 'genesisIndex'},
    {'1': 'current_era_genesis_block', '3': 29, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'currentEraGenesisBlock'},
    {'1': 'current_era_genesis_time', '3': 30, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'currentEraGenesisTime'},
    {'1': 'current_timeout_duration', '3': 31, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '9': 10, '10': 'currentTimeoutDuration', '17': true},
    {'1': 'current_round', '3': 32, '4': 1, '5': 11, '6': '.concordium.v2.Round', '9': 11, '10': 'currentRound', '17': true},
    {'1': 'current_epoch', '3': 33, '4': 1, '5': 11, '6': '.concordium.v2.Epoch', '9': 12, '10': 'currentEpoch', '17': true},
    {'1': 'trigger_block_time', '3': 34, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '9': 13, '10': 'triggerBlockTime', '17': true},
  ],
  '8': [
    {'1': '_slot_duration'},
    {'1': '_block_last_received_time'},
    {'1': '_block_receive_period_ema'},
    {'1': '_block_receive_period_emsd'},
    {'1': '_block_last_arrived_time'},
    {'1': '_block_arrive_period_ema'},
    {'1': '_block_arrive_period_emsd'},
    {'1': '_last_finalized_time'},
    {'1': '_finalization_period_ema'},
    {'1': '_finalization_period_emsd'},
    {'1': '_current_timeout_duration'},
    {'1': '_current_round'},
    {'1': '_current_epoch'},
    {'1': '_trigger_block_time'},
  ],
};

/// Descriptor for `ConsensusInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List consensusInfoDescriptor = $convert.base64Decode(
    'Cg1Db25zZW5zdXNJbmZvEjcKCmJlc3RfYmxvY2sYASABKAsyGC5jb25jb3JkaXVtLnYyLkJsb2'
    'NrSGFzaFIJYmVzdEJsb2NrEj0KDWdlbmVzaXNfYmxvY2sYAiABKAsyGC5jb25jb3JkaXVtLnYy'
    'LkJsb2NrSGFzaFIMZ2VuZXNpc0Jsb2NrEjsKDGdlbmVzaXNfdGltZRgDIAEoCzIYLmNvbmNvcm'
    'RpdW0udjIuVGltZXN0YW1wUgtnZW5lc2lzVGltZRJBCg1zbG90X2R1cmF0aW9uGAQgASgLMhcu'
    'Y29uY29yZGl1bS52Mi5EdXJhdGlvbkgAUgxzbG90RHVyYXRpb26IAQESPgoOZXBvY2hfZHVyYX'
    'Rpb24YBSABKAsyFy5jb25jb3JkaXVtLnYyLkR1cmF0aW9uUg1lcG9jaER1cmF0aW9uEkoKFGxh'
    'c3RfZmluYWxpemVkX2Jsb2NrGAYgASgLMhguY29uY29yZGl1bS52Mi5CbG9ja0hhc2hSEmxhc3'
    'RGaW5hbGl6ZWRCbG9jaxJOChFiZXN0X2Jsb2NrX2hlaWdodBgHIAEoCzIiLmNvbmNvcmRpdW0u'
    'djIuQWJzb2x1dGVCbG9ja0hlaWdodFIPYmVzdEJsb2NrSGVpZ2h0EmEKG2xhc3RfZmluYWxpem'
    'VkX2Jsb2NrX2hlaWdodBgIIAEoCzIiLmNvbmNvcmRpdW0udjIuQWJzb2x1dGVCbG9ja0hlaWdo'
    'dFIYbGFzdEZpbmFsaXplZEJsb2NrSGVpZ2h0EjIKFWJsb2Nrc19yZWNlaXZlZF9jb3VudBgJIA'
    'EoDVITYmxvY2tzUmVjZWl2ZWRDb3VudBJWChhibG9ja19sYXN0X3JlY2VpdmVkX3RpbWUYCiAB'
    'KAsyGC5jb25jb3JkaXVtLnYyLlRpbWVzdGFtcEgBUhVibG9ja0xhc3RSZWNlaXZlZFRpbWWIAQ'
    'ESOQoZYmxvY2tfcmVjZWl2ZV9sYXRlbmN5X2VtYRgLIAEoAVIWYmxvY2tSZWNlaXZlTGF0ZW5j'
    'eUVtYRI7ChpibG9ja19yZWNlaXZlX2xhdGVuY3lfZW1zZBgMIAEoAVIXYmxvY2tSZWNlaXZlTG'
    'F0ZW5jeUVtc2QSPAoYYmxvY2tfcmVjZWl2ZV9wZXJpb2RfZW1hGA0gASgBSAJSFWJsb2NrUmVj'
    'ZWl2ZVBlcmlvZEVtYYgBARI+ChlibG9ja19yZWNlaXZlX3BlcmlvZF9lbXNkGA4gASgBSANSFm'
    'Jsb2NrUmVjZWl2ZVBlcmlvZEVtc2SIAQESMgoVYmxvY2tzX3ZlcmlmaWVkX2NvdW50GA8gASgN'
    'UhNibG9ja3NWZXJpZmllZENvdW50ElQKF2Jsb2NrX2xhc3RfYXJyaXZlZF90aW1lGBAgASgLMh'
    'guY29uY29yZGl1bS52Mi5UaW1lc3RhbXBIBFIUYmxvY2tMYXN0QXJyaXZlZFRpbWWIAQESNwoY'
    'YmxvY2tfYXJyaXZlX2xhdGVuY3lfZW1hGBEgASgBUhVibG9ja0Fycml2ZUxhdGVuY3lFbWESOQ'
    'oZYmxvY2tfYXJyaXZlX2xhdGVuY3lfZW1zZBgSIAEoAVIWYmxvY2tBcnJpdmVMYXRlbmN5RW1z'
    'ZBI6ChdibG9ja19hcnJpdmVfcGVyaW9kX2VtYRgTIAEoAUgFUhRibG9ja0Fycml2ZVBlcmlvZE'
    'VtYYgBARI8ChhibG9ja19hcnJpdmVfcGVyaW9kX2Vtc2QYFCABKAFIBlIVYmxvY2tBcnJpdmVQ'
    'ZXJpb2RFbXNkiAEBEjsKGnRyYW5zYWN0aW9uc19wZXJfYmxvY2tfZW1hGBUgASgBUhd0cmFuc2'
    'FjdGlvbnNQZXJCbG9ja0VtYRI9Cht0cmFuc2FjdGlvbnNfcGVyX2Jsb2NrX2Vtc2QYFiABKAFS'
    'GHRyYW5zYWN0aW9uc1BlckJsb2NrRW1zZBItChJmaW5hbGl6YXRpb25fY291bnQYFyABKA1SEW'
    'ZpbmFsaXphdGlvbkNvdW50Ek0KE2xhc3RfZmluYWxpemVkX3RpbWUYGCABKAsyGC5jb25jb3Jk'
    'aXVtLnYyLlRpbWVzdGFtcEgHUhFsYXN0RmluYWxpemVkVGltZYgBARI7ChdmaW5hbGl6YXRpb2'
    '5fcGVyaW9kX2VtYRgZIAEoAUgIUhVmaW5hbGl6YXRpb25QZXJpb2RFbWGIAQESPQoYZmluYWxp'
    'emF0aW9uX3BlcmlvZF9lbXNkGBogASgBSAlSFmZpbmFsaXphdGlvblBlcmlvZEVtc2SIAQESSQ'
    'oQcHJvdG9jb2xfdmVyc2lvbhgbIAEoDjIeLmNvbmNvcmRpdW0udjIuUHJvdG9jb2xWZXJzaW9u'
    'Ug9wcm90b2NvbFZlcnNpb24SQAoNZ2VuZXNpc19pbmRleBgcIAEoCzIbLmNvbmNvcmRpdW0udj'
    'IuR2VuZXNpc0luZGV4UgxnZW5lc2lzSW5kZXgSUwoZY3VycmVudF9lcmFfZ2VuZXNpc19ibG9j'
    'axgdIAEoCzIYLmNvbmNvcmRpdW0udjIuQmxvY2tIYXNoUhZjdXJyZW50RXJhR2VuZXNpc0Jsb2'
    'NrElEKGGN1cnJlbnRfZXJhX2dlbmVzaXNfdGltZRgeIAEoCzIYLmNvbmNvcmRpdW0udjIuVGlt'
    'ZXN0YW1wUhVjdXJyZW50RXJhR2VuZXNpc1RpbWUSVgoYY3VycmVudF90aW1lb3V0X2R1cmF0aW'
    '9uGB8gASgLMhcuY29uY29yZGl1bS52Mi5EdXJhdGlvbkgKUhZjdXJyZW50VGltZW91dER1cmF0'
    'aW9uiAEBEj4KDWN1cnJlbnRfcm91bmQYICABKAsyFC5jb25jb3JkaXVtLnYyLlJvdW5kSAtSDG'
    'N1cnJlbnRSb3VuZIgBARI+Cg1jdXJyZW50X2Vwb2NoGCEgASgLMhQuY29uY29yZGl1bS52Mi5F'
    'cG9jaEgMUgxjdXJyZW50RXBvY2iIAQESSwoSdHJpZ2dlcl9ibG9ja190aW1lGCIgASgLMhguY2'
    '9uY29yZGl1bS52Mi5UaW1lc3RhbXBIDVIQdHJpZ2dlckJsb2NrVGltZYgBAUIQCg5fc2xvdF9k'
    'dXJhdGlvbkIbChlfYmxvY2tfbGFzdF9yZWNlaXZlZF90aW1lQhsKGV9ibG9ja19yZWNlaXZlX3'
    'BlcmlvZF9lbWFCHAoaX2Jsb2NrX3JlY2VpdmVfcGVyaW9kX2Vtc2RCGgoYX2Jsb2NrX2xhc3Rf'
    'YXJyaXZlZF90aW1lQhoKGF9ibG9ja19hcnJpdmVfcGVyaW9kX2VtYUIbChlfYmxvY2tfYXJyaX'
    'ZlX3BlcmlvZF9lbXNkQhYKFF9sYXN0X2ZpbmFsaXplZF90aW1lQhoKGF9maW5hbGl6YXRpb25f'
    'cGVyaW9kX2VtYUIbChlfZmluYWxpemF0aW9uX3BlcmlvZF9lbXNkQhsKGV9jdXJyZW50X3RpbW'
    'VvdXRfZHVyYXRpb25CEAoOX2N1cnJlbnRfcm91bmRCEAoOX2N1cnJlbnRfZXBvY2hCFQoTX3Ry'
    'aWdnZXJfYmxvY2tfdGltZQ==');

@$core.Deprecated('Use arrivedBlockInfoDescriptor instead')
const ArrivedBlockInfo$json = {
  '1': 'ArrivedBlockInfo',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'hash'},
    {'1': 'height', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AbsoluteBlockHeight', '10': 'height'},
  ],
};

/// Descriptor for `ArrivedBlockInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List arrivedBlockInfoDescriptor = $convert.base64Decode(
    'ChBBcnJpdmVkQmxvY2tJbmZvEiwKBGhhc2gYASABKAsyGC5jb25jb3JkaXVtLnYyLkJsb2NrSG'
    'FzaFIEaGFzaBI6CgZoZWlnaHQYAiABKAsyIi5jb25jb3JkaXVtLnYyLkFic29sdXRlQmxvY2tI'
    'ZWlnaHRSBmhlaWdodA==');

@$core.Deprecated('Use cryptographicParametersDescriptor instead')
const CryptographicParameters$json = {
  '1': 'CryptographicParameters',
  '2': [
    {'1': 'genesis_string', '3': 1, '4': 1, '5': 9, '10': 'genesisString'},
    {'1': 'bulletproof_generators', '3': 2, '4': 1, '5': 12, '10': 'bulletproofGenerators'},
    {'1': 'on_chain_commitment_key', '3': 3, '4': 1, '5': 12, '10': 'onChainCommitmentKey'},
  ],
};

/// Descriptor for `CryptographicParameters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cryptographicParametersDescriptor = $convert.base64Decode(
    'ChdDcnlwdG9ncmFwaGljUGFyYW1ldGVycxIlCg5nZW5lc2lzX3N0cmluZxgBIAEoCVINZ2VuZX'
    'Npc1N0cmluZxI1ChZidWxsZXRwcm9vZl9nZW5lcmF0b3JzGAIgASgMUhVidWxsZXRwcm9vZkdl'
    'bmVyYXRvcnMSNQoXb25fY2hhaW5fY29tbWl0bWVudF9rZXkYAyABKAxSFG9uQ2hhaW5Db21taX'
    'RtZW50S2V5');

@$core.Deprecated('Use blockInfoDescriptor instead')
const BlockInfo$json = {
  '1': 'BlockInfo',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'hash'},
    {'1': 'height', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AbsoluteBlockHeight', '10': 'height'},
    {'1': 'parent_block', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'parentBlock'},
    {'1': 'last_finalized_block', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'lastFinalizedBlock'},
    {'1': 'genesis_index', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.GenesisIndex', '10': 'genesisIndex'},
    {'1': 'era_block_height', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.BlockHeight', '10': 'eraBlockHeight'},
    {'1': 'receive_time', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'receiveTime'},
    {'1': 'arrive_time', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'arriveTime'},
    {'1': 'slot_number', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.Slot', '9': 0, '10': 'slotNumber', '17': true},
    {'1': 'slot_time', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'slotTime'},
    {'1': 'baker', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '9': 1, '10': 'baker', '17': true},
    {'1': 'finalized', '3': 12, '4': 1, '5': 8, '10': 'finalized'},
    {'1': 'transaction_count', '3': 13, '4': 1, '5': 13, '10': 'transactionCount'},
    {'1': 'transactions_energy_cost', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'transactionsEnergyCost'},
    {'1': 'transactions_size', '3': 15, '4': 1, '5': 13, '10': 'transactionsSize'},
    {'1': 'state_hash', '3': 16, '4': 1, '5': 11, '6': '.concordium.v2.StateHash', '10': 'stateHash'},
    {'1': 'protocol_version', '3': 17, '4': 1, '5': 14, '6': '.concordium.v2.ProtocolVersion', '10': 'protocolVersion'},
    {'1': 'round', '3': 18, '4': 1, '5': 11, '6': '.concordium.v2.Round', '9': 2, '10': 'round', '17': true},
    {'1': 'epoch', '3': 19, '4': 1, '5': 11, '6': '.concordium.v2.Epoch', '9': 3, '10': 'epoch', '17': true},
  ],
  '8': [
    {'1': '_slot_number'},
    {'1': '_baker'},
    {'1': '_round'},
    {'1': '_epoch'},
  ],
};

/// Descriptor for `BlockInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockInfoDescriptor = $convert.base64Decode(
    'CglCbG9ja0luZm8SLAoEaGFzaBgBIAEoCzIYLmNvbmNvcmRpdW0udjIuQmxvY2tIYXNoUgRoYX'
    'NoEjoKBmhlaWdodBgCIAEoCzIiLmNvbmNvcmRpdW0udjIuQWJzb2x1dGVCbG9ja0hlaWdodFIG'
    'aGVpZ2h0EjsKDHBhcmVudF9ibG9jaxgDIAEoCzIYLmNvbmNvcmRpdW0udjIuQmxvY2tIYXNoUg'
    'twYXJlbnRCbG9jaxJKChRsYXN0X2ZpbmFsaXplZF9ibG9jaxgEIAEoCzIYLmNvbmNvcmRpdW0u'
    'djIuQmxvY2tIYXNoUhJsYXN0RmluYWxpemVkQmxvY2sSQAoNZ2VuZXNpc19pbmRleBgFIAEoCz'
    'IbLmNvbmNvcmRpdW0udjIuR2VuZXNpc0luZGV4UgxnZW5lc2lzSW5kZXgSRAoQZXJhX2Jsb2Nr'
    'X2hlaWdodBgGIAEoCzIaLmNvbmNvcmRpdW0udjIuQmxvY2tIZWlnaHRSDmVyYUJsb2NrSGVpZ2'
    'h0EjsKDHJlY2VpdmVfdGltZRgHIAEoCzIYLmNvbmNvcmRpdW0udjIuVGltZXN0YW1wUgtyZWNl'
    'aXZlVGltZRI5CgthcnJpdmVfdGltZRgIIAEoCzIYLmNvbmNvcmRpdW0udjIuVGltZXN0YW1wUg'
    'phcnJpdmVUaW1lEjkKC3Nsb3RfbnVtYmVyGAkgASgLMhMuY29uY29yZGl1bS52Mi5TbG90SABS'
    'CnNsb3ROdW1iZXKIAQESNQoJc2xvdF90aW1lGAogASgLMhguY29uY29yZGl1bS52Mi5UaW1lc3'
    'RhbXBSCHNsb3RUaW1lEjEKBWJha2VyGAsgASgLMhYuY29uY29yZGl1bS52Mi5CYWtlcklkSAFS'
    'BWJha2VyiAEBEhwKCWZpbmFsaXplZBgMIAEoCFIJZmluYWxpemVkEisKEXRyYW5zYWN0aW9uX2'
    'NvdW50GA0gASgNUhB0cmFuc2FjdGlvbkNvdW50Ek8KGHRyYW5zYWN0aW9uc19lbmVyZ3lfY29z'
    'dBgOIAEoCzIVLmNvbmNvcmRpdW0udjIuRW5lcmd5UhZ0cmFuc2FjdGlvbnNFbmVyZ3lDb3N0Ei'
    'sKEXRyYW5zYWN0aW9uc19zaXplGA8gASgNUhB0cmFuc2FjdGlvbnNTaXplEjcKCnN0YXRlX2hh'
    'c2gYECABKAsyGC5jb25jb3JkaXVtLnYyLlN0YXRlSGFzaFIJc3RhdGVIYXNoEkkKEHByb3RvY2'
    '9sX3ZlcnNpb24YESABKA4yHi5jb25jb3JkaXVtLnYyLlByb3RvY29sVmVyc2lvblIPcHJvdG9j'
    'b2xWZXJzaW9uEi8KBXJvdW5kGBIgASgLMhQuY29uY29yZGl1bS52Mi5Sb3VuZEgCUgVyb3VuZI'
    'gBARIvCgVlcG9jaBgTIAEoCzIULmNvbmNvcmRpdW0udjIuRXBvY2hIA1IFZXBvY2iIAQFCDgoM'
    'X3Nsb3RfbnVtYmVyQggKBl9iYWtlckIICgZfcm91bmRCCAoGX2Vwb2No');

@$core.Deprecated('Use poolInfoRequestDescriptor instead')
const PoolInfoRequest$json = {
  '1': 'PoolInfoRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'baker', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'baker'},
  ],
};

/// Descriptor for `PoolInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List poolInfoRequestDescriptor = $convert.base64Decode(
    'Cg9Qb29sSW5mb1JlcXVlc3QSPAoKYmxvY2tfaGFzaBgBIAEoCzIdLmNvbmNvcmRpdW0udjIuQm'
    'xvY2tIYXNoSW5wdXRSCWJsb2NrSGFzaBIsCgViYWtlchgCIAEoCzIWLmNvbmNvcmRpdW0udjIu'
    'QmFrZXJJZFIFYmFrZXI=');

@$core.Deprecated('Use poolPendingChangeDescriptor instead')
const PoolPendingChange$json = {
  '1': 'PoolPendingChange',
  '2': [
    {'1': 'reduce', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.PoolPendingChange.Reduce', '9': 0, '10': 'reduce'},
    {'1': 'remove', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.PoolPendingChange.Remove', '9': 0, '10': 'remove'},
  ],
  '3': [PoolPendingChange_Reduce$json, PoolPendingChange_Remove$json],
  '8': [
    {'1': 'change'},
  ],
};

@$core.Deprecated('Use poolPendingChangeDescriptor instead')
const PoolPendingChange_Reduce$json = {
  '1': 'Reduce',
  '2': [
    {'1': 'reduced_equity_capital', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'reducedEquityCapital'},
    {'1': 'effective_time', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'effectiveTime'},
  ],
};

@$core.Deprecated('Use poolPendingChangeDescriptor instead')
const PoolPendingChange_Remove$json = {
  '1': 'Remove',
  '2': [
    {'1': 'effective_time', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'effectiveTime'},
  ],
};

/// Descriptor for `PoolPendingChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List poolPendingChangeDescriptor = $convert.base64Decode(
    'ChFQb29sUGVuZGluZ0NoYW5nZRJBCgZyZWR1Y2UYASABKAsyJy5jb25jb3JkaXVtLnYyLlBvb2'
    'xQZW5kaW5nQ2hhbmdlLlJlZHVjZUgAUgZyZWR1Y2USQQoGcmVtb3ZlGAIgASgLMicuY29uY29y'
    'ZGl1bS52Mi5Qb29sUGVuZGluZ0NoYW5nZS5SZW1vdmVIAFIGcmVtb3ZlGpYBCgZSZWR1Y2USSw'
    'oWcmVkdWNlZF9lcXVpdHlfY2FwaXRhbBgBIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UhRy'
    'ZWR1Y2VkRXF1aXR5Q2FwaXRhbBI/Cg5lZmZlY3RpdmVfdGltZRgCIAEoCzIYLmNvbmNvcmRpdW'
    '0udjIuVGltZXN0YW1wUg1lZmZlY3RpdmVUaW1lGkkKBlJlbW92ZRI/Cg5lZmZlY3RpdmVfdGlt'
    'ZRgBIAEoCzIYLmNvbmNvcmRpdW0udjIuVGltZXN0YW1wUg1lZmZlY3RpdmVUaW1lQggKBmNoYW'
    '5nZQ==');

@$core.Deprecated('Use poolCurrentPaydayInfoDescriptor instead')
const PoolCurrentPaydayInfo$json = {
  '1': 'PoolCurrentPaydayInfo',
  '2': [
    {'1': 'blocks_baked', '3': 1, '4': 1, '5': 4, '10': 'blocksBaked'},
    {'1': 'finalization_live', '3': 2, '4': 1, '5': 8, '10': 'finalizationLive'},
    {'1': 'transaction_fees_earned', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'transactionFeesEarned'},
    {'1': 'effective_stake', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'effectiveStake'},
    {'1': 'lottery_power', '3': 5, '4': 1, '5': 1, '10': 'lotteryPower'},
    {'1': 'baker_equity_capital', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakerEquityCapital'},
    {'1': 'delegated_capital', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'delegatedCapital'},
    {'1': 'commission_rates', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.CommissionRates', '10': 'commissionRates'},
  ],
};

/// Descriptor for `PoolCurrentPaydayInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List poolCurrentPaydayInfoDescriptor = $convert.base64Decode(
    'ChVQb29sQ3VycmVudFBheWRheUluZm8SIQoMYmxvY2tzX2Jha2VkGAEgASgEUgtibG9ja3NCYW'
    'tlZBIrChFmaW5hbGl6YXRpb25fbGl2ZRgCIAEoCFIQZmluYWxpemF0aW9uTGl2ZRJNChd0cmFu'
    'c2FjdGlvbl9mZWVzX2Vhcm5lZBgDIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UhV0cmFuc2'
    'FjdGlvbkZlZXNFYXJuZWQSPgoPZWZmZWN0aXZlX3N0YWtlGAQgASgLMhUuY29uY29yZGl1bS52'
    'Mi5BbW91bnRSDmVmZmVjdGl2ZVN0YWtlEiMKDWxvdHRlcnlfcG93ZXIYBSABKAFSDGxvdHRlcn'
    'lQb3dlchJHChRiYWtlcl9lcXVpdHlfY2FwaXRhbBgGIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1v'
    'dW50UhJiYWtlckVxdWl0eUNhcGl0YWwSQgoRZGVsZWdhdGVkX2NhcGl0YWwYByABKAsyFS5jb2'
    '5jb3JkaXVtLnYyLkFtb3VudFIQZGVsZWdhdGVkQ2FwaXRhbBJJChBjb21taXNzaW9uX3JhdGVz'
    'GAggASgLMh4uY29uY29yZGl1bS52Mi5Db21taXNzaW9uUmF0ZXNSD2NvbW1pc3Npb25SYXRlcw'
    '==');

@$core.Deprecated('Use poolInfoResponseDescriptor instead')
const PoolInfoResponse$json = {
  '1': 'PoolInfoResponse',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'baker'},
    {'1': 'address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'address'},
    {'1': 'equity_capital', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'equityCapital'},
    {'1': 'delegated_capital', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'delegatedCapital'},
    {'1': 'delegated_capital_cap', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'delegatedCapitalCap'},
    {'1': 'pool_info', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.BakerPoolInfo', '10': 'poolInfo'},
    {'1': 'equity_pending_change', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.PoolPendingChange', '9': 0, '10': 'equityPendingChange', '17': true},
    {'1': 'current_payday_info', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.PoolCurrentPaydayInfo', '9': 1, '10': 'currentPaydayInfo', '17': true},
    {'1': 'all_pool_total_capital', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'allPoolTotalCapital'},
  ],
  '8': [
    {'1': '_equity_pending_change'},
    {'1': '_current_payday_info'},
  ],
};

/// Descriptor for `PoolInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List poolInfoResponseDescriptor = $convert.base64Decode(
    'ChBQb29sSW5mb1Jlc3BvbnNlEiwKBWJha2VyGAEgASgLMhYuY29uY29yZGl1bS52Mi5CYWtlck'
    'lkUgViYWtlchI3CgdhZGRyZXNzGAIgASgLMh0uY29uY29yZGl1bS52Mi5BY2NvdW50QWRkcmVz'
    'c1IHYWRkcmVzcxI8Cg5lcXVpdHlfY2FwaXRhbBgDIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW'
    '50Ug1lcXVpdHlDYXBpdGFsEkIKEWRlbGVnYXRlZF9jYXBpdGFsGAQgASgLMhUuY29uY29yZGl1'
    'bS52Mi5BbW91bnRSEGRlbGVnYXRlZENhcGl0YWwSSQoVZGVsZWdhdGVkX2NhcGl0YWxfY2FwGA'
    'UgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSE2RlbGVnYXRlZENhcGl0YWxDYXASOQoJcG9v'
    'bF9pbmZvGAYgASgLMhwuY29uY29yZGl1bS52Mi5CYWtlclBvb2xJbmZvUghwb29sSW5mbxJZCh'
    'VlcXVpdHlfcGVuZGluZ19jaGFuZ2UYByABKAsyIC5jb25jb3JkaXVtLnYyLlBvb2xQZW5kaW5n'
    'Q2hhbmdlSABSE2VxdWl0eVBlbmRpbmdDaGFuZ2WIAQESWQoTY3VycmVudF9wYXlkYXlfaW5mbx'
    'gIIAEoCzIkLmNvbmNvcmRpdW0udjIuUG9vbEN1cnJlbnRQYXlkYXlJbmZvSAFSEWN1cnJlbnRQ'
    'YXlkYXlJbmZviAEBEkoKFmFsbF9wb29sX3RvdGFsX2NhcGl0YWwYCSABKAsyFS5jb25jb3JkaX'
    'VtLnYyLkFtb3VudFITYWxsUG9vbFRvdGFsQ2FwaXRhbEIYChZfZXF1aXR5X3BlbmRpbmdfY2hh'
    'bmdlQhYKFF9jdXJyZW50X3BheWRheV9pbmZv');

@$core.Deprecated('Use passiveDelegationInfoDescriptor instead')
const PassiveDelegationInfo$json = {
  '1': 'PassiveDelegationInfo',
  '2': [
    {'1': 'delegated_capital', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'delegatedCapital'},
    {'1': 'commission_rates', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.CommissionRates', '10': 'commissionRates'},
    {'1': 'current_payday_transaction_fees_earned', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'currentPaydayTransactionFeesEarned'},
    {'1': 'current_payday_delegated_capital', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'currentPaydayDelegatedCapital'},
    {'1': 'all_pool_total_capital', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'allPoolTotalCapital'},
  ],
};

/// Descriptor for `PassiveDelegationInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List passiveDelegationInfoDescriptor = $convert.base64Decode(
    'ChVQYXNzaXZlRGVsZWdhdGlvbkluZm8SQgoRZGVsZWdhdGVkX2NhcGl0YWwYASABKAsyFS5jb2'
    '5jb3JkaXVtLnYyLkFtb3VudFIQZGVsZWdhdGVkQ2FwaXRhbBJJChBjb21taXNzaW9uX3JhdGVz'
    'GAIgASgLMh4uY29uY29yZGl1bS52Mi5Db21taXNzaW9uUmF0ZXNSD2NvbW1pc3Npb25SYXRlcx'
    'JpCiZjdXJyZW50X3BheWRheV90cmFuc2FjdGlvbl9mZWVzX2Vhcm5lZBgDIAEoCzIVLmNvbmNv'
    'cmRpdW0udjIuQW1vdW50UiJjdXJyZW50UGF5ZGF5VHJhbnNhY3Rpb25GZWVzRWFybmVkEl4KIG'
    'N1cnJlbnRfcGF5ZGF5X2RlbGVnYXRlZF9jYXBpdGFsGAQgASgLMhUuY29uY29yZGl1bS52Mi5B'
    'bW91bnRSHWN1cnJlbnRQYXlkYXlEZWxlZ2F0ZWRDYXBpdGFsEkoKFmFsbF9wb29sX3RvdGFsX2'
    'NhcGl0YWwYBSABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFITYWxsUG9vbFRvdGFsQ2FwaXRh'
    'bA==');

@$core.Deprecated('Use blocksAtHeightRequestDescriptor instead')
const BlocksAtHeightRequest$json = {
  '1': 'BlocksAtHeightRequest',
  '2': [
    {'1': 'absolute', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlocksAtHeightRequest.Absolute', '9': 0, '10': 'absolute'},
    {'1': 'relative', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlocksAtHeightRequest.Relative', '9': 0, '10': 'relative'},
  ],
  '3': [BlocksAtHeightRequest_Absolute$json, BlocksAtHeightRequest_Relative$json],
  '8': [
    {'1': 'blocks_at_height'},
  ],
};

@$core.Deprecated('Use blocksAtHeightRequestDescriptor instead')
const BlocksAtHeightRequest_Absolute$json = {
  '1': 'Absolute',
  '2': [
    {'1': 'height', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AbsoluteBlockHeight', '10': 'height'},
  ],
};

@$core.Deprecated('Use blocksAtHeightRequestDescriptor instead')
const BlocksAtHeightRequest_Relative$json = {
  '1': 'Relative',
  '2': [
    {'1': 'genesis_index', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.GenesisIndex', '10': 'genesisIndex'},
    {'1': 'height', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockHeight', '10': 'height'},
    {'1': 'restrict', '3': 3, '4': 1, '5': 8, '10': 'restrict'},
  ],
};

/// Descriptor for `BlocksAtHeightRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blocksAtHeightRequestDescriptor = $convert.base64Decode(
    'ChVCbG9ja3NBdEhlaWdodFJlcXVlc3QSSwoIYWJzb2x1dGUYASABKAsyLS5jb25jb3JkaXVtLn'
    'YyLkJsb2Nrc0F0SGVpZ2h0UmVxdWVzdC5BYnNvbHV0ZUgAUghhYnNvbHV0ZRJLCghyZWxhdGl2'
    'ZRgCIAEoCzItLmNvbmNvcmRpdW0udjIuQmxvY2tzQXRIZWlnaHRSZXF1ZXN0LlJlbGF0aXZlSA'
    'BSCHJlbGF0aXZlGkYKCEFic29sdXRlEjoKBmhlaWdodBgBIAEoCzIiLmNvbmNvcmRpdW0udjIu'
    'QWJzb2x1dGVCbG9ja0hlaWdodFIGaGVpZ2h0GpwBCghSZWxhdGl2ZRJACg1nZW5lc2lzX2luZG'
    'V4GAEgASgLMhsuY29uY29yZGl1bS52Mi5HZW5lc2lzSW5kZXhSDGdlbmVzaXNJbmRleBIyCgZo'
    'ZWlnaHQYAiABKAsyGi5jb25jb3JkaXVtLnYyLkJsb2NrSGVpZ2h0UgZoZWlnaHQSGgoIcmVzdH'
    'JpY3QYAyABKAhSCHJlc3RyaWN0QhIKEGJsb2Nrc19hdF9oZWlnaHQ=');

@$core.Deprecated('Use blocksAtHeightResponseDescriptor instead')
const BlocksAtHeightResponse$json = {
  '1': 'BlocksAtHeightResponse',
  '2': [
    {'1': 'blocks', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'blocks'},
  ],
};

/// Descriptor for `BlocksAtHeightResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blocksAtHeightResponseDescriptor = $convert.base64Decode(
    'ChZCbG9ja3NBdEhlaWdodFJlc3BvbnNlEjAKBmJsb2NrcxgBIAMoCzIYLmNvbmNvcmRpdW0udj'
    'IuQmxvY2tIYXNoUgZibG9ja3M=');

@$core.Deprecated('Use tokenomicsInfoDescriptor instead')
const TokenomicsInfo$json = {
  '1': 'TokenomicsInfo',
  '2': [
    {'1': 'v0', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.TokenomicsInfo.V0', '9': 0, '10': 'v0'},
    {'1': 'v1', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.TokenomicsInfo.V1', '9': 0, '10': 'v1'},
  ],
  '3': [TokenomicsInfo_V0$json, TokenomicsInfo_V1$json],
  '8': [
    {'1': 'tokenomics'},
  ],
};

@$core.Deprecated('Use tokenomicsInfoDescriptor instead')
const TokenomicsInfo_V0$json = {
  '1': 'V0',
  '2': [
    {'1': 'total_amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'totalAmount'},
    {'1': 'total_encrypted_amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'totalEncryptedAmount'},
    {'1': 'baking_reward_account', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakingRewardAccount'},
    {'1': 'finalization_reward_account', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'finalizationRewardAccount'},
    {'1': 'gas_account', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'gasAccount'},
    {'1': 'protocol_version', '3': 6, '4': 1, '5': 14, '6': '.concordium.v2.ProtocolVersion', '10': 'protocolVersion'},
  ],
};

@$core.Deprecated('Use tokenomicsInfoDescriptor instead')
const TokenomicsInfo_V1$json = {
  '1': 'V1',
  '2': [
    {'1': 'total_amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'totalAmount'},
    {'1': 'total_encrypted_amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'totalEncryptedAmount'},
    {'1': 'baking_reward_account', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakingRewardAccount'},
    {'1': 'finalization_reward_account', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'finalizationRewardAccount'},
    {'1': 'gas_account', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'gasAccount'},
    {'1': 'foundation_transaction_rewards', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'foundationTransactionRewards'},
    {'1': 'next_payday_time', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'nextPaydayTime'},
    {'1': 'next_payday_mint_rate', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.MintRate', '10': 'nextPaydayMintRate'},
    {'1': 'total_staked_capital', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'totalStakedCapital'},
    {'1': 'protocol_version', '3': 10, '4': 1, '5': 14, '6': '.concordium.v2.ProtocolVersion', '10': 'protocolVersion'},
  ],
};

/// Descriptor for `TokenomicsInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tokenomicsInfoDescriptor = $convert.base64Decode(
    'Cg5Ub2tlbm9taWNzSW5mbxIyCgJ2MBgBIAEoCzIgLmNvbmNvcmRpdW0udjIuVG9rZW5vbWljc0'
    'luZm8uVjBIAFICdjASMgoCdjEYAiABKAsyIC5jb25jb3JkaXVtLnYyLlRva2Vub21pY3NJbmZv'
    'LlYxSABSAnYxGrADCgJWMBI4Cgx0b3RhbF9hbW91bnQYASABKAsyFS5jb25jb3JkaXVtLnYyLk'
    'Ftb3VudFILdG90YWxBbW91bnQSSwoWdG90YWxfZW5jcnlwdGVkX2Ftb3VudBgCIAEoCzIVLmNv'
    'bmNvcmRpdW0udjIuQW1vdW50UhR0b3RhbEVuY3J5cHRlZEFtb3VudBJJChViYWtpbmdfcmV3YX'
    'JkX2FjY291bnQYAyABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFITYmFraW5nUmV3YXJkQWNj'
    'b3VudBJVChtmaW5hbGl6YXRpb25fcmV3YXJkX2FjY291bnQYBCABKAsyFS5jb25jb3JkaXVtLn'
    'YyLkFtb3VudFIZZmluYWxpemF0aW9uUmV3YXJkQWNjb3VudBI2CgtnYXNfYWNjb3VudBgFIAEo'
    'CzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UgpnYXNBY2NvdW50EkkKEHByb3RvY29sX3ZlcnNpb2'
    '4YBiABKA4yHi5jb25jb3JkaXVtLnYyLlByb3RvY29sVmVyc2lvblIPcHJvdG9jb2xWZXJzaW9u'
    'GuYFCgJWMRI4Cgx0b3RhbF9hbW91bnQYASABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFILdG'
    '90YWxBbW91bnQSSwoWdG90YWxfZW5jcnlwdGVkX2Ftb3VudBgCIAEoCzIVLmNvbmNvcmRpdW0u'
    'djIuQW1vdW50UhR0b3RhbEVuY3J5cHRlZEFtb3VudBJJChViYWtpbmdfcmV3YXJkX2FjY291bn'
    'QYAyABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFITYmFraW5nUmV3YXJkQWNjb3VudBJVChtm'
    'aW5hbGl6YXRpb25fcmV3YXJkX2FjY291bnQYBCABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudF'
    'IZZmluYWxpemF0aW9uUmV3YXJkQWNjb3VudBI2CgtnYXNfYWNjb3VudBgFIAEoCzIVLmNvbmNv'
    'cmRpdW0udjIuQW1vdW50UgpnYXNBY2NvdW50ElsKHmZvdW5kYXRpb25fdHJhbnNhY3Rpb25fcm'
    'V3YXJkcxgGIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50Uhxmb3VuZGF0aW9uVHJhbnNhY3Rp'
    'b25SZXdhcmRzEkIKEG5leHRfcGF5ZGF5X3RpbWUYByABKAsyGC5jb25jb3JkaXVtLnYyLlRpbW'
    'VzdGFtcFIObmV4dFBheWRheVRpbWUSSgoVbmV4dF9wYXlkYXlfbWludF9yYXRlGAggASgLMhcu'
    'Y29uY29yZGl1bS52Mi5NaW50UmF0ZVISbmV4dFBheWRheU1pbnRSYXRlEkcKFHRvdGFsX3N0YW'
    'tlZF9jYXBpdGFsGAkgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSEnRvdGFsU3Rha2VkQ2Fw'
    'aXRhbBJJChBwcm90b2NvbF92ZXJzaW9uGAogASgOMh4uY29uY29yZGl1bS52Mi5Qcm90b2NvbF'
    'ZlcnNpb25SD3Byb3RvY29sVmVyc2lvbkIMCgp0b2tlbm9taWNz');

@$core.Deprecated('Use invokeInstanceRequestDescriptor instead')
const InvokeInstanceRequest$json = {
  '1': 'InvokeInstanceRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'invoker', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Address', '9': 0, '10': 'invoker', '17': true},
    {'1': 'instance', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'instance'},
    {'1': 'amount', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'entrypoint', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'entrypoint'},
    {'1': 'parameter', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.Parameter', '10': 'parameter'},
    {'1': 'energy', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'energy'},
  ],
  '8': [
    {'1': '_invoker'},
  ],
};

/// Descriptor for `InvokeInstanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invokeInstanceRequestDescriptor = $convert.base64Decode(
    'ChVJbnZva2VJbnN0YW5jZVJlcXVlc3QSPAoKYmxvY2tfaGFzaBgBIAEoCzIdLmNvbmNvcmRpdW'
    '0udjIuQmxvY2tIYXNoSW5wdXRSCWJsb2NrSGFzaBI1CgdpbnZva2VyGAIgASgLMhYuY29uY29y'
    'ZGl1bS52Mi5BZGRyZXNzSABSB2ludm9rZXKIAQESOgoIaW5zdGFuY2UYAyABKAsyHi5jb25jb3'
    'JkaXVtLnYyLkNvbnRyYWN0QWRkcmVzc1IIaW5zdGFuY2USLQoGYW1vdW50GAQgASgLMhUuY29u'
    'Y29yZGl1bS52Mi5BbW91bnRSBmFtb3VudBI6CgplbnRyeXBvaW50GAUgASgLMhouY29uY29yZG'
    'l1bS52Mi5SZWNlaXZlTmFtZVIKZW50cnlwb2ludBI2CglwYXJhbWV0ZXIYBiABKAsyGC5jb25j'
    'b3JkaXVtLnYyLlBhcmFtZXRlclIJcGFyYW1ldGVyEi0KBmVuZXJneRgHIAEoCzIVLmNvbmNvcm'
    'RpdW0udjIuRW5lcmd5UgZlbmVyZ3lCCgoIX2ludm9rZXI=');

@$core.Deprecated('Use invokeInstanceResponseDescriptor instead')
const InvokeInstanceResponse$json = {
  '1': 'InvokeInstanceResponse',
  '2': [
    {'1': 'success', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.InvokeInstanceResponse.Success', '9': 0, '10': 'success'},
    {'1': 'failure', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.InvokeInstanceResponse.Failure', '9': 0, '10': 'failure'},
  ],
  '3': [InvokeInstanceResponse_Failure$json, InvokeInstanceResponse_Success$json],
  '8': [
    {'1': 'result'},
  ],
};

@$core.Deprecated('Use invokeInstanceResponseDescriptor instead')
const InvokeInstanceResponse_Failure$json = {
  '1': 'Failure',
  '2': [
    {'1': 'return_value', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'returnValue', '17': true},
    {'1': 'used_energy', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'usedEnergy'},
    {'1': 'reason', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason', '10': 'reason'},
  ],
  '8': [
    {'1': '_return_value'},
  ],
};

@$core.Deprecated('Use invokeInstanceResponseDescriptor instead')
const InvokeInstanceResponse_Success$json = {
  '1': 'Success',
  '2': [
    {'1': 'return_value', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'returnValue', '17': true},
    {'1': 'used_energy', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'usedEnergy'},
    {'1': 'effects', '3': 3, '4': 3, '5': 11, '6': '.concordium.v2.ContractTraceElement', '10': 'effects'},
  ],
  '8': [
    {'1': '_return_value'},
  ],
};

/// Descriptor for `InvokeInstanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invokeInstanceResponseDescriptor = $convert.base64Decode(
    'ChZJbnZva2VJbnN0YW5jZVJlc3BvbnNlEkkKB3N1Y2Nlc3MYASABKAsyLS5jb25jb3JkaXVtLn'
    'YyLkludm9rZUluc3RhbmNlUmVzcG9uc2UuU3VjY2Vzc0gAUgdzdWNjZXNzEkkKB2ZhaWx1cmUY'
    'AiABKAsyLS5jb25jb3JkaXVtLnYyLkludm9rZUluc3RhbmNlUmVzcG9uc2UuRmFpbHVyZUgAUg'
    'dmYWlsdXJlGq8BCgdGYWlsdXJlEiYKDHJldHVybl92YWx1ZRgBIAEoDEgAUgtyZXR1cm5WYWx1'
    'ZYgBARI2Cgt1c2VkX2VuZXJneRgCIAEoCzIVLmNvbmNvcmRpdW0udjIuRW5lcmd5Ugp1c2VkRW'
    '5lcmd5EjMKBnJlYXNvbhgDIAEoCzIbLmNvbmNvcmRpdW0udjIuUmVqZWN0UmVhc29uUgZyZWFz'
    'b25CDwoNX3JldHVybl92YWx1ZRq5AQoHU3VjY2VzcxImCgxyZXR1cm5fdmFsdWUYASABKAxIAF'
    'ILcmV0dXJuVmFsdWWIAQESNgoLdXNlZF9lbmVyZ3kYAiABKAsyFS5jb25jb3JkaXVtLnYyLkVu'
    'ZXJneVIKdXNlZEVuZXJneRI9CgdlZmZlY3RzGAMgAygLMiMuY29uY29yZGl1bS52Mi5Db250cm'
    'FjdFRyYWNlRWxlbWVudFIHZWZmZWN0c0IPCg1fcmV0dXJuX3ZhbHVlQggKBnJlc3VsdA==');

@$core.Deprecated('Use getPoolDelegatorsRequestDescriptor instead')
const GetPoolDelegatorsRequest$json = {
  '1': 'GetPoolDelegatorsRequest',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '10': 'blockHash'},
    {'1': 'baker', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'baker'},
  ],
};

/// Descriptor for `GetPoolDelegatorsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPoolDelegatorsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQb29sRGVsZWdhdG9yc1JlcXVlc3QSPAoKYmxvY2tfaGFzaBgBIAEoCzIdLmNvbmNvcm'
    'RpdW0udjIuQmxvY2tIYXNoSW5wdXRSCWJsb2NrSGFzaBIsCgViYWtlchgCIAEoCzIWLmNvbmNv'
    'cmRpdW0udjIuQmFrZXJJZFIFYmFrZXI=');

@$core.Deprecated('Use delegatorInfoDescriptor instead')
const DelegatorInfo$json = {
  '1': 'DelegatorInfo',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'stake'},
    {'1': 'pending_change', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.StakePendingChange', '9': 0, '10': 'pendingChange', '17': true},
  ],
  '8': [
    {'1': '_pending_change'},
  ],
};

/// Descriptor for `DelegatorInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delegatorInfoDescriptor = $convert.base64Decode(
    'Cg1EZWxlZ2F0b3JJbmZvEjcKB2FjY291bnQYASABKAsyHS5jb25jb3JkaXVtLnYyLkFjY291bn'
    'RBZGRyZXNzUgdhY2NvdW50EisKBXN0YWtlGAIgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRS'
    'BXN0YWtlEk0KDnBlbmRpbmdfY2hhbmdlGAMgASgLMiEuY29uY29yZGl1bS52Mi5TdGFrZVBlbm'
    'RpbmdDaGFuZ2VIAFINcGVuZGluZ0NoYW5nZYgBAUIRCg9fcGVuZGluZ19jaGFuZ2U=');

@$core.Deprecated('Use delegatorRewardPeriodInfoDescriptor instead')
const DelegatorRewardPeriodInfo$json = {
  '1': 'DelegatorRewardPeriodInfo',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'stake'},
  ],
};

/// Descriptor for `DelegatorRewardPeriodInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List delegatorRewardPeriodInfoDescriptor = $convert.base64Decode(
    'ChlEZWxlZ2F0b3JSZXdhcmRQZXJpb2RJbmZvEjcKB2FjY291bnQYASABKAsyHS5jb25jb3JkaX'
    'VtLnYyLkFjY291bnRBZGRyZXNzUgdhY2NvdW50EisKBXN0YWtlGAIgASgLMhUuY29uY29yZGl1'
    'bS52Mi5BbW91bnRSBXN0YWtl');

@$core.Deprecated('Use branchDescriptor instead')
const Branch$json = {
  '1': 'Branch',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'blockHash'},
    {'1': 'children', '3': 2, '4': 3, '5': 11, '6': '.concordium.v2.Branch', '10': 'children'},
  ],
};

/// Descriptor for `Branch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List branchDescriptor = $convert.base64Decode(
    'CgZCcmFuY2gSNwoKYmxvY2tfaGFzaBgBIAEoCzIYLmNvbmNvcmRpdW0udjIuQmxvY2tIYXNoUg'
    'libG9ja0hhc2gSMQoIY2hpbGRyZW4YAiADKAsyFS5jb25jb3JkaXVtLnYyLkJyYW5jaFIIY2hp'
    'bGRyZW4=');

@$core.Deprecated('Use leadershipElectionNonceDescriptor instead')
const LeadershipElectionNonce$json = {
  '1': 'LeadershipElectionNonce',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `LeadershipElectionNonce`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leadershipElectionNonceDescriptor = $convert.base64Decode(
    'ChdMZWFkZXJzaGlwRWxlY3Rpb25Ob25jZRIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use electionInfoDescriptor instead')
const ElectionInfo$json = {
  '1': 'ElectionInfo',
  '2': [
    {'1': 'election_difficulty', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ElectionDifficulty', '9': 0, '10': 'electionDifficulty', '17': true},
    {'1': 'election_nonce', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.LeadershipElectionNonce', '10': 'electionNonce'},
    {'1': 'baker_election_info', '3': 3, '4': 3, '5': 11, '6': '.concordium.v2.ElectionInfo.Baker', '10': 'bakerElectionInfo'},
  ],
  '3': [ElectionInfo_Baker$json],
  '8': [
    {'1': '_election_difficulty'},
  ],
};

@$core.Deprecated('Use electionInfoDescriptor instead')
const ElectionInfo_Baker$json = {
  '1': 'Baker',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'baker'},
    {'1': 'account', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'lottery_power', '3': 3, '4': 1, '5': 1, '10': 'lotteryPower'},
  ],
};

/// Descriptor for `ElectionInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List electionInfoDescriptor = $convert.base64Decode(
    'CgxFbGVjdGlvbkluZm8SVwoTZWxlY3Rpb25fZGlmZmljdWx0eRgBIAEoCzIhLmNvbmNvcmRpdW'
    '0udjIuRWxlY3Rpb25EaWZmaWN1bHR5SABSEmVsZWN0aW9uRGlmZmljdWx0eYgBARJNCg5lbGVj'
    'dGlvbl9ub25jZRgCIAEoCzImLmNvbmNvcmRpdW0udjIuTGVhZGVyc2hpcEVsZWN0aW9uTm9uY2'
    'VSDWVsZWN0aW9uTm9uY2USUQoTYmFrZXJfZWxlY3Rpb25faW5mbxgDIAMoCzIhLmNvbmNvcmRp'
    'dW0udjIuRWxlY3Rpb25JbmZvLkJha2VyUhFiYWtlckVsZWN0aW9uSW5mbxqTAQoFQmFrZXISLA'
    'oFYmFrZXIYASABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRSBWJha2VyEjcKB2FjY291bnQY'
    'AiABKAsyHS5jb25jb3JkaXVtLnYyLkFjY291bnRBZGRyZXNzUgdhY2NvdW50EiMKDWxvdHRlcn'
    'lfcG93ZXIYAyABKAFSDGxvdHRlcnlQb3dlckIWChRfZWxlY3Rpb25fZGlmZmljdWx0eQ==');

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent$json = {
  '1': 'BlockSpecialEvent',
  '2': [
    {'1': 'baking_rewards', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.BakingRewards', '9': 0, '10': 'bakingRewards'},
    {'1': 'mint', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.Mint', '9': 0, '10': 'mint'},
    {'1': 'finalization_rewards', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.FinalizationRewards', '9': 0, '10': 'finalizationRewards'},
    {'1': 'block_reward', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.BlockReward', '9': 0, '10': 'blockReward'},
    {'1': 'payday_foundation_reward', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.PaydayFoundationReward', '9': 0, '10': 'paydayFoundationReward'},
    {'1': 'payday_account_reward', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.PaydayAccountReward', '9': 0, '10': 'paydayAccountReward'},
    {'1': 'block_accrue_reward', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.BlockAccrueReward', '9': 0, '10': 'blockAccrueReward'},
    {'1': 'payday_pool_reward', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.PaydayPoolReward', '9': 0, '10': 'paydayPoolReward'},
  ],
  '3': [BlockSpecialEvent_AccountAmounts$json, BlockSpecialEvent_BakingRewards$json, BlockSpecialEvent_Mint$json, BlockSpecialEvent_FinalizationRewards$json, BlockSpecialEvent_BlockReward$json, BlockSpecialEvent_PaydayFoundationReward$json, BlockSpecialEvent_PaydayAccountReward$json, BlockSpecialEvent_BlockAccrueReward$json, BlockSpecialEvent_PaydayPoolReward$json],
  '8': [
    {'1': 'event'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_AccountAmounts$json = {
  '1': 'AccountAmounts',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.AccountAmounts.Entry', '10': 'entries'},
  ],
  '3': [BlockSpecialEvent_AccountAmounts_Entry$json],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_AccountAmounts_Entry$json = {
  '1': 'Entry',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_BakingRewards$json = {
  '1': 'BakingRewards',
  '2': [
    {'1': 'baker_rewards', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.AccountAmounts', '10': 'bakerRewards'},
    {'1': 'remainder', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'remainder'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_Mint$json = {
  '1': 'Mint',
  '2': [
    {'1': 'mint_baking_reward', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'mintBakingReward'},
    {'1': 'mint_finalization_reward', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'mintFinalizationReward'},
    {'1': 'mint_platform_development_charge', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'mintPlatformDevelopmentCharge'},
    {'1': 'foundation_account', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'foundationAccount'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_FinalizationRewards$json = {
  '1': 'FinalizationRewards',
  '2': [
    {'1': 'finalization_rewards', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockSpecialEvent.AccountAmounts', '10': 'finalizationRewards'},
    {'1': 'remainder', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'remainder'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_BlockReward$json = {
  '1': 'BlockReward',
  '2': [
    {'1': 'transaction_fees', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'transactionFees'},
    {'1': 'old_gas_account', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'oldGasAccount'},
    {'1': 'new_gas_account', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newGasAccount'},
    {'1': 'baker_reward', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakerReward'},
    {'1': 'foundation_charge', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'foundationCharge'},
    {'1': 'baker', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'baker'},
    {'1': 'foundation_account', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'foundationAccount'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_PaydayFoundationReward$json = {
  '1': 'PaydayFoundationReward',
  '2': [
    {'1': 'foundation_account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'foundationAccount'},
    {'1': 'development_charge', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'developmentCharge'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_PaydayAccountReward$json = {
  '1': 'PaydayAccountReward',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'transaction_fees', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'transactionFees'},
    {'1': 'baker_reward', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakerReward'},
    {'1': 'finalization_reward', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'finalizationReward'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_BlockAccrueReward$json = {
  '1': 'BlockAccrueReward',
  '2': [
    {'1': 'transaction_fees', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'transactionFees'},
    {'1': 'old_gas_account', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'oldGasAccount'},
    {'1': 'new_gas_account', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'newGasAccount'},
    {'1': 'baker_reward', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakerReward'},
    {'1': 'passive_reward', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'passiveReward'},
    {'1': 'foundation_charge', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'foundationCharge'},
    {'1': 'baker', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'baker'},
  ],
};

@$core.Deprecated('Use blockSpecialEventDescriptor instead')
const BlockSpecialEvent_PaydayPoolReward$json = {
  '1': 'PaydayPoolReward',
  '2': [
    {'1': 'pool_owner', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '9': 0, '10': 'poolOwner', '17': true},
    {'1': 'transaction_fees', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'transactionFees'},
    {'1': 'baker_reward', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'bakerReward'},
    {'1': 'finalization_reward', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'finalizationReward'},
  ],
  '8': [
    {'1': '_pool_owner'},
  ],
};

/// Descriptor for `BlockSpecialEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockSpecialEventDescriptor = $convert.base64Decode(
    'ChFCbG9ja1NwZWNpYWxFdmVudBJXCg5iYWtpbmdfcmV3YXJkcxgBIAEoCzIuLmNvbmNvcmRpdW'
    '0udjIuQmxvY2tTcGVjaWFsRXZlbnQuQmFraW5nUmV3YXJkc0gAUg1iYWtpbmdSZXdhcmRzEjsK'
    'BG1pbnQYAiABKAsyJS5jb25jb3JkaXVtLnYyLkJsb2NrU3BlY2lhbEV2ZW50Lk1pbnRIAFIEbW'
    'ludBJpChRmaW5hbGl6YXRpb25fcmV3YXJkcxgDIAEoCzI0LmNvbmNvcmRpdW0udjIuQmxvY2tT'
    'cGVjaWFsRXZlbnQuRmluYWxpemF0aW9uUmV3YXJkc0gAUhNmaW5hbGl6YXRpb25SZXdhcmRzEl'
    'EKDGJsb2NrX3Jld2FyZBgEIAEoCzIsLmNvbmNvcmRpdW0udjIuQmxvY2tTcGVjaWFsRXZlbnQu'
    'QmxvY2tSZXdhcmRIAFILYmxvY2tSZXdhcmQScwoYcGF5ZGF5X2ZvdW5kYXRpb25fcmV3YXJkGA'
    'UgASgLMjcuY29uY29yZGl1bS52Mi5CbG9ja1NwZWNpYWxFdmVudC5QYXlkYXlGb3VuZGF0aW9u'
    'UmV3YXJkSABSFnBheWRheUZvdW5kYXRpb25SZXdhcmQSagoVcGF5ZGF5X2FjY291bnRfcmV3YX'
    'JkGAYgASgLMjQuY29uY29yZGl1bS52Mi5CbG9ja1NwZWNpYWxFdmVudC5QYXlkYXlBY2NvdW50'
    'UmV3YXJkSABSE3BheWRheUFjY291bnRSZXdhcmQSZAoTYmxvY2tfYWNjcnVlX3Jld2FyZBgHIA'
    'EoCzIyLmNvbmNvcmRpdW0udjIuQmxvY2tTcGVjaWFsRXZlbnQuQmxvY2tBY2NydWVSZXdhcmRI'
    'AFIRYmxvY2tBY2NydWVSZXdhcmQSYQoScGF5ZGF5X3Bvb2xfcmV3YXJkGAggASgLMjEuY29uY2'
    '9yZGl1bS52Mi5CbG9ja1NwZWNpYWxFdmVudC5QYXlkYXlQb29sUmV3YXJkSABSEHBheWRheVBv'
    'b2xSZXdhcmQa0gEKDkFjY291bnRBbW91bnRzEk8KB2VudHJpZXMYASADKAsyNS5jb25jb3JkaX'
    'VtLnYyLkJsb2NrU3BlY2lhbEV2ZW50LkFjY291bnRBbW91bnRzLkVudHJ5UgdlbnRyaWVzGm8K'
    'BUVudHJ5EjcKB2FjY291bnQYASABKAsyHS5jb25jb3JkaXVtLnYyLkFjY291bnRBZGRyZXNzUg'
    'dhY2NvdW50Ei0KBmFtb3VudBgCIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UgZhbW91bnQa'
    'mgEKDUJha2luZ1Jld2FyZHMSVAoNYmFrZXJfcmV3YXJkcxgBIAEoCzIvLmNvbmNvcmRpdW0udj'
    'IuQmxvY2tTcGVjaWFsRXZlbnQuQWNjb3VudEFtb3VudHNSDGJha2VyUmV3YXJkcxIzCglyZW1h'
    'aW5kZXIYAiABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIJcmVtYWluZGVyGsoCCgRNaW50Ek'
    'MKEm1pbnRfYmFraW5nX3Jld2FyZBgBIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UhBtaW50'
    'QmFraW5nUmV3YXJkEk8KGG1pbnRfZmluYWxpemF0aW9uX3Jld2FyZBgCIAEoCzIVLmNvbmNvcm'
    'RpdW0udjIuQW1vdW50UhZtaW50RmluYWxpemF0aW9uUmV3YXJkEl4KIG1pbnRfcGxhdGZvcm1f'
    'ZGV2ZWxvcG1lbnRfY2hhcmdlGAMgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSHW1pbnRQbG'
    'F0Zm9ybURldmVsb3BtZW50Q2hhcmdlEkwKEmZvdW5kYXRpb25fYWNjb3VudBgEIAEoCzIdLmNv'
    'bmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NSEWZvdW5kYXRpb25BY2NvdW50Gq4BChNGaW5hbG'
    'l6YXRpb25SZXdhcmRzEmIKFGZpbmFsaXphdGlvbl9yZXdhcmRzGAEgASgLMi8uY29uY29yZGl1'
    'bS52Mi5CbG9ja1NwZWNpYWxFdmVudC5BY2NvdW50QW1vdW50c1ITZmluYWxpemF0aW9uUmV3YX'
    'JkcxIzCglyZW1haW5kZXIYAiABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIJcmVtYWluZGVy'
    'Gs4DCgtCbG9ja1Jld2FyZBJAChB0cmFuc2FjdGlvbl9mZWVzGAEgASgLMhUuY29uY29yZGl1bS'
    '52Mi5BbW91bnRSD3RyYW5zYWN0aW9uRmVlcxI9Cg9vbGRfZ2FzX2FjY291bnQYAiABKAsyFS5j'
    'b25jb3JkaXVtLnYyLkFtb3VudFINb2xkR2FzQWNjb3VudBI9Cg9uZXdfZ2FzX2FjY291bnQYAy'
    'ABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFINbmV3R2FzQWNjb3VudBI4CgxiYWtlcl9yZXdh'
    'cmQYBCABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFILYmFrZXJSZXdhcmQSQgoRZm91bmRhdG'
    'lvbl9jaGFyZ2UYBSABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIQZm91bmRhdGlvbkNoYXJn'
    'ZRIzCgViYWtlchgGIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NSBWJha2VyEk'
    'wKEmZvdW5kYXRpb25fYWNjb3VudBgHIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJl'
    'c3NSEWZvdW5kYXRpb25BY2NvdW50GqwBChZQYXlkYXlGb3VuZGF0aW9uUmV3YXJkEkwKEmZvdW'
    '5kYXRpb25fYWNjb3VudBgBIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NSEWZv'
    'dW5kYXRpb25BY2NvdW50EkQKEmRldmVsb3BtZW50X2NoYXJnZRgCIAEoCzIVLmNvbmNvcmRpdW'
    '0udjIuQW1vdW50UhFkZXZlbG9wbWVudENoYXJnZRqSAgoTUGF5ZGF5QWNjb3VudFJld2FyZBI3'
    'CgdhY2NvdW50GAEgASgLMh0uY29uY29yZGl1bS52Mi5BY2NvdW50QWRkcmVzc1IHYWNjb3VudB'
    'JAChB0cmFuc2FjdGlvbl9mZWVzGAIgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSD3RyYW5z'
    'YWN0aW9uRmVlcxI4CgxiYWtlcl9yZXdhcmQYAyABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudF'
    'ILYmFrZXJSZXdhcmQSRgoTZmluYWxpemF0aW9uX3Jld2FyZBgEIAEoCzIVLmNvbmNvcmRpdW0u'
    'djIuQW1vdW50UhJmaW5hbGl6YXRpb25SZXdhcmQavQMKEUJsb2NrQWNjcnVlUmV3YXJkEkAKEH'
    'RyYW5zYWN0aW9uX2ZlZXMYASABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIPdHJhbnNhY3Rp'
    'b25GZWVzEj0KD29sZF9nYXNfYWNjb3VudBgCIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50Ug'
    '1vbGRHYXNBY2NvdW50Ej0KD25ld19nYXNfYWNjb3VudBgDIAEoCzIVLmNvbmNvcmRpdW0udjIu'
    'QW1vdW50Ug1uZXdHYXNBY2NvdW50EjgKDGJha2VyX3Jld2FyZBgEIAEoCzIVLmNvbmNvcmRpdW'
    '0udjIuQW1vdW50UgtiYWtlclJld2FyZBI8Cg5wYXNzaXZlX3Jld2FyZBgFIAEoCzIVLmNvbmNv'
    'cmRpdW0udjIuQW1vdW50Ug1wYXNzaXZlUmV3YXJkEkIKEWZvdW5kYXRpb25fY2hhcmdlGAYgAS'
    'gLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSEGZvdW5kYXRpb25DaGFyZ2USLAoFYmFrZXIYByAB'
    'KAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRSBWJha2VyGqECChBQYXlkYXlQb29sUmV3YXJkEj'
    'oKCnBvb2xfb3duZXIYASABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRIAFIJcG9vbE93bmVy'
    'iAEBEkAKEHRyYW5zYWN0aW9uX2ZlZXMYAiABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIPdH'
    'JhbnNhY3Rpb25GZWVzEjgKDGJha2VyX3Jld2FyZBgDIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1v'
    'dW50UgtiYWtlclJld2FyZBJGChNmaW5hbGl6YXRpb25fcmV3YXJkGAQgASgLMhUuY29uY29yZG'
    'l1bS52Mi5BbW91bnRSEmZpbmFsaXphdGlvblJld2FyZEINCgtfcG9vbF9vd25lckIHCgVldmVu'
    'dA==');

@$core.Deprecated('Use pendingUpdateDescriptor instead')
const PendingUpdate$json = {
  '1': 'PendingUpdate',
  '2': [
    {'1': 'effective_time', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.TransactionTime', '10': 'effectiveTime'},
    {'1': 'root_keys', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '9': 0, '10': 'rootKeys'},
    {'1': 'level1_keys', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '9': 0, '10': 'level1Keys'},
    {'1': 'level2_keys_cpv_0', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV0', '9': 0, '10': 'level2KeysCpv0'},
    {'1': 'level2_keys_cpv_1', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV1', '9': 0, '10': 'level2KeysCpv1'},
    {'1': 'protocol', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.ProtocolUpdate', '9': 0, '10': 'protocol'},
    {'1': 'election_difficulty', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.ElectionDifficulty', '9': 0, '10': 'electionDifficulty'},
    {'1': 'euro_per_energy', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '9': 0, '10': 'euroPerEnergy'},
    {'1': 'micro_ccd_per_euro', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '9': 0, '10': 'microCcdPerEuro'},
    {'1': 'foundation_account', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '9': 0, '10': 'foundationAccount'},
    {'1': 'mint_distribution_cpv_0', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.MintDistributionCpv0', '9': 0, '10': 'mintDistributionCpv0'},
    {'1': 'mint_distribution_cpv_1', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.MintDistributionCpv1', '9': 0, '10': 'mintDistributionCpv1'},
    {'1': 'transaction_fee_distribution', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.TransactionFeeDistribution', '9': 0, '10': 'transactionFeeDistribution'},
    {'1': 'gas_rewards', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.GasRewards', '9': 0, '10': 'gasRewards'},
    {'1': 'pool_parameters_cpv_0', '3': 15, '4': 1, '5': 11, '6': '.concordium.v2.BakerStakeThreshold', '9': 0, '10': 'poolParametersCpv0'},
    {'1': 'pool_parameters_cpv_1', '3': 16, '4': 1, '5': 11, '6': '.concordium.v2.PoolParametersCpv1', '9': 0, '10': 'poolParametersCpv1'},
    {'1': 'add_anonymity_revoker', '3': 17, '4': 1, '5': 11, '6': '.concordium.v2.ArInfo', '9': 0, '10': 'addAnonymityRevoker'},
    {'1': 'add_identity_provider', '3': 18, '4': 1, '5': 11, '6': '.concordium.v2.IpInfo', '9': 0, '10': 'addIdentityProvider'},
    {'1': 'cooldown_parameters', '3': 19, '4': 1, '5': 11, '6': '.concordium.v2.CooldownParametersCpv1', '9': 0, '10': 'cooldownParameters'},
    {'1': 'time_parameters', '3': 20, '4': 1, '5': 11, '6': '.concordium.v2.TimeParametersCpv1', '9': 0, '10': 'timeParameters'},
    {'1': 'gas_rewards_cpv_2', '3': 21, '4': 1, '5': 11, '6': '.concordium.v2.GasRewardsCpv2', '9': 0, '10': 'gasRewardsCpv2'},
    {'1': 'timeout_parameters', '3': 22, '4': 1, '5': 11, '6': '.concordium.v2.TimeoutParameters', '9': 0, '10': 'timeoutParameters'},
    {'1': 'min_block_time', '3': 23, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '9': 0, '10': 'minBlockTime'},
    {'1': 'block_energy_limit', '3': 24, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '9': 0, '10': 'blockEnergyLimit'},
    {'1': 'finalization_committee_parameters', '3': 25, '4': 1, '5': 11, '6': '.concordium.v2.FinalizationCommitteeParameters', '9': 0, '10': 'finalizationCommitteeParameters'},
  ],
  '8': [
    {'1': 'effect'},
  ],
};

/// Descriptor for `PendingUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingUpdateDescriptor = $convert.base64Decode(
    'Cg1QZW5kaW5nVXBkYXRlEkUKDmVmZmVjdGl2ZV90aW1lGAEgASgLMh4uY29uY29yZGl1bS52Mi'
    '5UcmFuc2FjdGlvblRpbWVSDWVmZmVjdGl2ZVRpbWUSPQoJcm9vdF9rZXlzGAIgASgLMh4uY29u'
    'Y29yZGl1bS52Mi5IaWdoZXJMZXZlbEtleXNIAFIIcm9vdEtleXMSQQoLbGV2ZWwxX2tleXMYAy'
    'ABKAsyHi5jb25jb3JkaXVtLnYyLkhpZ2hlckxldmVsS2V5c0gAUgpsZXZlbDFLZXlzEkwKEWxl'
    'dmVsMl9rZXlzX2Nwdl8wGAQgASgLMh8uY29uY29yZGl1bS52Mi5BdXRob3JpemF0aW9uc1YwSA'
    'BSDmxldmVsMktleXNDcHYwEkwKEWxldmVsMl9rZXlzX2Nwdl8xGAUgASgLMh8uY29uY29yZGl1'
    'bS52Mi5BdXRob3JpemF0aW9uc1YxSABSDmxldmVsMktleXNDcHYxEjsKCHByb3RvY29sGAYgAS'
    'gLMh0uY29uY29yZGl1bS52Mi5Qcm90b2NvbFVwZGF0ZUgAUghwcm90b2NvbBJUChNlbGVjdGlv'
    'bl9kaWZmaWN1bHR5GAcgASgLMiEuY29uY29yZGl1bS52Mi5FbGVjdGlvbkRpZmZpY3VsdHlIAF'
    'ISZWxlY3Rpb25EaWZmaWN1bHR5EkUKD2V1cm9fcGVyX2VuZXJneRgIIAEoCzIbLmNvbmNvcmRp'
    'dW0udjIuRXhjaGFuZ2VSYXRlSABSDWV1cm9QZXJFbmVyZ3kSSgoSbWljcm9fY2NkX3Blcl9ldX'
    'JvGAkgASgLMhsuY29uY29yZGl1bS52Mi5FeGNoYW5nZVJhdGVIAFIPbWljcm9DY2RQZXJFdXJv'
    'Ek4KEmZvdW5kYXRpb25fYWNjb3VudBgKIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZH'
    'Jlc3NIAFIRZm91bmRhdGlvbkFjY291bnQSXAoXbWludF9kaXN0cmlidXRpb25fY3B2XzAYCyAB'
    'KAsyIy5jb25jb3JkaXVtLnYyLk1pbnREaXN0cmlidXRpb25DcHYwSABSFG1pbnREaXN0cmlidX'
    'Rpb25DcHYwElwKF21pbnRfZGlzdHJpYnV0aW9uX2Nwdl8xGAwgASgLMiMuY29uY29yZGl1bS52'
    'Mi5NaW50RGlzdHJpYnV0aW9uQ3B2MUgAUhRtaW50RGlzdHJpYnV0aW9uQ3B2MRJtChx0cmFuc2'
    'FjdGlvbl9mZWVfZGlzdHJpYnV0aW9uGA0gASgLMikuY29uY29yZGl1bS52Mi5UcmFuc2FjdGlv'
    'bkZlZURpc3RyaWJ1dGlvbkgAUhp0cmFuc2FjdGlvbkZlZURpc3RyaWJ1dGlvbhI8CgtnYXNfcm'
    'V3YXJkcxgOIAEoCzIZLmNvbmNvcmRpdW0udjIuR2FzUmV3YXJkc0gAUgpnYXNSZXdhcmRzElcK'
    'FXBvb2xfcGFyYW1ldGVyc19jcHZfMBgPIAEoCzIiLmNvbmNvcmRpdW0udjIuQmFrZXJTdGFrZV'
    'RocmVzaG9sZEgAUhJwb29sUGFyYW1ldGVyc0NwdjASVgoVcG9vbF9wYXJhbWV0ZXJzX2Nwdl8x'
    'GBAgASgLMiEuY29uY29yZGl1bS52Mi5Qb29sUGFyYW1ldGVyc0NwdjFIAFIScG9vbFBhcmFtZX'
    'RlcnNDcHYxEksKFWFkZF9hbm9ueW1pdHlfcmV2b2tlchgRIAEoCzIVLmNvbmNvcmRpdW0udjIu'
    'QXJJbmZvSABSE2FkZEFub255bWl0eVJldm9rZXISSwoVYWRkX2lkZW50aXR5X3Byb3ZpZGVyGB'
    'IgASgLMhUuY29uY29yZGl1bS52Mi5JcEluZm9IAFITYWRkSWRlbnRpdHlQcm92aWRlchJYChNj'
    'b29sZG93bl9wYXJhbWV0ZXJzGBMgASgLMiUuY29uY29yZGl1bS52Mi5Db29sZG93blBhcmFtZX'
    'RlcnNDcHYxSABSEmNvb2xkb3duUGFyYW1ldGVycxJMCg90aW1lX3BhcmFtZXRlcnMYFCABKAsy'
    'IS5jb25jb3JkaXVtLnYyLlRpbWVQYXJhbWV0ZXJzQ3B2MUgAUg50aW1lUGFyYW1ldGVycxJKCh'
    'FnYXNfcmV3YXJkc19jcHZfMhgVIAEoCzIdLmNvbmNvcmRpdW0udjIuR2FzUmV3YXJkc0NwdjJI'
    'AFIOZ2FzUmV3YXJkc0NwdjISUQoSdGltZW91dF9wYXJhbWV0ZXJzGBYgASgLMiAuY29uY29yZG'
    'l1bS52Mi5UaW1lb3V0UGFyYW1ldGVyc0gAUhF0aW1lb3V0UGFyYW1ldGVycxI/Cg5taW5fYmxv'
    'Y2tfdGltZRgXIAEoCzIXLmNvbmNvcmRpdW0udjIuRHVyYXRpb25IAFIMbWluQmxvY2tUaW1lEk'
    'UKEmJsb2NrX2VuZXJneV9saW1pdBgYIAEoCzIVLmNvbmNvcmRpdW0udjIuRW5lcmd5SABSEGJs'
    'b2NrRW5lcmd5TGltaXQSfAohZmluYWxpemF0aW9uX2NvbW1pdHRlZV9wYXJhbWV0ZXJzGBkgAS'
    'gLMi4uY29uY29yZGl1bS52Mi5GaW5hbGl6YXRpb25Db21taXR0ZWVQYXJhbWV0ZXJzSABSH2Zp'
    'bmFsaXphdGlvbkNvbW1pdHRlZVBhcmFtZXRlcnNCCAoGZWZmZWN0');

@$core.Deprecated('Use nextUpdateSequenceNumbersDescriptor instead')
const NextUpdateSequenceNumbers$json = {
  '1': 'NextUpdateSequenceNumbers',
  '2': [
    {'1': 'root_keys', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'rootKeys'},
    {'1': 'level1_keys', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'level1Keys'},
    {'1': 'level2_keys', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'level2Keys'},
    {'1': 'protocol', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'protocol'},
    {'1': 'election_difficulty', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'electionDifficulty'},
    {'1': 'euro_per_energy', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'euroPerEnergy'},
    {'1': 'micro_ccd_per_euro', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'microCcdPerEuro'},
    {'1': 'foundation_account', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'foundationAccount'},
    {'1': 'mint_distribution', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'mintDistribution'},
    {'1': 'transaction_fee_distribution', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'transactionFeeDistribution'},
    {'1': 'gas_rewards', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'gasRewards'},
    {'1': 'pool_parameters', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'poolParameters'},
    {'1': 'add_anonymity_revoker', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'addAnonymityRevoker'},
    {'1': 'add_identity_provider', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'addIdentityProvider'},
    {'1': 'cooldown_parameters', '3': 15, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'cooldownParameters'},
    {'1': 'time_parameters', '3': 16, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'timeParameters'},
    {'1': 'timeout_parameters', '3': 17, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'timeoutParameters'},
    {'1': 'min_block_time', '3': 18, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'minBlockTime'},
    {'1': 'block_energy_limit', '3': 19, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'blockEnergyLimit'},
    {'1': 'finalization_committee_parameters', '3': 20, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'finalizationCommitteeParameters'},
  ],
};

/// Descriptor for `NextUpdateSequenceNumbers`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nextUpdateSequenceNumbersDescriptor = $convert.base64Decode(
    'ChlOZXh0VXBkYXRlU2VxdWVuY2VOdW1iZXJzEjoKCXJvb3Rfa2V5cxgBIAEoCzIdLmNvbmNvcm'
    'RpdW0udjIuU2VxdWVuY2VOdW1iZXJSCHJvb3RLZXlzEj4KC2xldmVsMV9rZXlzGAIgASgLMh0u'
    'Y29uY29yZGl1bS52Mi5TZXF1ZW5jZU51bWJlclIKbGV2ZWwxS2V5cxI+CgtsZXZlbDJfa2V5cx'
    'gDIAEoCzIdLmNvbmNvcmRpdW0udjIuU2VxdWVuY2VOdW1iZXJSCmxldmVsMktleXMSOQoIcHJv'
    'dG9jb2wYBCABKAsyHS5jb25jb3JkaXVtLnYyLlNlcXVlbmNlTnVtYmVyUghwcm90b2NvbBJOCh'
    'NlbGVjdGlvbl9kaWZmaWN1bHR5GAUgASgLMh0uY29uY29yZGl1bS52Mi5TZXF1ZW5jZU51bWJl'
    'clISZWxlY3Rpb25EaWZmaWN1bHR5EkUKD2V1cm9fcGVyX2VuZXJneRgGIAEoCzIdLmNvbmNvcm'
    'RpdW0udjIuU2VxdWVuY2VOdW1iZXJSDWV1cm9QZXJFbmVyZ3kSSgoSbWljcm9fY2NkX3Blcl9l'
    'dXJvGAcgASgLMh0uY29uY29yZGl1bS52Mi5TZXF1ZW5jZU51bWJlclIPbWljcm9DY2RQZXJFdX'
    'JvEkwKEmZvdW5kYXRpb25fYWNjb3VudBgIIAEoCzIdLmNvbmNvcmRpdW0udjIuU2VxdWVuY2VO'
    'dW1iZXJSEWZvdW5kYXRpb25BY2NvdW50EkoKEW1pbnRfZGlzdHJpYnV0aW9uGAkgASgLMh0uY2'
    '9uY29yZGl1bS52Mi5TZXF1ZW5jZU51bWJlclIQbWludERpc3RyaWJ1dGlvbhJfChx0cmFuc2Fj'
    'dGlvbl9mZWVfZGlzdHJpYnV0aW9uGAogASgLMh0uY29uY29yZGl1bS52Mi5TZXF1ZW5jZU51bW'
    'JlclIadHJhbnNhY3Rpb25GZWVEaXN0cmlidXRpb24SPgoLZ2FzX3Jld2FyZHMYCyABKAsyHS5j'
    'b25jb3JkaXVtLnYyLlNlcXVlbmNlTnVtYmVyUgpnYXNSZXdhcmRzEkYKD3Bvb2xfcGFyYW1ldG'
    'VycxgMIAEoCzIdLmNvbmNvcmRpdW0udjIuU2VxdWVuY2VOdW1iZXJSDnBvb2xQYXJhbWV0ZXJz'
    'ElEKFWFkZF9hbm9ueW1pdHlfcmV2b2tlchgNIAEoCzIdLmNvbmNvcmRpdW0udjIuU2VxdWVuY2'
    'VOdW1iZXJSE2FkZEFub255bWl0eVJldm9rZXISUQoVYWRkX2lkZW50aXR5X3Byb3ZpZGVyGA4g'
    'ASgLMh0uY29uY29yZGl1bS52Mi5TZXF1ZW5jZU51bWJlclITYWRkSWRlbnRpdHlQcm92aWRlch'
    'JOChNjb29sZG93bl9wYXJhbWV0ZXJzGA8gASgLMh0uY29uY29yZGl1bS52Mi5TZXF1ZW5jZU51'
    'bWJlclISY29vbGRvd25QYXJhbWV0ZXJzEkYKD3RpbWVfcGFyYW1ldGVycxgQIAEoCzIdLmNvbm'
    'NvcmRpdW0udjIuU2VxdWVuY2VOdW1iZXJSDnRpbWVQYXJhbWV0ZXJzEkwKEnRpbWVvdXRfcGFy'
    'YW1ldGVycxgRIAEoCzIdLmNvbmNvcmRpdW0udjIuU2VxdWVuY2VOdW1iZXJSEXRpbWVvdXRQYX'
    'JhbWV0ZXJzEkMKDm1pbl9ibG9ja190aW1lGBIgASgLMh0uY29uY29yZGl1bS52Mi5TZXF1ZW5j'
    'ZU51bWJlclIMbWluQmxvY2tUaW1lEksKEmJsb2NrX2VuZXJneV9saW1pdBgTIAEoCzIdLmNvbm'
    'NvcmRpdW0udjIuU2VxdWVuY2VOdW1iZXJSEGJsb2NrRW5lcmd5TGltaXQSaQohZmluYWxpemF0'
    'aW9uX2NvbW1pdHRlZV9wYXJhbWV0ZXJzGBQgASgLMh0uY29uY29yZGl1bS52Mi5TZXF1ZW5jZU'
    '51bWJlclIfZmluYWxpemF0aW9uQ29tbWl0dGVlUGFyYW1ldGVycw==');

@$core.Deprecated('Use ipAddressDescriptor instead')
const IpAddress$json = {
  '1': 'IpAddress',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `IpAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ipAddressDescriptor = $convert.base64Decode(
    'CglJcEFkZHJlc3MSFAoFdmFsdWUYASABKAlSBXZhbHVl');

@$core.Deprecated('Use portDescriptor instead')
const Port$json = {
  '1': 'Port',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `Port`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portDescriptor = $convert.base64Decode(
    'CgRQb3J0EhQKBXZhbHVlGAEgASgNUgV2YWx1ZQ==');

@$core.Deprecated('Use ipSocketAddressDescriptor instead')
const IpSocketAddress$json = {
  '1': 'IpSocketAddress',
  '2': [
    {'1': 'ip', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.IpAddress', '10': 'ip'},
    {'1': 'port', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Port', '10': 'port'},
  ],
};

/// Descriptor for `IpSocketAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ipSocketAddressDescriptor = $convert.base64Decode(
    'Cg9JcFNvY2tldEFkZHJlc3MSKAoCaXAYASABKAsyGC5jb25jb3JkaXVtLnYyLklwQWRkcmVzc1'
    'ICaXASJwoEcG9ydBgCIAEoCzITLmNvbmNvcmRpdW0udjIuUG9ydFIEcG9ydA==');

@$core.Deprecated('Use peerIdDescriptor instead')
const PeerId$json = {
  '1': 'PeerId',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
  ],
};

/// Descriptor for `PeerId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerIdDescriptor = $convert.base64Decode(
    'CgZQZWVySWQSFAoFdmFsdWUYASABKAlSBXZhbHVl');

@$core.Deprecated('Use bannedPeerDescriptor instead')
const BannedPeer$json = {
  '1': 'BannedPeer',
  '2': [
    {'1': 'ip_address', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.IpAddress', '10': 'ipAddress'},
  ],
};

/// Descriptor for `BannedPeer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bannedPeerDescriptor = $convert.base64Decode(
    'CgpCYW5uZWRQZWVyEjcKCmlwX2FkZHJlc3MYASABKAsyGC5jb25jb3JkaXVtLnYyLklwQWRkcm'
    'Vzc1IJaXBBZGRyZXNz');

@$core.Deprecated('Use bannedPeersDescriptor instead')
const BannedPeers$json = {
  '1': 'BannedPeers',
  '2': [
    {'1': 'peers', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.BannedPeer', '10': 'peers'},
  ],
};

/// Descriptor for `BannedPeers`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bannedPeersDescriptor = $convert.base64Decode(
    'CgtCYW5uZWRQZWVycxIvCgVwZWVycxgBIAMoCzIZLmNvbmNvcmRpdW0udjIuQmFubmVkUGVlcl'
    'IFcGVlcnM=');

@$core.Deprecated('Use peerToBanDescriptor instead')
const PeerToBan$json = {
  '1': 'PeerToBan',
  '2': [
    {'1': 'ip_address', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.IpAddress', '10': 'ipAddress'},
  ],
};

/// Descriptor for `PeerToBan`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerToBanDescriptor = $convert.base64Decode(
    'CglQZWVyVG9CYW4SNwoKaXBfYWRkcmVzcxgBIAEoCzIYLmNvbmNvcmRpdW0udjIuSXBBZGRyZX'
    'NzUglpcEFkZHJlc3M=');

@$core.Deprecated('Use dumpRequestDescriptor instead')
const DumpRequest$json = {
  '1': 'DumpRequest',
  '2': [
    {'1': 'file', '3': 1, '4': 1, '5': 9, '10': 'file'},
    {'1': 'raw', '3': 2, '4': 1, '5': 8, '10': 'raw'},
  ],
};

/// Descriptor for `DumpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dumpRequestDescriptor = $convert.base64Decode(
    'CgtEdW1wUmVxdWVzdBISCgRmaWxlGAEgASgJUgRmaWxlEhAKA3JhdxgCIAEoCFIDcmF3');

@$core.Deprecated('Use peersInfoDescriptor instead')
const PeersInfo$json = {
  '1': 'PeersInfo',
  '2': [
    {'1': 'peers', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.PeersInfo.Peer', '10': 'peers'},
  ],
  '3': [PeersInfo_Peer$json],
};

@$core.Deprecated('Use peersInfoDescriptor instead')
const PeersInfo_Peer$json = {
  '1': 'Peer',
  '2': [
    {'1': 'peer_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.PeerId', '10': 'peerId'},
    {'1': 'socket_address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.IpSocketAddress', '10': 'socketAddress'},
    {'1': 'network_stats', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.PeersInfo.Peer.NetworkStats', '10': 'networkStats'},
    {'1': 'bootstrapper', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'bootstrapper'},
    {'1': 'node_catchup_status', '3': 5, '4': 1, '5': 14, '6': '.concordium.v2.PeersInfo.Peer.CatchupStatus', '9': 0, '10': 'nodeCatchupStatus'},
  ],
  '3': [PeersInfo_Peer_NetworkStats$json],
  '4': [PeersInfo_Peer_CatchupStatus$json],
  '8': [
    {'1': 'consensus_info'},
  ],
};

@$core.Deprecated('Use peersInfoDescriptor instead')
const PeersInfo_Peer_NetworkStats$json = {
  '1': 'NetworkStats',
  '2': [
    {'1': 'packets_sent', '3': 2, '4': 1, '5': 4, '10': 'packetsSent'},
    {'1': 'packets_received', '3': 3, '4': 1, '5': 4, '10': 'packetsReceived'},
    {'1': 'latency', '3': 4, '4': 1, '5': 4, '10': 'latency'},
  ],
};

@$core.Deprecated('Use peersInfoDescriptor instead')
const PeersInfo_Peer_CatchupStatus$json = {
  '1': 'CatchupStatus',
  '2': [
    {'1': 'UPTODATE', '2': 0},
    {'1': 'PENDING', '2': 1},
    {'1': 'CATCHINGUP', '2': 2},
  ],
};

/// Descriptor for `PeersInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peersInfoDescriptor = $convert.base64Decode(
    'CglQZWVyc0luZm8SMwoFcGVlcnMYASADKAsyHS5jb25jb3JkaXVtLnYyLlBlZXJzSW5mby5QZW'
    'VyUgVwZWVycxqvBAoEUGVlchIuCgdwZWVyX2lkGAEgASgLMhUuY29uY29yZGl1bS52Mi5QZWVy'
    'SWRSBnBlZXJJZBJFCg5zb2NrZXRfYWRkcmVzcxgCIAEoCzIeLmNvbmNvcmRpdW0udjIuSXBTb2'
    'NrZXRBZGRyZXNzUg1zb2NrZXRBZGRyZXNzEk8KDW5ldHdvcmtfc3RhdHMYAyABKAsyKi5jb25j'
    'b3JkaXVtLnYyLlBlZXJzSW5mby5QZWVyLk5ldHdvcmtTdGF0c1IMbmV0d29ya1N0YXRzEjoKDG'
    'Jvb3RzdHJhcHBlchgEIAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIMYm9vdHN0cmFwcGVy'
    'El0KE25vZGVfY2F0Y2h1cF9zdGF0dXMYBSABKA4yKy5jb25jb3JkaXVtLnYyLlBlZXJzSW5mby'
    '5QZWVyLkNhdGNodXBTdGF0dXNIAFIRbm9kZUNhdGNodXBTdGF0dXMadgoMTmV0d29ya1N0YXRz'
    'EiEKDHBhY2tldHNfc2VudBgCIAEoBFILcGFja2V0c1NlbnQSKQoQcGFja2V0c19yZWNlaXZlZB'
    'gDIAEoBFIPcGFja2V0c1JlY2VpdmVkEhgKB2xhdGVuY3kYBCABKARSB2xhdGVuY3kiOgoNQ2F0'
    'Y2h1cFN0YXR1cxIMCghVUFRPREFURRAAEgsKB1BFTkRJTkcQARIOCgpDQVRDSElOR1VQEAJCEA'
    'oOY29uc2Vuc3VzX2luZm8=');

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo$json = {
  '1': 'NodeInfo',
  '2': [
    {'1': 'peer_version', '3': 1, '4': 1, '5': 9, '10': 'peerVersion'},
    {'1': 'local_time', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'localTime'},
    {'1': 'peer_uptime', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Duration', '10': 'peerUptime'},
    {'1': 'network_info', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.NodeInfo.NetworkInfo', '10': 'networkInfo'},
    {'1': 'bootstrapper', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'bootstrapper'},
    {'1': 'node', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.NodeInfo.Node', '9': 0, '10': 'node'},
  ],
  '3': [NodeInfo_NetworkInfo$json, NodeInfo_BakerConsensusInfo$json, NodeInfo_Node$json],
  '8': [
    {'1': 'details'},
  ],
};

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo_NetworkInfo$json = {
  '1': 'NetworkInfo',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.PeerId', '10': 'nodeId'},
    {'1': 'peer_total_sent', '3': 2, '4': 1, '5': 4, '10': 'peerTotalSent'},
    {'1': 'peer_total_received', '3': 3, '4': 1, '5': 4, '10': 'peerTotalReceived'},
    {'1': 'avg_bps_in', '3': 4, '4': 1, '5': 4, '10': 'avgBpsIn'},
    {'1': 'avg_bps_out', '3': 5, '4': 1, '5': 4, '10': 'avgBpsOut'},
  ],
};

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo_BakerConsensusInfo$json = {
  '1': 'BakerConsensusInfo',
  '2': [
    {'1': 'baker_id', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'bakerId'},
    {'1': 'passive_committee_info', '3': 2, '4': 1, '5': 14, '6': '.concordium.v2.NodeInfo.BakerConsensusInfo.PassiveCommitteeInfo', '9': 0, '10': 'passiveCommitteeInfo'},
    {'1': 'active_baker_committee_info', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.NodeInfo.BakerConsensusInfo.ActiveBakerCommitteeInfo', '9': 0, '10': 'activeBakerCommitteeInfo'},
    {'1': 'active_finalizer_committee_info', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.NodeInfo.BakerConsensusInfo.ActiveFinalizerCommitteeInfo', '9': 0, '10': 'activeFinalizerCommitteeInfo'},
  ],
  '3': [NodeInfo_BakerConsensusInfo_ActiveBakerCommitteeInfo$json, NodeInfo_BakerConsensusInfo_ActiveFinalizerCommitteeInfo$json],
  '4': [NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo$json],
  '8': [
    {'1': 'status'},
  ],
};

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo_BakerConsensusInfo_ActiveBakerCommitteeInfo$json = {
  '1': 'ActiveBakerCommitteeInfo',
};

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo_BakerConsensusInfo_ActiveFinalizerCommitteeInfo$json = {
  '1': 'ActiveFinalizerCommitteeInfo',
};

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo$json = {
  '1': 'PassiveCommitteeInfo',
  '2': [
    {'1': 'NOT_IN_COMMITTEE', '2': 0},
    {'1': 'ADDED_BUT_NOT_ACTIVE_IN_COMMITTEE', '2': 1},
    {'1': 'ADDED_BUT_WRONG_KEYS', '2': 2},
  ],
};

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo_Node$json = {
  '1': 'Node',
  '2': [
    {'1': 'not_running', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'notRunning'},
    {'1': 'passive', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'passive'},
    {'1': 'active', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.NodeInfo.BakerConsensusInfo', '9': 0, '10': 'active'},
  ],
  '8': [
    {'1': 'consensus_status'},
  ],
};

/// Descriptor for `NodeInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeInfoDescriptor = $convert.base64Decode(
    'CghOb2RlSW5mbxIhCgxwZWVyX3ZlcnNpb24YASABKAlSC3BlZXJWZXJzaW9uEjcKCmxvY2FsX3'
    'RpbWUYAyABKAsyGC5jb25jb3JkaXVtLnYyLlRpbWVzdGFtcFIJbG9jYWxUaW1lEjgKC3BlZXJf'
    'dXB0aW1lGAQgASgLMhcuY29uY29yZGl1bS52Mi5EdXJhdGlvblIKcGVlclVwdGltZRJGCgxuZX'
    'R3b3JrX2luZm8YBSABKAsyIy5jb25jb3JkaXVtLnYyLk5vZGVJbmZvLk5ldHdvcmtJbmZvUgtu'
    'ZXR3b3JrSW5mbxI6Cgxib290c3RyYXBwZXIYBiABKAsyFC5jb25jb3JkaXVtLnYyLkVtcHR5SA'
    'BSDGJvb3RzdHJhcHBlchIyCgRub2RlGAcgASgLMhwuY29uY29yZGl1bS52Mi5Ob2RlSW5mby5O'
    'b2RlSABSBG5vZGUa0wEKC05ldHdvcmtJbmZvEi4KB25vZGVfaWQYASABKAsyFS5jb25jb3JkaX'
    'VtLnYyLlBlZXJJZFIGbm9kZUlkEiYKD3BlZXJfdG90YWxfc2VudBgCIAEoBFINcGVlclRvdGFs'
    'U2VudBIuChNwZWVyX3RvdGFsX3JlY2VpdmVkGAMgASgEUhFwZWVyVG90YWxSZWNlaXZlZBIcCg'
    'phdmdfYnBzX2luGAQgASgEUghhdmdCcHNJbhIeCgthdmdfYnBzX291dBgFIAEoBFIJYXZnQnBz'
    'T3V0Go8FChJCYWtlckNvbnNlbnN1c0luZm8SMQoIYmFrZXJfaWQYASABKAsyFi5jb25jb3JkaX'
    'VtLnYyLkJha2VySWRSB2Jha2VySWQSdwoWcGFzc2l2ZV9jb21taXR0ZWVfaW5mbxgCIAEoDjI/'
    'LmNvbmNvcmRpdW0udjIuTm9kZUluZm8uQmFrZXJDb25zZW5zdXNJbmZvLlBhc3NpdmVDb21taX'
    'R0ZWVJbmZvSABSFHBhc3NpdmVDb21taXR0ZWVJbmZvEoQBChthY3RpdmVfYmFrZXJfY29tbWl0'
    'dGVlX2luZm8YAyABKAsyQy5jb25jb3JkaXVtLnYyLk5vZGVJbmZvLkJha2VyQ29uc2Vuc3VzSW'
    '5mby5BY3RpdmVCYWtlckNvbW1pdHRlZUluZm9IAFIYYWN0aXZlQmFrZXJDb21taXR0ZWVJbmZv'
    'EpABCh9hY3RpdmVfZmluYWxpemVyX2NvbW1pdHRlZV9pbmZvGAQgASgLMkcuY29uY29yZGl1bS'
    '52Mi5Ob2RlSW5mby5CYWtlckNvbnNlbnN1c0luZm8uQWN0aXZlRmluYWxpemVyQ29tbWl0dGVl'
    'SW5mb0gAUhxhY3RpdmVGaW5hbGl6ZXJDb21taXR0ZWVJbmZvGhoKGEFjdGl2ZUJha2VyQ29tbW'
    'l0dGVlSW5mbxoeChxBY3RpdmVGaW5hbGl6ZXJDb21taXR0ZWVJbmZvIm0KFFBhc3NpdmVDb21t'
    'aXR0ZWVJbmZvEhQKEE5PVF9JTl9DT01NSVRURUUQABIlCiFBRERFRF9CVVRfTk9UX0FDVElWRV'
    '9JTl9DT01NSVRURUUQARIYChRBRERFRF9CVVRfV1JPTkdfS0VZUxACQggKBnN0YXR1cxrLAQoE'
    'Tm9kZRI3Cgtub3RfcnVubmluZxgBIAEoCzIULmNvbmNvcmRpdW0udjIuRW1wdHlIAFIKbm90Un'
    'VubmluZxIwCgdwYXNzaXZlGAIgASgLMhQuY29uY29yZGl1bS52Mi5FbXB0eUgAUgdwYXNzaXZl'
    'EkQKBmFjdGl2ZRgDIAEoCzIqLmNvbmNvcmRpdW0udjIuTm9kZUluZm8uQmFrZXJDb25zZW5zdX'
    'NJbmZvSABSBmFjdGl2ZUISChBjb25zZW5zdXNfc3RhdHVzQgkKB2RldGFpbHM=');

@$core.Deprecated('Use sendBlockItemRequestDescriptor instead')
const SendBlockItemRequest$json = {
  '1': 'SendBlockItemRequest',
  '2': [
    {'1': 'account_transaction', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransaction', '9': 0, '10': 'accountTransaction'},
    {'1': 'credential_deployment', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.CredentialDeployment', '9': 0, '10': 'credentialDeployment'},
    {'1': 'update_instruction', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.UpdateInstruction', '9': 0, '10': 'updateInstruction'},
  ],
  '8': [
    {'1': 'block_item'},
  ],
};

/// Descriptor for `SendBlockItemRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendBlockItemRequestDescriptor = $convert.base64Decode(
    'ChRTZW5kQmxvY2tJdGVtUmVxdWVzdBJUChNhY2NvdW50X3RyYW5zYWN0aW9uGAEgASgLMiEuY2'
    '9uY29yZGl1bS52Mi5BY2NvdW50VHJhbnNhY3Rpb25IAFISYWNjb3VudFRyYW5zYWN0aW9uEloK'
    'FWNyZWRlbnRpYWxfZGVwbG95bWVudBgCIAEoCzIjLmNvbmNvcmRpdW0udjIuQ3JlZGVudGlhbE'
    'RlcGxveW1lbnRIAFIUY3JlZGVudGlhbERlcGxveW1lbnQSUQoSdXBkYXRlX2luc3RydWN0aW9u'
    'GAMgASgLMiAuY29uY29yZGl1bS52Mi5VcGRhdGVJbnN0cnVjdGlvbkgAUhF1cGRhdGVJbnN0cn'
    'VjdGlvbkIMCgpibG9ja19pdGVt');

@$core.Deprecated('Use credentialDeploymentDescriptor instead')
const CredentialDeployment$json = {
  '1': 'CredentialDeployment',
  '2': [
    {'1': 'message_expiry', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.TransactionTime', '10': 'messageExpiry'},
    {'1': 'raw_payload', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'rawPayload'},
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `CredentialDeployment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List credentialDeploymentDescriptor = $convert.base64Decode(
    'ChRDcmVkZW50aWFsRGVwbG95bWVudBJFCg5tZXNzYWdlX2V4cGlyeRgBIAEoCzIeLmNvbmNvcm'
    'RpdW0udjIuVHJhbnNhY3Rpb25UaW1lUg1tZXNzYWdlRXhwaXJ5EiEKC3Jhd19wYXlsb2FkGAIg'
    'ASgMSABSCnJhd1BheWxvYWRCCQoHcGF5bG9hZA==');

@$core.Deprecated('Use signatureDescriptor instead')
const Signature$json = {
  '1': 'Signature',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `Signature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signatureDescriptor = $convert.base64Decode(
    'CglTaWduYXR1cmUSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use signatureMapDescriptor instead')
const SignatureMap$json = {
  '1': 'SignatureMap',
  '2': [
    {'1': 'signatures', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.SignatureMap.SignaturesEntry', '10': 'signatures'},
  ],
  '3': [SignatureMap_SignaturesEntry$json],
};

@$core.Deprecated('Use signatureMapDescriptor instead')
const SignatureMap_SignaturesEntry$json = {
  '1': 'SignaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Signature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SignatureMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signatureMapDescriptor = $convert.base64Decode(
    'CgxTaWduYXR1cmVNYXASSwoKc2lnbmF0dXJlcxgBIAMoCzIrLmNvbmNvcmRpdW0udjIuU2lnbm'
    'F0dXJlTWFwLlNpZ25hdHVyZXNFbnRyeVIKc2lnbmF0dXJlcxpXCg9TaWduYXR1cmVzRW50cnkS'
    'EAoDa2V5GAEgASgNUgNrZXkSLgoFdmFsdWUYAiABKAsyGC5jb25jb3JkaXVtLnYyLlNpZ25hdH'
    'VyZVIFdmFsdWU6AjgB');

@$core.Deprecated('Use accountSignatureMapDescriptor instead')
const AccountSignatureMap$json = {
  '1': 'AccountSignatureMap',
  '2': [
    {'1': 'signatures', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.AccountSignatureMap.SignaturesEntry', '10': 'signatures'},
  ],
  '3': [AccountSignatureMap_SignaturesEntry$json],
};

@$core.Deprecated('Use accountSignatureMapDescriptor instead')
const AccountSignatureMap_SignaturesEntry$json = {
  '1': 'SignaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Signature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `AccountSignatureMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountSignatureMapDescriptor = $convert.base64Decode(
    'ChNBY2NvdW50U2lnbmF0dXJlTWFwElIKCnNpZ25hdHVyZXMYASADKAsyMi5jb25jb3JkaXVtLn'
    'YyLkFjY291bnRTaWduYXR1cmVNYXAuU2lnbmF0dXJlc0VudHJ5UgpzaWduYXR1cmVzGlcKD1Np'
    'Z25hdHVyZXNFbnRyeRIQCgNrZXkYASABKA1SA2tleRIuCgV2YWx1ZRgCIAEoCzIYLmNvbmNvcm'
    'RpdW0udjIuU2lnbmF0dXJlUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use accountTransactionSignatureDescriptor instead')
const AccountTransactionSignature$json = {
  '1': 'AccountTransactionSignature',
  '2': [
    {'1': 'signatures', '3': 1, '4': 3, '5': 11, '6': '.concordium.v2.AccountTransactionSignature.SignaturesEntry', '10': 'signatures'},
  ],
  '3': [AccountTransactionSignature_SignaturesEntry$json],
};

@$core.Deprecated('Use accountTransactionSignatureDescriptor instead')
const AccountTransactionSignature_SignaturesEntry$json = {
  '1': 'SignaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountSignatureMap', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `AccountTransactionSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountTransactionSignatureDescriptor = $convert.base64Decode(
    'ChtBY2NvdW50VHJhbnNhY3Rpb25TaWduYXR1cmUSWgoKc2lnbmF0dXJlcxgBIAMoCzI6LmNvbm'
    'NvcmRpdW0udjIuQWNjb3VudFRyYW5zYWN0aW9uU2lnbmF0dXJlLlNpZ25hdHVyZXNFbnRyeVIK'
    'c2lnbmF0dXJlcxphCg9TaWduYXR1cmVzRW50cnkSEAoDa2V5GAEgASgNUgNrZXkSOAoFdmFsdW'
    'UYAiABKAsyIi5jb25jb3JkaXVtLnYyLkFjY291bnRTaWduYXR1cmVNYXBSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use accountTransactionHeaderDescriptor instead')
const AccountTransactionHeader$json = {
  '1': 'AccountTransactionHeader',
  '2': [
    {'1': 'sender', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'sender'},
    {'1': 'sequence_number', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.SequenceNumber', '10': 'sequenceNumber'},
    {'1': 'energy_amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'energyAmount'},
    {'1': 'expiry', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.TransactionTime', '10': 'expiry'},
  ],
};

/// Descriptor for `AccountTransactionHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountTransactionHeaderDescriptor = $convert.base64Decode(
    'ChhBY2NvdW50VHJhbnNhY3Rpb25IZWFkZXISNQoGc2VuZGVyGAEgASgLMh0uY29uY29yZGl1bS'
    '52Mi5BY2NvdW50QWRkcmVzc1IGc2VuZGVyEkYKD3NlcXVlbmNlX251bWJlchgCIAEoCzIdLmNv'
    'bmNvcmRpdW0udjIuU2VxdWVuY2VOdW1iZXJSDnNlcXVlbmNlTnVtYmVyEjoKDWVuZXJneV9hbW'
    '91bnQYAyABKAsyFS5jb25jb3JkaXVtLnYyLkVuZXJneVIMZW5lcmd5QW1vdW50EjYKBmV4cGly'
    'eRgFIAEoCzIeLmNvbmNvcmRpdW0udjIuVHJhbnNhY3Rpb25UaW1lUgZleHBpcnk=');

@$core.Deprecated('Use initContractPayloadDescriptor instead')
const InitContractPayload$json = {
  '1': 'InitContractPayload',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'module_ref', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ModuleRef', '10': 'moduleRef'},
    {'1': 'init_name', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.InitName', '10': 'initName'},
    {'1': 'parameter', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Parameter', '10': 'parameter'},
  ],
};

/// Descriptor for `InitContractPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initContractPayloadDescriptor = $convert.base64Decode(
    'ChNJbml0Q29udHJhY3RQYXlsb2FkEi0KBmFtb3VudBgBIAEoCzIVLmNvbmNvcmRpdW0udjIuQW'
    '1vdW50UgZhbW91bnQSNwoKbW9kdWxlX3JlZhgCIAEoCzIYLmNvbmNvcmRpdW0udjIuTW9kdWxl'
    'UmVmUgltb2R1bGVSZWYSNAoJaW5pdF9uYW1lGAMgASgLMhcuY29uY29yZGl1bS52Mi5Jbml0Tm'
    'FtZVIIaW5pdE5hbWUSNgoJcGFyYW1ldGVyGAQgASgLMhguY29uY29yZGl1bS52Mi5QYXJhbWV0'
    'ZXJSCXBhcmFtZXRlcg==');

@$core.Deprecated('Use updateContractPayloadDescriptor instead')
const UpdateContractPayload$json = {
  '1': 'UpdateContractPayload',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'address', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'address'},
    {'1': 'receive_name', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'receiveName'},
    {'1': 'parameter', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Parameter', '10': 'parameter'},
  ],
};

/// Descriptor for `UpdateContractPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateContractPayloadDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVDb250cmFjdFBheWxvYWQSLQoGYW1vdW50GAEgASgLMhUuY29uY29yZGl1bS52Mi'
    '5BbW91bnRSBmFtb3VudBI4CgdhZGRyZXNzGAIgASgLMh4uY29uY29yZGl1bS52Mi5Db250cmFj'
    'dEFkZHJlc3NSB2FkZHJlc3MSPQoMcmVjZWl2ZV9uYW1lGAMgASgLMhouY29uY29yZGl1bS52Mi'
    '5SZWNlaXZlTmFtZVILcmVjZWl2ZU5hbWUSNgoJcGFyYW1ldGVyGAQgASgLMhguY29uY29yZGl1'
    'bS52Mi5QYXJhbWV0ZXJSCXBhcmFtZXRlcg==');

@$core.Deprecated('Use transferPayloadDescriptor instead')
const TransferPayload$json = {
  '1': 'TransferPayload',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'receiver', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'receiver'},
  ],
};

/// Descriptor for `TransferPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferPayloadDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2ZlclBheWxvYWQSLQoGYW1vdW50GAEgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bn'
    'RSBmFtb3VudBI5CghyZWNlaXZlchgCIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJl'
    'c3NSCHJlY2VpdmVy');

@$core.Deprecated('Use transferWithMemoPayloadDescriptor instead')
const TransferWithMemoPayload$json = {
  '1': 'TransferWithMemoPayload',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'receiver', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'receiver'},
    {'1': 'memo', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Memo', '10': 'memo'},
  ],
};

/// Descriptor for `TransferWithMemoPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferWithMemoPayloadDescriptor = $convert.base64Decode(
    'ChdUcmFuc2ZlcldpdGhNZW1vUGF5bG9hZBItCgZhbW91bnQYASABKAsyFS5jb25jb3JkaXVtLn'
    'YyLkFtb3VudFIGYW1vdW50EjkKCHJlY2VpdmVyGAIgASgLMh0uY29uY29yZGl1bS52Mi5BY2Nv'
    'dW50QWRkcmVzc1IIcmVjZWl2ZXISJwoEbWVtbxgDIAEoCzITLmNvbmNvcmRpdW0udjIuTWVtb1'
    'IEbWVtbw==');

@$core.Deprecated('Use accountTransactionPayloadDescriptor instead')
const AccountTransactionPayload$json = {
  '1': 'AccountTransactionPayload',
  '2': [
    {'1': 'raw_payload', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'rawPayload'},
    {'1': 'deploy_module', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.VersionedModuleSource', '9': 0, '10': 'deployModule'},
    {'1': 'init_contract', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.InitContractPayload', '9': 0, '10': 'initContract'},
    {'1': 'update_contract', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.UpdateContractPayload', '9': 0, '10': 'updateContract'},
    {'1': 'transfer', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.TransferPayload', '9': 0, '10': 'transfer'},
    {'1': 'transfer_with_memo', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.TransferWithMemoPayload', '9': 0, '10': 'transferWithMemo'},
    {'1': 'register_data', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.RegisteredData', '9': 0, '10': 'registerData'},
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `AccountTransactionPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountTransactionPayloadDescriptor = $convert.base64Decode(
    'ChlBY2NvdW50VHJhbnNhY3Rpb25QYXlsb2FkEiEKC3Jhd19wYXlsb2FkGAEgASgMSABSCnJhd1'
    'BheWxvYWQSSwoNZGVwbG95X21vZHVsZRgCIAEoCzIkLmNvbmNvcmRpdW0udjIuVmVyc2lvbmVk'
    'TW9kdWxlU291cmNlSABSDGRlcGxveU1vZHVsZRJJCg1pbml0X2NvbnRyYWN0GAMgASgLMiIuY2'
    '9uY29yZGl1bS52Mi5Jbml0Q29udHJhY3RQYXlsb2FkSABSDGluaXRDb250cmFjdBJPCg91cGRh'
    'dGVfY29udHJhY3QYBCABKAsyJC5jb25jb3JkaXVtLnYyLlVwZGF0ZUNvbnRyYWN0UGF5bG9hZE'
    'gAUg51cGRhdGVDb250cmFjdBI8Cgh0cmFuc2ZlchgFIAEoCzIeLmNvbmNvcmRpdW0udjIuVHJh'
    'bnNmZXJQYXlsb2FkSABSCHRyYW5zZmVyElYKEnRyYW5zZmVyX3dpdGhfbWVtbxgGIAEoCzImLm'
    'NvbmNvcmRpdW0udjIuVHJhbnNmZXJXaXRoTWVtb1BheWxvYWRIAFIQdHJhbnNmZXJXaXRoTWVt'
    'bxJECg1yZWdpc3Rlcl9kYXRhGAcgASgLMh0uY29uY29yZGl1bS52Mi5SZWdpc3RlcmVkRGF0YU'
    'gAUgxyZWdpc3RlckRhdGFCCQoHcGF5bG9hZA==');

@$core.Deprecated('Use preAccountTransactionDescriptor instead')
const PreAccountTransaction$json = {
  '1': 'PreAccountTransaction',
  '2': [
    {'1': 'header', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionHeader', '10': 'header'},
    {'1': 'payload', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionPayload', '10': 'payload'},
  ],
};

/// Descriptor for `PreAccountTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preAccountTransactionDescriptor = $convert.base64Decode(
    'ChVQcmVBY2NvdW50VHJhbnNhY3Rpb24SPwoGaGVhZGVyGAEgASgLMicuY29uY29yZGl1bS52Mi'
    '5BY2NvdW50VHJhbnNhY3Rpb25IZWFkZXJSBmhlYWRlchJCCgdwYXlsb2FkGAIgASgLMiguY29u'
    'Y29yZGl1bS52Mi5BY2NvdW50VHJhbnNhY3Rpb25QYXlsb2FkUgdwYXlsb2Fk');

@$core.Deprecated('Use accountTransactionDescriptor instead')
const AccountTransaction$json = {
  '1': 'AccountTransaction',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionSignature', '10': 'signature'},
    {'1': 'header', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionHeader', '10': 'header'},
    {'1': 'payload', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionPayload', '10': 'payload'},
  ],
};

/// Descriptor for `AccountTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountTransactionDescriptor = $convert.base64Decode(
    'ChJBY2NvdW50VHJhbnNhY3Rpb24SSAoJc2lnbmF0dXJlGAEgASgLMiouY29uY29yZGl1bS52Mi'
    '5BY2NvdW50VHJhbnNhY3Rpb25TaWduYXR1cmVSCXNpZ25hdHVyZRI/CgZoZWFkZXIYAiABKAsy'
    'Jy5jb25jb3JkaXVtLnYyLkFjY291bnRUcmFuc2FjdGlvbkhlYWRlclIGaGVhZGVyEkIKB3BheW'
    'xvYWQYAyABKAsyKC5jb25jb3JkaXVtLnYyLkFjY291bnRUcmFuc2FjdGlvblBheWxvYWRSB3Bh'
    'eWxvYWQ=');

@$core.Deprecated('Use updateInstructionHeaderDescriptor instead')
const UpdateInstructionHeader$json = {
  '1': 'UpdateInstructionHeader',
  '2': [
    {'1': 'sequence_number', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.UpdateSequenceNumber', '10': 'sequenceNumber'},
    {'1': 'effective_time', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.TransactionTime', '10': 'effectiveTime'},
    {'1': 'timeout', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.TransactionTime', '10': 'timeout'},
  ],
};

/// Descriptor for `UpdateInstructionHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInstructionHeaderDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVJbnN0cnVjdGlvbkhlYWRlchJMCg9zZXF1ZW5jZV9udW1iZXIYASABKAsyIy5jb2'
    '5jb3JkaXVtLnYyLlVwZGF0ZVNlcXVlbmNlTnVtYmVyUg5zZXF1ZW5jZU51bWJlchJFCg5lZmZl'
    'Y3RpdmVfdGltZRgCIAEoCzIeLmNvbmNvcmRpdW0udjIuVHJhbnNhY3Rpb25UaW1lUg1lZmZlY3'
    'RpdmVUaW1lEjgKB3RpbWVvdXQYAyABKAsyHi5jb25jb3JkaXVtLnYyLlRyYW5zYWN0aW9uVGlt'
    'ZVIHdGltZW91dA==');

@$core.Deprecated('Use updateInstructionPayloadDescriptor instead')
const UpdateInstructionPayload$json = {
  '1': 'UpdateInstructionPayload',
  '2': [
    {'1': 'raw_payload', '3': 3, '4': 1, '5': 12, '9': 0, '10': 'rawPayload'},
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `UpdateInstructionPayload`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInstructionPayloadDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVJbnN0cnVjdGlvblBheWxvYWQSIQoLcmF3X3BheWxvYWQYAyABKAxIAFIKcmF3UG'
    'F5bG9hZEIJCgdwYXlsb2Fk');

@$core.Deprecated('Use updateInstructionDescriptor instead')
const UpdateInstruction$json = {
  '1': 'UpdateInstruction',
  '2': [
    {'1': 'signatures', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.SignatureMap', '10': 'signatures'},
    {'1': 'header', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.UpdateInstructionHeader', '10': 'header'},
    {'1': 'payload', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.UpdateInstructionPayload', '10': 'payload'},
  ],
};

/// Descriptor for `UpdateInstruction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateInstructionDescriptor = $convert.base64Decode(
    'ChFVcGRhdGVJbnN0cnVjdGlvbhI7CgpzaWduYXR1cmVzGAEgASgLMhsuY29uY29yZGl1bS52Mi'
    '5TaWduYXR1cmVNYXBSCnNpZ25hdHVyZXMSPgoGaGVhZGVyGAIgASgLMiYuY29uY29yZGl1bS52'
    'Mi5VcGRhdGVJbnN0cnVjdGlvbkhlYWRlclIGaGVhZGVyEkEKB3BheWxvYWQYAyABKAsyJy5jb2'
    '5jb3JkaXVtLnYyLlVwZGF0ZUluc3RydWN0aW9uUGF5bG9hZFIHcGF5bG9hZA==');

@$core.Deprecated('Use accountTransactionSignHashDescriptor instead')
const AccountTransactionSignHash$json = {
  '1': 'AccountTransactionSignHash',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `AccountTransactionSignHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accountTransactionSignHashDescriptor = $convert.base64Decode(
    'ChpBY2NvdW50VHJhbnNhY3Rpb25TaWduSGFzaBIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use credentialsPerBlockLimitDescriptor instead')
const CredentialsPerBlockLimit$json = {
  '1': 'CredentialsPerBlockLimit',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 13, '10': 'value'},
  ],
};

/// Descriptor for `CredentialsPerBlockLimit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List credentialsPerBlockLimitDescriptor = $convert.base64Decode(
    'ChhDcmVkZW50aWFsc1BlckJsb2NrTGltaXQSFAoFdmFsdWUYASABKA1SBXZhbHVl');

@$core.Deprecated('Use chainParametersV0Descriptor instead')
const ChainParametersV0$json = {
  '1': 'ChainParametersV0',
  '2': [
    {'1': 'election_difficulty', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ElectionDifficulty', '10': 'electionDifficulty'},
    {'1': 'euro_per_energy', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '10': 'euroPerEnergy'},
    {'1': 'micro_ccd_per_euro', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '10': 'microCcdPerEuro'},
    {'1': 'baker_cooldown_epochs', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Epoch', '10': 'bakerCooldownEpochs'},
    {'1': 'account_creation_limit', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.CredentialsPerBlockLimit', '10': 'accountCreationLimit'},
    {'1': 'mint_distribution', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.MintDistributionCpv0', '10': 'mintDistribution'},
    {'1': 'transaction_fee_distribution', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.TransactionFeeDistribution', '10': 'transactionFeeDistribution'},
    {'1': 'gas_rewards', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.GasRewards', '10': 'gasRewards'},
    {'1': 'foundation_account', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'foundationAccount'},
    {'1': 'minimum_threshold_for_baking', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'minimumThresholdForBaking'},
    {'1': 'root_keys', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '10': 'rootKeys'},
    {'1': 'level1_keys', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '10': 'level1Keys'},
    {'1': 'level2_keys', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV0', '10': 'level2Keys'},
  ],
};

/// Descriptor for `ChainParametersV0`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chainParametersV0Descriptor = $convert.base64Decode(
    'ChFDaGFpblBhcmFtZXRlcnNWMBJSChNlbGVjdGlvbl9kaWZmaWN1bHR5GAEgASgLMiEuY29uY2'
    '9yZGl1bS52Mi5FbGVjdGlvbkRpZmZpY3VsdHlSEmVsZWN0aW9uRGlmZmljdWx0eRJDCg9ldXJv'
    'X3Blcl9lbmVyZ3kYAiABKAsyGy5jb25jb3JkaXVtLnYyLkV4Y2hhbmdlUmF0ZVINZXVyb1Blck'
    'VuZXJneRJIChJtaWNyb19jY2RfcGVyX2V1cm8YAyABKAsyGy5jb25jb3JkaXVtLnYyLkV4Y2hh'
    'bmdlUmF0ZVIPbWljcm9DY2RQZXJFdXJvEkgKFWJha2VyX2Nvb2xkb3duX2Vwb2NocxgEIAEoCz'
    'IULmNvbmNvcmRpdW0udjIuRXBvY2hSE2Jha2VyQ29vbGRvd25FcG9jaHMSXQoWYWNjb3VudF9j'
    'cmVhdGlvbl9saW1pdBgFIAEoCzInLmNvbmNvcmRpdW0udjIuQ3JlZGVudGlhbHNQZXJCbG9ja0'
    'xpbWl0UhRhY2NvdW50Q3JlYXRpb25MaW1pdBJQChFtaW50X2Rpc3RyaWJ1dGlvbhgGIAEoCzIj'
    'LmNvbmNvcmRpdW0udjIuTWludERpc3RyaWJ1dGlvbkNwdjBSEG1pbnREaXN0cmlidXRpb24Saw'
    'ocdHJhbnNhY3Rpb25fZmVlX2Rpc3RyaWJ1dGlvbhgHIAEoCzIpLmNvbmNvcmRpdW0udjIuVHJh'
    'bnNhY3Rpb25GZWVEaXN0cmlidXRpb25SGnRyYW5zYWN0aW9uRmVlRGlzdHJpYnV0aW9uEjoKC2'
    'dhc19yZXdhcmRzGAggASgLMhkuY29uY29yZGl1bS52Mi5HYXNSZXdhcmRzUgpnYXNSZXdhcmRz'
    'EkwKEmZvdW5kYXRpb25fYWNjb3VudBgJIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZH'
    'Jlc3NSEWZvdW5kYXRpb25BY2NvdW50ElYKHG1pbmltdW1fdGhyZXNob2xkX2Zvcl9iYWtpbmcY'
    'CiABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIZbWluaW11bVRocmVzaG9sZEZvckJha2luZx'
    'I7Cglyb290X2tleXMYCyABKAsyHi5jb25jb3JkaXVtLnYyLkhpZ2hlckxldmVsS2V5c1IIcm9v'
    'dEtleXMSPwoLbGV2ZWwxX2tleXMYDCABKAsyHi5jb25jb3JkaXVtLnYyLkhpZ2hlckxldmVsS2'
    'V5c1IKbGV2ZWwxS2V5cxJACgtsZXZlbDJfa2V5cxgNIAEoCzIfLmNvbmNvcmRpdW0udjIuQXV0'
    'aG9yaXphdGlvbnNWMFIKbGV2ZWwyS2V5cw==');

@$core.Deprecated('Use chainParametersV1Descriptor instead')
const ChainParametersV1$json = {
  '1': 'ChainParametersV1',
  '2': [
    {'1': 'election_difficulty', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ElectionDifficulty', '10': 'electionDifficulty'},
    {'1': 'euro_per_energy', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '10': 'euroPerEnergy'},
    {'1': 'micro_ccd_per_euro', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '10': 'microCcdPerEuro'},
    {'1': 'cooldown_parameters', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.CooldownParametersCpv1', '10': 'cooldownParameters'},
    {'1': 'time_parameters', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.TimeParametersCpv1', '10': 'timeParameters'},
    {'1': 'account_creation_limit', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.CredentialsPerBlockLimit', '10': 'accountCreationLimit'},
    {'1': 'mint_distribution', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.MintDistributionCpv1', '10': 'mintDistribution'},
    {'1': 'transaction_fee_distribution', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.TransactionFeeDistribution', '10': 'transactionFeeDistribution'},
    {'1': 'gas_rewards', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.GasRewards', '10': 'gasRewards'},
    {'1': 'foundation_account', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'foundationAccount'},
    {'1': 'pool_parameters', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.PoolParametersCpv1', '10': 'poolParameters'},
    {'1': 'root_keys', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '10': 'rootKeys'},
    {'1': 'level1_keys', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '10': 'level1Keys'},
    {'1': 'level2_keys', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV1', '10': 'level2Keys'},
  ],
};

/// Descriptor for `ChainParametersV1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chainParametersV1Descriptor = $convert.base64Decode(
    'ChFDaGFpblBhcmFtZXRlcnNWMRJSChNlbGVjdGlvbl9kaWZmaWN1bHR5GAEgASgLMiEuY29uY2'
    '9yZGl1bS52Mi5FbGVjdGlvbkRpZmZpY3VsdHlSEmVsZWN0aW9uRGlmZmljdWx0eRJDCg9ldXJv'
    'X3Blcl9lbmVyZ3kYAiABKAsyGy5jb25jb3JkaXVtLnYyLkV4Y2hhbmdlUmF0ZVINZXVyb1Blck'
    'VuZXJneRJIChJtaWNyb19jY2RfcGVyX2V1cm8YAyABKAsyGy5jb25jb3JkaXVtLnYyLkV4Y2hh'
    'bmdlUmF0ZVIPbWljcm9DY2RQZXJFdXJvElYKE2Nvb2xkb3duX3BhcmFtZXRlcnMYBCABKAsyJS'
    '5jb25jb3JkaXVtLnYyLkNvb2xkb3duUGFyYW1ldGVyc0NwdjFSEmNvb2xkb3duUGFyYW1ldGVy'
    'cxJKCg90aW1lX3BhcmFtZXRlcnMYBSABKAsyIS5jb25jb3JkaXVtLnYyLlRpbWVQYXJhbWV0ZX'
    'JzQ3B2MVIOdGltZVBhcmFtZXRlcnMSXQoWYWNjb3VudF9jcmVhdGlvbl9saW1pdBgGIAEoCzIn'
    'LmNvbmNvcmRpdW0udjIuQ3JlZGVudGlhbHNQZXJCbG9ja0xpbWl0UhRhY2NvdW50Q3JlYXRpb2'
    '5MaW1pdBJQChFtaW50X2Rpc3RyaWJ1dGlvbhgHIAEoCzIjLmNvbmNvcmRpdW0udjIuTWludERp'
    'c3RyaWJ1dGlvbkNwdjFSEG1pbnREaXN0cmlidXRpb24SawocdHJhbnNhY3Rpb25fZmVlX2Rpc3'
    'RyaWJ1dGlvbhgIIAEoCzIpLmNvbmNvcmRpdW0udjIuVHJhbnNhY3Rpb25GZWVEaXN0cmlidXRp'
    'b25SGnRyYW5zYWN0aW9uRmVlRGlzdHJpYnV0aW9uEjoKC2dhc19yZXdhcmRzGAkgASgLMhkuY2'
    '9uY29yZGl1bS52Mi5HYXNSZXdhcmRzUgpnYXNSZXdhcmRzEkwKEmZvdW5kYXRpb25fYWNjb3Vu'
    'dBgKIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NSEWZvdW5kYXRpb25BY2NvdW'
    '50EkoKD3Bvb2xfcGFyYW1ldGVycxgLIAEoCzIhLmNvbmNvcmRpdW0udjIuUG9vbFBhcmFtZXRl'
    'cnNDcHYxUg5wb29sUGFyYW1ldGVycxI7Cglyb290X2tleXMYDCABKAsyHi5jb25jb3JkaXVtLn'
    'YyLkhpZ2hlckxldmVsS2V5c1IIcm9vdEtleXMSPwoLbGV2ZWwxX2tleXMYDSABKAsyHi5jb25j'
    'b3JkaXVtLnYyLkhpZ2hlckxldmVsS2V5c1IKbGV2ZWwxS2V5cxJACgtsZXZlbDJfa2V5cxgOIA'
    'EoCzIfLmNvbmNvcmRpdW0udjIuQXV0aG9yaXphdGlvbnNWMVIKbGV2ZWwyS2V5cw==');

@$core.Deprecated('Use chainParametersV2Descriptor instead')
const ChainParametersV2$json = {
  '1': 'ChainParametersV2',
  '2': [
    {'1': 'consensus_parameters', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ConsensusParametersV1', '10': 'consensusParameters'},
    {'1': 'euro_per_energy', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '10': 'euroPerEnergy'},
    {'1': 'micro_ccd_per_euro', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ExchangeRate', '10': 'microCcdPerEuro'},
    {'1': 'cooldown_parameters', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.CooldownParametersCpv1', '10': 'cooldownParameters'},
    {'1': 'time_parameters', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.TimeParametersCpv1', '10': 'timeParameters'},
    {'1': 'account_creation_limit', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.CredentialsPerBlockLimit', '10': 'accountCreationLimit'},
    {'1': 'mint_distribution', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.MintDistributionCpv1', '10': 'mintDistribution'},
    {'1': 'transaction_fee_distribution', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.TransactionFeeDistribution', '10': 'transactionFeeDistribution'},
    {'1': 'gas_rewards', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.GasRewardsCpv2', '10': 'gasRewards'},
    {'1': 'foundation_account', '3': 10, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'foundationAccount'},
    {'1': 'pool_parameters', '3': 11, '4': 1, '5': 11, '6': '.concordium.v2.PoolParametersCpv1', '10': 'poolParameters'},
    {'1': 'root_keys', '3': 12, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '10': 'rootKeys'},
    {'1': 'level1_keys', '3': 13, '4': 1, '5': 11, '6': '.concordium.v2.HigherLevelKeys', '10': 'level1Keys'},
    {'1': 'level2_keys', '3': 14, '4': 1, '5': 11, '6': '.concordium.v2.AuthorizationsV1', '10': 'level2Keys'},
    {'1': 'finalization_committee_parameters', '3': 15, '4': 1, '5': 11, '6': '.concordium.v2.FinalizationCommitteeParameters', '10': 'finalizationCommitteeParameters'},
  ],
};

/// Descriptor for `ChainParametersV2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chainParametersV2Descriptor = $convert.base64Decode(
    'ChFDaGFpblBhcmFtZXRlcnNWMhJXChRjb25zZW5zdXNfcGFyYW1ldGVycxgBIAEoCzIkLmNvbm'
    'NvcmRpdW0udjIuQ29uc2Vuc3VzUGFyYW1ldGVyc1YxUhNjb25zZW5zdXNQYXJhbWV0ZXJzEkMK'
    'D2V1cm9fcGVyX2VuZXJneRgCIAEoCzIbLmNvbmNvcmRpdW0udjIuRXhjaGFuZ2VSYXRlUg1ldX'
    'JvUGVyRW5lcmd5EkgKEm1pY3JvX2NjZF9wZXJfZXVybxgDIAEoCzIbLmNvbmNvcmRpdW0udjIu'
    'RXhjaGFuZ2VSYXRlUg9taWNyb0NjZFBlckV1cm8SVgoTY29vbGRvd25fcGFyYW1ldGVycxgEIA'
    'EoCzIlLmNvbmNvcmRpdW0udjIuQ29vbGRvd25QYXJhbWV0ZXJzQ3B2MVISY29vbGRvd25QYXJh'
    'bWV0ZXJzEkoKD3RpbWVfcGFyYW1ldGVycxgFIAEoCzIhLmNvbmNvcmRpdW0udjIuVGltZVBhcm'
    'FtZXRlcnNDcHYxUg50aW1lUGFyYW1ldGVycxJdChZhY2NvdW50X2NyZWF0aW9uX2xpbWl0GAYg'
    'ASgLMicuY29uY29yZGl1bS52Mi5DcmVkZW50aWFsc1BlckJsb2NrTGltaXRSFGFjY291bnRDcm'
    'VhdGlvbkxpbWl0ElAKEW1pbnRfZGlzdHJpYnV0aW9uGAcgASgLMiMuY29uY29yZGl1bS52Mi5N'
    'aW50RGlzdHJpYnV0aW9uQ3B2MVIQbWludERpc3RyaWJ1dGlvbhJrChx0cmFuc2FjdGlvbl9mZW'
    'VfZGlzdHJpYnV0aW9uGAggASgLMikuY29uY29yZGl1bS52Mi5UcmFuc2FjdGlvbkZlZURpc3Ry'
    'aWJ1dGlvblIadHJhbnNhY3Rpb25GZWVEaXN0cmlidXRpb24SPgoLZ2FzX3Jld2FyZHMYCSABKA'
    'syHS5jb25jb3JkaXVtLnYyLkdhc1Jld2FyZHNDcHYyUgpnYXNSZXdhcmRzEkwKEmZvdW5kYXRp'
    'b25fYWNjb3VudBgKIAEoCzIdLmNvbmNvcmRpdW0udjIuQWNjb3VudEFkZHJlc3NSEWZvdW5kYX'
    'Rpb25BY2NvdW50EkoKD3Bvb2xfcGFyYW1ldGVycxgLIAEoCzIhLmNvbmNvcmRpdW0udjIuUG9v'
    'bFBhcmFtZXRlcnNDcHYxUg5wb29sUGFyYW1ldGVycxI7Cglyb290X2tleXMYDCABKAsyHi5jb2'
    '5jb3JkaXVtLnYyLkhpZ2hlckxldmVsS2V5c1IIcm9vdEtleXMSPwoLbGV2ZWwxX2tleXMYDSAB'
    'KAsyHi5jb25jb3JkaXVtLnYyLkhpZ2hlckxldmVsS2V5c1IKbGV2ZWwxS2V5cxJACgtsZXZlbD'
    'Jfa2V5cxgOIAEoCzIfLmNvbmNvcmRpdW0udjIuQXV0aG9yaXphdGlvbnNWMVIKbGV2ZWwyS2V5'
    'cxJ6CiFmaW5hbGl6YXRpb25fY29tbWl0dGVlX3BhcmFtZXRlcnMYDyABKAsyLi5jb25jb3JkaX'
    'VtLnYyLkZpbmFsaXphdGlvbkNvbW1pdHRlZVBhcmFtZXRlcnNSH2ZpbmFsaXphdGlvbkNvbW1p'
    'dHRlZVBhcmFtZXRlcnM=');

@$core.Deprecated('Use chainParametersDescriptor instead')
const ChainParameters$json = {
  '1': 'ChainParameters',
  '2': [
    {'1': 'v0', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.ChainParametersV0', '9': 0, '10': 'v0'},
    {'1': 'v1', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ChainParametersV1', '9': 0, '10': 'v1'},
    {'1': 'v2', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.ChainParametersV2', '9': 0, '10': 'v2'},
  ],
  '8': [
    {'1': 'parameters'},
  ],
};

/// Descriptor for `ChainParameters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chainParametersDescriptor = $convert.base64Decode(
    'Cg9DaGFpblBhcmFtZXRlcnMSMgoCdjAYASABKAsyIC5jb25jb3JkaXVtLnYyLkNoYWluUGFyYW'
    '1ldGVyc1YwSABSAnYwEjIKAnYxGAIgASgLMiAuY29uY29yZGl1bS52Mi5DaGFpblBhcmFtZXRl'
    'cnNWMUgAUgJ2MRIyCgJ2MhgDIAEoCzIgLmNvbmNvcmRpdW0udjIuQ2hhaW5QYXJhbWV0ZXJzVj'
    'JIAFICdjJCDAoKcGFyYW1ldGVycw==');

@$core.Deprecated('Use finalizationSummaryPartyDescriptor instead')
const FinalizationSummaryParty$json = {
  '1': 'FinalizationSummaryParty',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'baker'},
    {'1': 'weight', '3': 2, '4': 1, '5': 4, '10': 'weight'},
    {'1': 'signed', '3': 3, '4': 1, '5': 8, '10': 'signed'},
  ],
};

/// Descriptor for `FinalizationSummaryParty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizationSummaryPartyDescriptor = $convert.base64Decode(
    'ChhGaW5hbGl6YXRpb25TdW1tYXJ5UGFydHkSLAoFYmFrZXIYASABKAsyFi5jb25jb3JkaXVtLn'
    'YyLkJha2VySWRSBWJha2VyEhYKBndlaWdodBgCIAEoBFIGd2VpZ2h0EhYKBnNpZ25lZBgDIAEo'
    'CFIGc2lnbmVk');

@$core.Deprecated('Use finalizationIndexDescriptor instead')
const FinalizationIndex$json = {
  '1': 'FinalizationIndex',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 4, '10': 'value'},
  ],
};

/// Descriptor for `FinalizationIndex`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizationIndexDescriptor = $convert.base64Decode(
    'ChFGaW5hbGl6YXRpb25JbmRleBIUCgV2YWx1ZRgBIAEoBFIFdmFsdWU=');

@$core.Deprecated('Use finalizationSummaryDescriptor instead')
const FinalizationSummary$json = {
  '1': 'FinalizationSummary',
  '2': [
    {'1': 'block', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'block'},
    {'1': 'index', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.FinalizationIndex', '10': 'index'},
    {'1': 'delay', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.BlockHeight', '10': 'delay'},
    {'1': 'finalizers', '3': 4, '4': 3, '5': 11, '6': '.concordium.v2.FinalizationSummaryParty', '10': 'finalizers'},
  ],
};

/// Descriptor for `FinalizationSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizationSummaryDescriptor = $convert.base64Decode(
    'ChNGaW5hbGl6YXRpb25TdW1tYXJ5Ei4KBWJsb2NrGAEgASgLMhguY29uY29yZGl1bS52Mi5CbG'
    '9ja0hhc2hSBWJsb2NrEjYKBWluZGV4GAIgASgLMiAuY29uY29yZGl1bS52Mi5GaW5hbGl6YXRp'
    'b25JbmRleFIFaW5kZXgSMAoFZGVsYXkYAyABKAsyGi5jb25jb3JkaXVtLnYyLkJsb2NrSGVpZ2'
    'h0UgVkZWxheRJHCgpmaW5hbGl6ZXJzGAQgAygLMicuY29uY29yZGl1bS52Mi5GaW5hbGl6YXRp'
    'b25TdW1tYXJ5UGFydHlSCmZpbmFsaXplcnM=');

@$core.Deprecated('Use blockFinalizationSummaryDescriptor instead')
const BlockFinalizationSummary$json = {
  '1': 'BlockFinalizationSummary',
  '2': [
    {'1': 'none', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Empty', '9': 0, '10': 'none'},
    {'1': 'record', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.FinalizationSummary', '9': 0, '10': 'record'},
  ],
  '8': [
    {'1': 'summary'},
  ],
};

/// Descriptor for `BlockFinalizationSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockFinalizationSummaryDescriptor = $convert.base64Decode(
    'ChhCbG9ja0ZpbmFsaXphdGlvblN1bW1hcnkSKgoEbm9uZRgBIAEoCzIULmNvbmNvcmRpdW0udj'
    'IuRW1wdHlIAFIEbm9uZRI8CgZyZWNvcmQYAiABKAsyIi5jb25jb3JkaXVtLnYyLkZpbmFsaXph'
    'dGlvblN1bW1hcnlIAFIGcmVjb3JkQgkKB3N1bW1hcnk=');

@$core.Deprecated('Use blockItemDescriptor instead')
const BlockItem$json = {
  '1': 'BlockItem',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.TransactionHash', '10': 'hash'},
    {'1': 'account_transaction', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransaction', '9': 0, '10': 'accountTransaction'},
    {'1': 'credential_deployment', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.CredentialDeployment', '9': 0, '10': 'credentialDeployment'},
    {'1': 'update_instruction', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.UpdateInstruction', '9': 0, '10': 'updateInstruction'},
  ],
  '8': [
    {'1': 'block_item'},
  ],
};

/// Descriptor for `BlockItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockItemDescriptor = $convert.base64Decode(
    'CglCbG9ja0l0ZW0SMgoEaGFzaBgBIAEoCzIeLmNvbmNvcmRpdW0udjIuVHJhbnNhY3Rpb25IYX'
    'NoUgRoYXNoElQKE2FjY291bnRfdHJhbnNhY3Rpb24YAiABKAsyIS5jb25jb3JkaXVtLnYyLkFj'
    'Y291bnRUcmFuc2FjdGlvbkgAUhJhY2NvdW50VHJhbnNhY3Rpb24SWgoVY3JlZGVudGlhbF9kZX'
    'Bsb3ltZW50GAMgASgLMiMuY29uY29yZGl1bS52Mi5DcmVkZW50aWFsRGVwbG95bWVudEgAUhRj'
    'cmVkZW50aWFsRGVwbG95bWVudBJRChJ1cGRhdGVfaW5zdHJ1Y3Rpb24YBCABKAsyIC5jb25jb3'
    'JkaXVtLnYyLlVwZGF0ZUluc3RydWN0aW9uSABSEXVwZGF0ZUluc3RydWN0aW9uQgwKCmJsb2Nr'
    'X2l0ZW0=');

@$core.Deprecated('Use bakerRewardPeriodInfoDescriptor instead')
const BakerRewardPeriodInfo$json = {
  '1': 'BakerRewardPeriodInfo',
  '2': [
    {'1': 'baker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BakerInfo', '10': 'baker'},
    {'1': 'effective_stake', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'effectiveStake'},
    {'1': 'commission_rates', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.CommissionRates', '10': 'commissionRates'},
    {'1': 'equity_capital', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'equityCapital'},
    {'1': 'delegated_capital', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'delegatedCapital'},
    {'1': 'is_finalizer', '3': 6, '4': 1, '5': 8, '10': 'isFinalizer'},
  ],
};

/// Descriptor for `BakerRewardPeriodInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakerRewardPeriodInfoDescriptor = $convert.base64Decode(
    'ChVCYWtlclJld2FyZFBlcmlvZEluZm8SLgoFYmFrZXIYASABKAsyGC5jb25jb3JkaXVtLnYyLk'
    'Jha2VySW5mb1IFYmFrZXISPgoPZWZmZWN0aXZlX3N0YWtlGAIgASgLMhUuY29uY29yZGl1bS52'
    'Mi5BbW91bnRSDmVmZmVjdGl2ZVN0YWtlEkkKEGNvbW1pc3Npb25fcmF0ZXMYAyABKAsyHi5jb2'
    '5jb3JkaXVtLnYyLkNvbW1pc3Npb25SYXRlc1IPY29tbWlzc2lvblJhdGVzEjwKDmVxdWl0eV9j'
    'YXBpdGFsGAQgASgLMhUuY29uY29yZGl1bS52Mi5BbW91bnRSDWVxdWl0eUNhcGl0YWwSQgoRZG'
    'VsZWdhdGVkX2NhcGl0YWwYBSABKAsyFS5jb25jb3JkaXVtLnYyLkFtb3VudFIQZGVsZWdhdGVk'
    'Q2FwaXRhbBIhCgxpc19maW5hbGl6ZXIYBiABKAhSC2lzRmluYWxpemVy');

@$core.Deprecated('Use quorumSignatureDescriptor instead')
const QuorumSignature$json = {
  '1': 'QuorumSignature',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `QuorumSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quorumSignatureDescriptor = $convert.base64Decode(
    'Cg9RdW9ydW1TaWduYXR1cmUSFAoFdmFsdWUYASABKAxSBXZhbHVl');

@$core.Deprecated('Use quorumCertificateDescriptor instead')
const QuorumCertificate$json = {
  '1': 'QuorumCertificate',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'blockHash'},
    {'1': 'round', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Round', '10': 'round'},
    {'1': 'epoch', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Epoch', '10': 'epoch'},
    {'1': 'aggregate_signature', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.QuorumSignature', '10': 'aggregateSignature'},
    {'1': 'signatories', '3': 5, '4': 3, '5': 11, '6': '.concordium.v2.BakerId', '10': 'signatories'},
  ],
};

/// Descriptor for `QuorumCertificate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List quorumCertificateDescriptor = $convert.base64Decode(
    'ChFRdW9ydW1DZXJ0aWZpY2F0ZRI3CgpibG9ja19oYXNoGAEgASgLMhguY29uY29yZGl1bS52Mi'
    '5CbG9ja0hhc2hSCWJsb2NrSGFzaBIqCgVyb3VuZBgCIAEoCzIULmNvbmNvcmRpdW0udjIuUm91'
    'bmRSBXJvdW5kEioKBWVwb2NoGAMgASgLMhQuY29uY29yZGl1bS52Mi5FcG9jaFIFZXBvY2gSTw'
    'oTYWdncmVnYXRlX3NpZ25hdHVyZRgEIAEoCzIeLmNvbmNvcmRpdW0udjIuUXVvcnVtU2lnbmF0'
    'dXJlUhJhZ2dyZWdhdGVTaWduYXR1cmUSOAoLc2lnbmF0b3JpZXMYBSADKAsyFi5jb25jb3JkaX'
    'VtLnYyLkJha2VySWRSC3NpZ25hdG9yaWVz');

@$core.Deprecated('Use finalizerRoundDescriptor instead')
const FinalizerRound$json = {
  '1': 'FinalizerRound',
  '2': [
    {'1': 'round', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Round', '10': 'round'},
    {'1': 'finalizers', '3': 2, '4': 3, '5': 11, '6': '.concordium.v2.BakerId', '10': 'finalizers'},
  ],
};

/// Descriptor for `FinalizerRound`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalizerRoundDescriptor = $convert.base64Decode(
    'Cg5GaW5hbGl6ZXJSb3VuZBIqCgVyb3VuZBgBIAEoCzIULmNvbmNvcmRpdW0udjIuUm91bmRSBX'
    'JvdW5kEjYKCmZpbmFsaXplcnMYAiADKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRSCmZpbmFs'
    'aXplcnM=');

@$core.Deprecated('Use timeoutSignatureDescriptor instead')
const TimeoutSignature$json = {
  '1': 'TimeoutSignature',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `TimeoutSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeoutSignatureDescriptor = $convert.base64Decode(
    'ChBUaW1lb3V0U2lnbmF0dXJlEhQKBXZhbHVlGAEgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use timeoutCertificateDescriptor instead')
const TimeoutCertificate$json = {
  '1': 'TimeoutCertificate',
  '2': [
    {'1': 'round', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Round', '10': 'round'},
    {'1': 'min_epoch', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Epoch', '10': 'minEpoch'},
    {'1': 'qc_rounds_first_epoch', '3': 3, '4': 3, '5': 11, '6': '.concordium.v2.FinalizerRound', '10': 'qcRoundsFirstEpoch'},
    {'1': 'qc_rounds_second_epoch', '3': 4, '4': 3, '5': 11, '6': '.concordium.v2.FinalizerRound', '10': 'qcRoundsSecondEpoch'},
    {'1': 'aggregate_signature', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.TimeoutSignature', '10': 'aggregateSignature'},
  ],
};

/// Descriptor for `TimeoutCertificate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeoutCertificateDescriptor = $convert.base64Decode(
    'ChJUaW1lb3V0Q2VydGlmaWNhdGUSKgoFcm91bmQYASABKAsyFC5jb25jb3JkaXVtLnYyLlJvdW'
    '5kUgVyb3VuZBIxCgltaW5fZXBvY2gYAiABKAsyFC5jb25jb3JkaXVtLnYyLkVwb2NoUghtaW5F'
    'cG9jaBJQChVxY19yb3VuZHNfZmlyc3RfZXBvY2gYAyADKAsyHS5jb25jb3JkaXVtLnYyLkZpbm'
    'FsaXplclJvdW5kUhJxY1JvdW5kc0ZpcnN0RXBvY2gSUgoWcWNfcm91bmRzX3NlY29uZF9lcG9j'
    'aBgEIAMoCzIdLmNvbmNvcmRpdW0udjIuRmluYWxpemVyUm91bmRSE3FjUm91bmRzU2Vjb25kRX'
    'BvY2gSUAoTYWdncmVnYXRlX3NpZ25hdHVyZRgFIAEoCzIfLmNvbmNvcmRpdW0udjIuVGltZW91'
    'dFNpZ25hdHVyZVISYWdncmVnYXRlU2lnbmF0dXJl');

@$core.Deprecated('Use successorProofDescriptor instead')
const SuccessorProof$json = {
  '1': 'SuccessorProof',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `SuccessorProof`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List successorProofDescriptor = $convert.base64Decode(
    'Cg5TdWNjZXNzb3JQcm9vZhIUCgV2YWx1ZRgBIAEoDFIFdmFsdWU=');

@$core.Deprecated('Use epochFinalizationEntryDescriptor instead')
const EpochFinalizationEntry$json = {
  '1': 'EpochFinalizationEntry',
  '2': [
    {'1': 'finalized_qc', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.QuorumCertificate', '10': 'finalizedQc'},
    {'1': 'successor_qc', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.QuorumCertificate', '10': 'successorQc'},
    {'1': 'successor_proof', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.SuccessorProof', '10': 'successorProof'},
  ],
};

/// Descriptor for `EpochFinalizationEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List epochFinalizationEntryDescriptor = $convert.base64Decode(
    'ChZFcG9jaEZpbmFsaXphdGlvbkVudHJ5EkMKDGZpbmFsaXplZF9xYxgBIAEoCzIgLmNvbmNvcm'
    'RpdW0udjIuUXVvcnVtQ2VydGlmaWNhdGVSC2ZpbmFsaXplZFFjEkMKDHN1Y2Nlc3Nvcl9xYxgC'
    'IAEoCzIgLmNvbmNvcmRpdW0udjIuUXVvcnVtQ2VydGlmaWNhdGVSC3N1Y2Nlc3NvclFjEkYKD3'
    'N1Y2Nlc3Nvcl9wcm9vZhgDIAEoCzIdLmNvbmNvcmRpdW0udjIuU3VjY2Vzc29yUHJvb2ZSDnN1'
    'Y2Nlc3NvclByb29m');

@$core.Deprecated('Use blockCertificatesDescriptor instead')
const BlockCertificates$json = {
  '1': 'BlockCertificates',
  '2': [
    {'1': 'quorum_certificate', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.QuorumCertificate', '9': 0, '10': 'quorumCertificate', '17': true},
    {'1': 'timeout_certificate', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.TimeoutCertificate', '9': 1, '10': 'timeoutCertificate', '17': true},
    {'1': 'epoch_finalization_entry', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.EpochFinalizationEntry', '9': 2, '10': 'epochFinalizationEntry', '17': true},
  ],
  '8': [
    {'1': '_quorum_certificate'},
    {'1': '_timeout_certificate'},
    {'1': '_epoch_finalization_entry'},
  ],
};

/// Descriptor for `BlockCertificates`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockCertificatesDescriptor = $convert.base64Decode(
    'ChFCbG9ja0NlcnRpZmljYXRlcxJUChJxdW9ydW1fY2VydGlmaWNhdGUYASABKAsyIC5jb25jb3'
    'JkaXVtLnYyLlF1b3J1bUNlcnRpZmljYXRlSABSEXF1b3J1bUNlcnRpZmljYXRliAEBElcKE3Rp'
    'bWVvdXRfY2VydGlmaWNhdGUYAiABKAsyIS5jb25jb3JkaXVtLnYyLlRpbWVvdXRDZXJ0aWZpY2'
    'F0ZUgBUhJ0aW1lb3V0Q2VydGlmaWNhdGWIAQESZAoYZXBvY2hfZmluYWxpemF0aW9uX2VudHJ5'
    'GAMgASgLMiUuY29uY29yZGl1bS52Mi5FcG9jaEZpbmFsaXphdGlvbkVudHJ5SAJSFmVwb2NoRm'
    'luYWxpemF0aW9uRW50cnmIAQFCFQoTX3F1b3J1bV9jZXJ0aWZpY2F0ZUIWChRfdGltZW91dF9j'
    'ZXJ0aWZpY2F0ZUIbChlfZXBvY2hfZmluYWxpemF0aW9uX2VudHJ5');

@$core.Deprecated('Use winningBakerDescriptor instead')
const WinningBaker$json = {
  '1': 'WinningBaker',
  '2': [
    {'1': 'round', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Round', '10': 'round'},
    {'1': 'winner', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BakerId', '10': 'winner'},
    {'1': 'present', '3': 3, '4': 1, '5': 8, '10': 'present'},
  ],
};

/// Descriptor for `WinningBaker`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List winningBakerDescriptor = $convert.base64Decode(
    'CgxXaW5uaW5nQmFrZXISKgoFcm91bmQYASABKAsyFC5jb25jb3JkaXVtLnYyLlJvdW5kUgVyb3'
    'VuZBIuCgZ3aW5uZXIYAiABKAsyFi5jb25jb3JkaXVtLnYyLkJha2VySWRSBndpbm5lchIYCgdw'
    'cmVzZW50GAMgASgIUgdwcmVzZW50');

@$core.Deprecated('Use dryRunRequestDescriptor instead')
const DryRunRequest$json = {
  '1': 'DryRunRequest',
  '2': [
    {'1': 'load_block_state', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.BlockHashInput', '9': 0, '10': 'loadBlockState'},
    {'1': 'state_query', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.DryRunStateQuery', '9': 0, '10': 'stateQuery'},
    {'1': 'state_operation', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.DryRunStateOperation', '9': 0, '10': 'stateOperation'},
  ],
  '8': [
    {'1': 'request'},
  ],
};

/// Descriptor for `DryRunRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunRequestDescriptor = $convert.base64Decode(
    'Cg1EcnlSdW5SZXF1ZXN0EkkKEGxvYWRfYmxvY2tfc3RhdGUYASABKAsyHS5jb25jb3JkaXVtLn'
    'YyLkJsb2NrSGFzaElucHV0SABSDmxvYWRCbG9ja1N0YXRlEkIKC3N0YXRlX3F1ZXJ5GAIgASgL'
    'Mh8uY29uY29yZGl1bS52Mi5EcnlSdW5TdGF0ZVF1ZXJ5SABSCnN0YXRlUXVlcnkSTgoPc3RhdG'
    'Vfb3BlcmF0aW9uGAMgASgLMiMuY29uY29yZGl1bS52Mi5EcnlSdW5TdGF0ZU9wZXJhdGlvbkgA'
    'Ug5zdGF0ZU9wZXJhdGlvbkIJCgdyZXF1ZXN0');

@$core.Deprecated('Use dryRunStateQueryDescriptor instead')
const DryRunStateQuery$json = {
  '1': 'DryRunStateQuery',
  '2': [
    {'1': 'get_account_info', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountIdentifierInput', '9': 0, '10': 'getAccountInfo'},
    {'1': 'get_instance_info', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '9': 0, '10': 'getInstanceInfo'},
    {'1': 'invoke_instance', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.DryRunInvokeInstance', '9': 0, '10': 'invokeInstance'},
  ],
  '8': [
    {'1': 'query'},
  ],
};

/// Descriptor for `DryRunStateQuery`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunStateQueryDescriptor = $convert.base64Decode(
    'ChBEcnlSdW5TdGF0ZVF1ZXJ5ElEKEGdldF9hY2NvdW50X2luZm8YASABKAsyJS5jb25jb3JkaX'
    'VtLnYyLkFjY291bnRJZGVudGlmaWVySW5wdXRIAFIOZ2V0QWNjb3VudEluZm8STAoRZ2V0X2lu'
    'c3RhbmNlX2luZm8YAiABKAsyHi5jb25jb3JkaXVtLnYyLkNvbnRyYWN0QWRkcmVzc0gAUg9nZX'
    'RJbnN0YW5jZUluZm8STgoPaW52b2tlX2luc3RhbmNlGAMgASgLMiMuY29uY29yZGl1bS52Mi5E'
    'cnlSdW5JbnZva2VJbnN0YW5jZUgAUg5pbnZva2VJbnN0YW5jZUIHCgVxdWVyeQ==');

@$core.Deprecated('Use dryRunInvokeInstanceDescriptor instead')
const DryRunInvokeInstance$json = {
  '1': 'DryRunInvokeInstance',
  '2': [
    {'1': 'invoker', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Address', '9': 0, '10': 'invoker', '17': true},
    {'1': 'instance', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.ContractAddress', '10': 'instance'},
    {'1': 'amount', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
    {'1': 'entrypoint', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.ReceiveName', '10': 'entrypoint'},
    {'1': 'parameter', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.Parameter', '10': 'parameter'},
    {'1': 'energy', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'energy'},
  ],
  '8': [
    {'1': '_invoker'},
  ],
};

/// Descriptor for `DryRunInvokeInstance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunInvokeInstanceDescriptor = $convert.base64Decode(
    'ChREcnlSdW5JbnZva2VJbnN0YW5jZRI1CgdpbnZva2VyGAEgASgLMhYuY29uY29yZGl1bS52Mi'
    '5BZGRyZXNzSABSB2ludm9rZXKIAQESOgoIaW5zdGFuY2UYAiABKAsyHi5jb25jb3JkaXVtLnYy'
    'LkNvbnRyYWN0QWRkcmVzc1IIaW5zdGFuY2USLQoGYW1vdW50GAMgASgLMhUuY29uY29yZGl1bS'
    '52Mi5BbW91bnRSBmFtb3VudBI6CgplbnRyeXBvaW50GAQgASgLMhouY29uY29yZGl1bS52Mi5S'
    'ZWNlaXZlTmFtZVIKZW50cnlwb2ludBI2CglwYXJhbWV0ZXIYBSABKAsyGC5jb25jb3JkaXVtLn'
    'YyLlBhcmFtZXRlclIJcGFyYW1ldGVyEi0KBmVuZXJneRgGIAEoCzIVLmNvbmNvcmRpdW0udjIu'
    'RW5lcmd5UgZlbmVyZ3lCCgoIX2ludm9rZXI=');

@$core.Deprecated('Use dryRunStateOperationDescriptor instead')
const DryRunStateOperation$json = {
  '1': 'DryRunStateOperation',
  '2': [
    {'1': 'set_timestamp', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '9': 0, '10': 'setTimestamp'},
    {'1': 'mint_to_account', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.DryRunMintToAccount', '9': 0, '10': 'mintToAccount'},
    {'1': 'run_transaction', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.DryRunTransaction', '9': 0, '10': 'runTransaction'},
  ],
  '8': [
    {'1': 'operation'},
  ],
};

/// Descriptor for `DryRunStateOperation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunStateOperationDescriptor = $convert.base64Decode(
    'ChREcnlSdW5TdGF0ZU9wZXJhdGlvbhI/Cg1zZXRfdGltZXN0YW1wGAEgASgLMhguY29uY29yZG'
    'l1bS52Mi5UaW1lc3RhbXBIAFIMc2V0VGltZXN0YW1wEkwKD21pbnRfdG9fYWNjb3VudBgCIAEo'
    'CzIiLmNvbmNvcmRpdW0udjIuRHJ5UnVuTWludFRvQWNjb3VudEgAUg1taW50VG9BY2NvdW50Ek'
    'sKD3J1bl90cmFuc2FjdGlvbhgDIAEoCzIgLmNvbmNvcmRpdW0udjIuRHJ5UnVuVHJhbnNhY3Rp'
    'b25IAFIOcnVuVHJhbnNhY3Rpb25CCwoJb3BlcmF0aW9u');

@$core.Deprecated('Use dryRunMintToAccountDescriptor instead')
const DryRunMintToAccount$json = {
  '1': 'DryRunMintToAccount',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'account'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amount'},
  ],
};

/// Descriptor for `DryRunMintToAccount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunMintToAccountDescriptor = $convert.base64Decode(
    'ChNEcnlSdW5NaW50VG9BY2NvdW50EjcKB2FjY291bnQYASABKAsyHS5jb25jb3JkaXVtLnYyLk'
    'FjY291bnRBZGRyZXNzUgdhY2NvdW50Ei0KBmFtb3VudBgCIAEoCzIVLmNvbmNvcmRpdW0udjIu'
    'QW1vdW50UgZhbW91bnQ=');

@$core.Deprecated('Use dryRunTransactionDescriptor instead')
const DryRunTransaction$json = {
  '1': 'DryRunTransaction',
  '2': [
    {'1': 'sender', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.AccountAddress', '10': 'sender'},
    {'1': 'energy_amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'energyAmount'},
    {'1': 'payload', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionPayload', '10': 'payload'},
    {'1': 'signatures', '3': 4, '4': 3, '5': 11, '6': '.concordium.v2.DryRunSignature', '10': 'signatures'},
  ],
};

/// Descriptor for `DryRunTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunTransactionDescriptor = $convert.base64Decode(
    'ChFEcnlSdW5UcmFuc2FjdGlvbhI1CgZzZW5kZXIYASABKAsyHS5jb25jb3JkaXVtLnYyLkFjY2'
    '91bnRBZGRyZXNzUgZzZW5kZXISOgoNZW5lcmd5X2Ftb3VudBgCIAEoCzIVLmNvbmNvcmRpdW0u'
    'djIuRW5lcmd5UgxlbmVyZ3lBbW91bnQSQgoHcGF5bG9hZBgDIAEoCzIoLmNvbmNvcmRpdW0udj'
    'IuQWNjb3VudFRyYW5zYWN0aW9uUGF5bG9hZFIHcGF5bG9hZBI+CgpzaWduYXR1cmVzGAQgAygL'
    'Mh4uY29uY29yZGl1bS52Mi5EcnlSdW5TaWduYXR1cmVSCnNpZ25hdHVyZXM=');

@$core.Deprecated('Use dryRunSignatureDescriptor instead')
const DryRunSignature$json = {
  '1': 'DryRunSignature',
  '2': [
    {'1': 'credential', '3': 1, '4': 1, '5': 13, '10': 'credential'},
    {'1': 'key', '3': 2, '4': 1, '5': 13, '10': 'key'},
  ],
};

/// Descriptor for `DryRunSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunSignatureDescriptor = $convert.base64Decode(
    'Cg9EcnlSdW5TaWduYXR1cmUSHgoKY3JlZGVudGlhbBgBIAEoDVIKY3JlZGVudGlhbBIQCgNrZX'
    'kYAiABKA1SA2tleQ==');

@$core.Deprecated('Use dryRunResponseDescriptor instead')
const DryRunResponse$json = {
  '1': 'DryRunResponse',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse', '9': 0, '10': 'error'},
    {'1': 'success', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.DryRunSuccessResponse', '9': 0, '10': 'success'},
    {'1': 'quota_remaining', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'quotaRemaining'},
  ],
  '8': [
    {'1': 'response'},
  ],
};

/// Descriptor for `DryRunResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunResponseDescriptor = $convert.base64Decode(
    'Cg5EcnlSdW5SZXNwb25zZRI6CgVlcnJvchgBIAEoCzIiLmNvbmNvcmRpdW0udjIuRHJ5UnVuRX'
    'Jyb3JSZXNwb25zZUgAUgVlcnJvchJACgdzdWNjZXNzGAIgASgLMiQuY29uY29yZGl1bS52Mi5E'
    'cnlSdW5TdWNjZXNzUmVzcG9uc2VIAFIHc3VjY2VzcxI+Cg9xdW90YV9yZW1haW5pbmcYAyABKA'
    'syFS5jb25jb3JkaXVtLnYyLkVuZXJneVIOcXVvdGFSZW1haW5pbmdCCgoIcmVzcG9uc2U=');

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse$json = {
  '1': 'DryRunErrorResponse',
  '2': [
    {'1': 'no_state', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.NoState', '9': 0, '10': 'noState'},
    {'1': 'block_not_found', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.BlockNotFound', '9': 0, '10': 'blockNotFound'},
    {'1': 'account_not_found', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.AccountNotFound', '9': 0, '10': 'accountNotFound'},
    {'1': 'instance_not_found', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.InstanceNotFound', '9': 0, '10': 'instanceNotFound'},
    {'1': 'amount_over_limit', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.AmountOverLimit', '9': 0, '10': 'amountOverLimit'},
    {'1': 'balance_insufficient', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.BalanceInsufficient', '9': 0, '10': 'balanceInsufficient'},
    {'1': 'energy_insufficient', '3': 8, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.EnergyInsufficient', '9': 0, '10': 'energyInsufficient'},
    {'1': 'invoke_failed', '3': 9, '4': 1, '5': 11, '6': '.concordium.v2.DryRunErrorResponse.InvokeFailure', '9': 0, '10': 'invokeFailed'},
  ],
  '3': [DryRunErrorResponse_NoState$json, DryRunErrorResponse_BlockNotFound$json, DryRunErrorResponse_AccountNotFound$json, DryRunErrorResponse_InstanceNotFound$json, DryRunErrorResponse_AmountOverLimit$json, DryRunErrorResponse_BalanceInsufficient$json, DryRunErrorResponse_EnergyInsufficient$json, DryRunErrorResponse_InvokeFailure$json],
  '8': [
    {'1': 'error'},
  ],
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_NoState$json = {
  '1': 'NoState',
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_BlockNotFound$json = {
  '1': 'BlockNotFound',
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_AccountNotFound$json = {
  '1': 'AccountNotFound',
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_InstanceNotFound$json = {
  '1': 'InstanceNotFound',
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_AmountOverLimit$json = {
  '1': 'AmountOverLimit',
  '2': [
    {'1': 'amount_limit', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'amountLimit'},
  ],
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_BalanceInsufficient$json = {
  '1': 'BalanceInsufficient',
  '2': [
    {'1': 'required_amount', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'requiredAmount'},
    {'1': 'available_amount', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Amount', '10': 'availableAmount'},
  ],
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_EnergyInsufficient$json = {
  '1': 'EnergyInsufficient',
  '2': [
    {'1': 'energy_required', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'energyRequired'},
  ],
};

@$core.Deprecated('Use dryRunErrorResponseDescriptor instead')
const DryRunErrorResponse_InvokeFailure$json = {
  '1': 'InvokeFailure',
  '2': [
    {'1': 'return_value', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'returnValue', '17': true},
    {'1': 'used_energy', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'usedEnergy'},
    {'1': 'reason', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.RejectReason', '10': 'reason'},
  ],
  '8': [
    {'1': '_return_value'},
  ],
};

/// Descriptor for `DryRunErrorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunErrorResponseDescriptor = $convert.base64Decode(
    'ChNEcnlSdW5FcnJvclJlc3BvbnNlEkcKCG5vX3N0YXRlGAEgASgLMiouY29uY29yZGl1bS52Mi'
    '5EcnlSdW5FcnJvclJlc3BvbnNlLk5vU3RhdGVIAFIHbm9TdGF0ZRJaCg9ibG9ja19ub3RfZm91'
    'bmQYAiABKAsyMC5jb25jb3JkaXVtLnYyLkRyeVJ1bkVycm9yUmVzcG9uc2UuQmxvY2tOb3RGb3'
    'VuZEgAUg1ibG9ja05vdEZvdW5kEmAKEWFjY291bnRfbm90X2ZvdW5kGAMgASgLMjIuY29uY29y'
    'ZGl1bS52Mi5EcnlSdW5FcnJvclJlc3BvbnNlLkFjY291bnROb3RGb3VuZEgAUg9hY2NvdW50Tm'
    '90Rm91bmQSYwoSaW5zdGFuY2Vfbm90X2ZvdW5kGAQgASgLMjMuY29uY29yZGl1bS52Mi5EcnlS'
    'dW5FcnJvclJlc3BvbnNlLkluc3RhbmNlTm90Rm91bmRIAFIQaW5zdGFuY2VOb3RGb3VuZBJgCh'
    'FhbW91bnRfb3Zlcl9saW1pdBgFIAEoCzIyLmNvbmNvcmRpdW0udjIuRHJ5UnVuRXJyb3JSZXNw'
    'b25zZS5BbW91bnRPdmVyTGltaXRIAFIPYW1vdW50T3ZlckxpbWl0EmsKFGJhbGFuY2VfaW5zdW'
    'ZmaWNpZW50GAYgASgLMjYuY29uY29yZGl1bS52Mi5EcnlSdW5FcnJvclJlc3BvbnNlLkJhbGFu'
    'Y2VJbnN1ZmZpY2llbnRIAFITYmFsYW5jZUluc3VmZmljaWVudBJoChNlbmVyZ3lfaW5zdWZmaW'
    'NpZW50GAggASgLMjUuY29uY29yZGl1bS52Mi5EcnlSdW5FcnJvclJlc3BvbnNlLkVuZXJneUlu'
    'c3VmZmljaWVudEgAUhJlbmVyZ3lJbnN1ZmZpY2llbnQSVwoNaW52b2tlX2ZhaWxlZBgJIAEoCz'
    'IwLmNvbmNvcmRpdW0udjIuRHJ5UnVuRXJyb3JSZXNwb25zZS5JbnZva2VGYWlsdXJlSABSDGlu'
    'dm9rZUZhaWxlZBoJCgdOb1N0YXRlGg8KDUJsb2NrTm90Rm91bmQaEQoPQWNjb3VudE5vdEZvdW'
    '5kGhIKEEluc3RhbmNlTm90Rm91bmQaSwoPQW1vdW50T3ZlckxpbWl0EjgKDGFtb3VudF9saW1p'
    'dBgBIAEoCzIVLmNvbmNvcmRpdW0udjIuQW1vdW50UgthbW91bnRMaW1pdBqXAQoTQmFsYW5jZU'
    'luc3VmZmljaWVudBI+Cg9yZXF1aXJlZF9hbW91bnQYASABKAsyFS5jb25jb3JkaXVtLnYyLkFt'
    'b3VudFIOcmVxdWlyZWRBbW91bnQSQAoQYXZhaWxhYmxlX2Ftb3VudBgCIAEoCzIVLmNvbmNvcm'
    'RpdW0udjIuQW1vdW50Ug9hdmFpbGFibGVBbW91bnQaVAoSRW5lcmd5SW5zdWZmaWNpZW50Ej4K'
    'D2VuZXJneV9yZXF1aXJlZBgBIAEoCzIVLmNvbmNvcmRpdW0udjIuRW5lcmd5Ug5lbmVyZ3lSZX'
    'F1aXJlZBq1AQoNSW52b2tlRmFpbHVyZRImCgxyZXR1cm5fdmFsdWUYASABKAxIAFILcmV0dXJu'
    'VmFsdWWIAQESNgoLdXNlZF9lbmVyZ3kYAiABKAsyFS5jb25jb3JkaXVtLnYyLkVuZXJneVIKdX'
    'NlZEVuZXJneRIzCgZyZWFzb24YAyABKAsyGy5jb25jb3JkaXVtLnYyLlJlamVjdFJlYXNvblIG'
    'cmVhc29uQg8KDV9yZXR1cm5fdmFsdWVCBwoFZXJyb3I=');

@$core.Deprecated('Use dryRunSuccessResponseDescriptor instead')
const DryRunSuccessResponse$json = {
  '1': 'DryRunSuccessResponse',
  '2': [
    {'1': 'block_state_loaded', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.DryRunSuccessResponse.BlockStateLoaded', '9': 0, '10': 'blockStateLoaded'},
    {'1': 'account_info', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountInfo', '9': 0, '10': 'accountInfo'},
    {'1': 'instance_info', '3': 3, '4': 1, '5': 11, '6': '.concordium.v2.InstanceInfo', '9': 0, '10': 'instanceInfo'},
    {'1': 'invoke_succeeded', '3': 4, '4': 1, '5': 11, '6': '.concordium.v2.DryRunSuccessResponse.InvokeSuccess', '9': 0, '10': 'invokeSucceeded'},
    {'1': 'timestamp_set', '3': 5, '4': 1, '5': 11, '6': '.concordium.v2.DryRunSuccessResponse.TimestampSet', '9': 0, '10': 'timestampSet'},
    {'1': 'minted_to_account', '3': 6, '4': 1, '5': 11, '6': '.concordium.v2.DryRunSuccessResponse.MintedToAccount', '9': 0, '10': 'mintedToAccount'},
    {'1': 'transaction_executed', '3': 7, '4': 1, '5': 11, '6': '.concordium.v2.DryRunSuccessResponse.TransactionExecuted', '9': 0, '10': 'transactionExecuted'},
  ],
  '3': [DryRunSuccessResponse_BlockStateLoaded$json, DryRunSuccessResponse_TimestampSet$json, DryRunSuccessResponse_MintedToAccount$json, DryRunSuccessResponse_TransactionExecuted$json, DryRunSuccessResponse_InvokeSuccess$json],
  '8': [
    {'1': 'response'},
  ],
};

@$core.Deprecated('Use dryRunSuccessResponseDescriptor instead')
const DryRunSuccessResponse_BlockStateLoaded$json = {
  '1': 'BlockStateLoaded',
  '2': [
    {'1': 'current_timestamp', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Timestamp', '10': 'currentTimestamp'},
    {'1': 'block_hash', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.BlockHash', '10': 'blockHash'},
    {'1': 'protocol_version', '3': 3, '4': 1, '5': 14, '6': '.concordium.v2.ProtocolVersion', '10': 'protocolVersion'},
  ],
};

@$core.Deprecated('Use dryRunSuccessResponseDescriptor instead')
const DryRunSuccessResponse_TimestampSet$json = {
  '1': 'TimestampSet',
};

@$core.Deprecated('Use dryRunSuccessResponseDescriptor instead')
const DryRunSuccessResponse_MintedToAccount$json = {
  '1': 'MintedToAccount',
};

@$core.Deprecated('Use dryRunSuccessResponseDescriptor instead')
const DryRunSuccessResponse_TransactionExecuted$json = {
  '1': 'TransactionExecuted',
  '2': [
    {'1': 'energy_cost', '3': 1, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'energyCost'},
    {'1': 'details', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.AccountTransactionDetails', '10': 'details'},
    {'1': 'return_value', '3': 3, '4': 1, '5': 12, '9': 0, '10': 'returnValue', '17': true},
  ],
  '8': [
    {'1': '_return_value'},
  ],
};

@$core.Deprecated('Use dryRunSuccessResponseDescriptor instead')
const DryRunSuccessResponse_InvokeSuccess$json = {
  '1': 'InvokeSuccess',
  '2': [
    {'1': 'return_value', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'returnValue', '17': true},
    {'1': 'used_energy', '3': 2, '4': 1, '5': 11, '6': '.concordium.v2.Energy', '10': 'usedEnergy'},
    {'1': 'effects', '3': 3, '4': 3, '5': 11, '6': '.concordium.v2.ContractTraceElement', '10': 'effects'},
  ],
  '8': [
    {'1': '_return_value'},
  ],
};

/// Descriptor for `DryRunSuccessResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dryRunSuccessResponseDescriptor = $convert.base64Decode(
    'ChVEcnlSdW5TdWNjZXNzUmVzcG9uc2USZQoSYmxvY2tfc3RhdGVfbG9hZGVkGAEgASgLMjUuY2'
    '9uY29yZGl1bS52Mi5EcnlSdW5TdWNjZXNzUmVzcG9uc2UuQmxvY2tTdGF0ZUxvYWRlZEgAUhBi'
    'bG9ja1N0YXRlTG9hZGVkEj8KDGFjY291bnRfaW5mbxgCIAEoCzIaLmNvbmNvcmRpdW0udjIuQW'
    'Njb3VudEluZm9IAFILYWNjb3VudEluZm8SQgoNaW5zdGFuY2VfaW5mbxgDIAEoCzIbLmNvbmNv'
    'cmRpdW0udjIuSW5zdGFuY2VJbmZvSABSDGluc3RhbmNlSW5mbxJfChBpbnZva2Vfc3VjY2VlZG'
    'VkGAQgASgLMjIuY29uY29yZGl1bS52Mi5EcnlSdW5TdWNjZXNzUmVzcG9uc2UuSW52b2tlU3Vj'
    'Y2Vzc0gAUg9pbnZva2VTdWNjZWVkZWQSWAoNdGltZXN0YW1wX3NldBgFIAEoCzIxLmNvbmNvcm'
    'RpdW0udjIuRHJ5UnVuU3VjY2Vzc1Jlc3BvbnNlLlRpbWVzdGFtcFNldEgAUgx0aW1lc3RhbXBT'
    'ZXQSYgoRbWludGVkX3RvX2FjY291bnQYBiABKAsyNC5jb25jb3JkaXVtLnYyLkRyeVJ1blN1Y2'
    'Nlc3NSZXNwb25zZS5NaW50ZWRUb0FjY291bnRIAFIPbWludGVkVG9BY2NvdW50Em0KFHRyYW5z'
    'YWN0aW9uX2V4ZWN1dGVkGAcgASgLMjguY29uY29yZGl1bS52Mi5EcnlSdW5TdWNjZXNzUmVzcG'
    '9uc2UuVHJhbnNhY3Rpb25FeGVjdXRlZEgAUhN0cmFuc2FjdGlvbkV4ZWN1dGVkGt0BChBCbG9j'
    'a1N0YXRlTG9hZGVkEkUKEWN1cnJlbnRfdGltZXN0YW1wGAEgASgLMhguY29uY29yZGl1bS52Mi'
    '5UaW1lc3RhbXBSEGN1cnJlbnRUaW1lc3RhbXASNwoKYmxvY2tfaGFzaBgCIAEoCzIYLmNvbmNv'
    'cmRpdW0udjIuQmxvY2tIYXNoUglibG9ja0hhc2gSSQoQcHJvdG9jb2xfdmVyc2lvbhgDIAEoDj'
    'IeLmNvbmNvcmRpdW0udjIuUHJvdG9jb2xWZXJzaW9uUg9wcm90b2NvbFZlcnNpb24aDgoMVGlt'
    'ZXN0YW1wU2V0GhEKD01pbnRlZFRvQWNjb3VudBrKAQoTVHJhbnNhY3Rpb25FeGVjdXRlZBI2Cg'
    'tlbmVyZ3lfY29zdBgBIAEoCzIVLmNvbmNvcmRpdW0udjIuRW5lcmd5UgplbmVyZ3lDb3N0EkIK'
    'B2RldGFpbHMYAiABKAsyKC5jb25jb3JkaXVtLnYyLkFjY291bnRUcmFuc2FjdGlvbkRldGFpbH'
    'NSB2RldGFpbHMSJgoMcmV0dXJuX3ZhbHVlGAMgASgMSABSC3JldHVyblZhbHVliAEBQg8KDV9y'
    'ZXR1cm5fdmFsdWUavwEKDUludm9rZVN1Y2Nlc3MSJgoMcmV0dXJuX3ZhbHVlGAEgASgMSABSC3'
    'JldHVyblZhbHVliAEBEjYKC3VzZWRfZW5lcmd5GAIgASgLMhUuY29uY29yZGl1bS52Mi5FbmVy'
    'Z3lSCnVzZWRFbmVyZ3kSPQoHZWZmZWN0cxgDIAMoCzIjLmNvbmNvcmRpdW0udjIuQ29udHJhY3'
    'RUcmFjZUVsZW1lbnRSB2VmZmVjdHNCDwoNX3JldHVybl92YWx1ZUIKCghyZXNwb25zZQ==');

