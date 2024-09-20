//
//  Generated code. Do not modify.
//  source: lib/flutterchain_lib/network/chains/concordium_grpc/protos/types.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Information about how open the pool is to new delegators.
class OpenStatus extends $pb.ProtobufEnum {
  static const OpenStatus OPEN_STATUS_OPEN_FOR_ALL = OpenStatus._(0, _omitEnumNames ? '' : 'OPEN_STATUS_OPEN_FOR_ALL');
  static const OpenStatus OPEN_STATUS_CLOSED_FOR_NEW = OpenStatus._(1, _omitEnumNames ? '' : 'OPEN_STATUS_CLOSED_FOR_NEW');
  static const OpenStatus OPEN_STATUS_CLOSED_FOR_ALL = OpenStatus._(2, _omitEnumNames ? '' : 'OPEN_STATUS_CLOSED_FOR_ALL');

  static const $core.List<OpenStatus> values = <OpenStatus> [
    OPEN_STATUS_OPEN_FOR_ALL,
    OPEN_STATUS_CLOSED_FOR_NEW,
    OPEN_STATUS_CLOSED_FOR_ALL,
  ];

  static final $core.Map<$core.int, OpenStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OpenStatus? valueOf($core.int value) => _byValue[value];

  const OpenStatus._($core.int v, $core.String n) : super(v, n);
}

/// Version of smart contract.
class ContractVersion extends $pb.ProtobufEnum {
  static const ContractVersion V0 = ContractVersion._(0, _omitEnumNames ? '' : 'V0');
  static const ContractVersion V1 = ContractVersion._(1, _omitEnumNames ? '' : 'V1');

  static const $core.List<ContractVersion> values = <ContractVersion> [
    V0,
    V1,
  ];

  static final $core.Map<$core.int, ContractVersion> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ContractVersion? valueOf($core.int value) => _byValue[value];

  const ContractVersion._($core.int v, $core.String n) : super(v, n);
}

/// The type of a credential.
class CredentialType extends $pb.ProtobufEnum {
  static const CredentialType CREDENTIAL_TYPE_INITIAL = CredentialType._(0, _omitEnumNames ? '' : 'CREDENTIAL_TYPE_INITIAL');
  static const CredentialType CREDENTIAL_TYPE_NORMAL = CredentialType._(1, _omitEnumNames ? '' : 'CREDENTIAL_TYPE_NORMAL');

  static const $core.List<CredentialType> values = <CredentialType> [
    CREDENTIAL_TYPE_INITIAL,
    CREDENTIAL_TYPE_NORMAL,
  ];

  static final $core.Map<$core.int, CredentialType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CredentialType? valueOf($core.int value) => _byValue[value];

  const CredentialType._($core.int v, $core.String n) : super(v, n);
}

/// The type of chain update.
class UpdateType extends $pb.ProtobufEnum {
  static const UpdateType UPDATE_PROTOCOL = UpdateType._(0, _omitEnumNames ? '' : 'UPDATE_PROTOCOL');
  static const UpdateType UPDATE_ELECTION_DIFFICULTY = UpdateType._(1, _omitEnumNames ? '' : 'UPDATE_ELECTION_DIFFICULTY');
  static const UpdateType UPDATE_EURO_PER_ENERGY = UpdateType._(2, _omitEnumNames ? '' : 'UPDATE_EURO_PER_ENERGY');
  static const UpdateType UPDATE_MICRO_CCD_PER_EURO = UpdateType._(3, _omitEnumNames ? '' : 'UPDATE_MICRO_CCD_PER_EURO');
  static const UpdateType UPDATE_FOUNDATION_ACCOUNT = UpdateType._(4, _omitEnumNames ? '' : 'UPDATE_FOUNDATION_ACCOUNT');
  static const UpdateType UPDATE_MINT_DISTRIBUTION = UpdateType._(5, _omitEnumNames ? '' : 'UPDATE_MINT_DISTRIBUTION');
  static const UpdateType UPDATE_TRANSACTION_FEE_DISTRIBUTION = UpdateType._(6, _omitEnumNames ? '' : 'UPDATE_TRANSACTION_FEE_DISTRIBUTION');
  static const UpdateType UPDATE_GAS_REWARDS = UpdateType._(7, _omitEnumNames ? '' : 'UPDATE_GAS_REWARDS');
  static const UpdateType UPDATE_POOL_PARAMETERS = UpdateType._(8, _omitEnumNames ? '' : 'UPDATE_POOL_PARAMETERS');
  static const UpdateType ADD_ANONYMITY_REVOKER = UpdateType._(9, _omitEnumNames ? '' : 'ADD_ANONYMITY_REVOKER');
  static const UpdateType ADD_IDENTITY_PROVIDER = UpdateType._(10, _omitEnumNames ? '' : 'ADD_IDENTITY_PROVIDER');
  static const UpdateType UPDATE_ROOT_KEYS = UpdateType._(11, _omitEnumNames ? '' : 'UPDATE_ROOT_KEYS');
  static const UpdateType UPDATE_LEVEL1_KEYS = UpdateType._(12, _omitEnumNames ? '' : 'UPDATE_LEVEL1_KEYS');
  static const UpdateType UPDATE_LEVEL2_KEYS = UpdateType._(13, _omitEnumNames ? '' : 'UPDATE_LEVEL2_KEYS');
  static const UpdateType UPDATE_COOLDOWN_PARAMETERS = UpdateType._(14, _omitEnumNames ? '' : 'UPDATE_COOLDOWN_PARAMETERS');
  static const UpdateType UPDATE_TIME_PARAMETERS = UpdateType._(15, _omitEnumNames ? '' : 'UPDATE_TIME_PARAMETERS');
  static const UpdateType UPDATE_TIMEOUT_PARAMETERS = UpdateType._(16, _omitEnumNames ? '' : 'UPDATE_TIMEOUT_PARAMETERS');
  static const UpdateType UPDATE_MIN_BLOCK_TIME = UpdateType._(17, _omitEnumNames ? '' : 'UPDATE_MIN_BLOCK_TIME');
  static const UpdateType UPDATE_BLOCK_ENERGY_LIMIT = UpdateType._(18, _omitEnumNames ? '' : 'UPDATE_BLOCK_ENERGY_LIMIT');
  static const UpdateType UPDATE_FINALIZATION_COMMITTEE_PARAMETERS = UpdateType._(19, _omitEnumNames ? '' : 'UPDATE_FINALIZATION_COMMITTEE_PARAMETERS');

  static const $core.List<UpdateType> values = <UpdateType> [
    UPDATE_PROTOCOL,
    UPDATE_ELECTION_DIFFICULTY,
    UPDATE_EURO_PER_ENERGY,
    UPDATE_MICRO_CCD_PER_EURO,
    UPDATE_FOUNDATION_ACCOUNT,
    UPDATE_MINT_DISTRIBUTION,
    UPDATE_TRANSACTION_FEE_DISTRIBUTION,
    UPDATE_GAS_REWARDS,
    UPDATE_POOL_PARAMETERS,
    ADD_ANONYMITY_REVOKER,
    ADD_IDENTITY_PROVIDER,
    UPDATE_ROOT_KEYS,
    UPDATE_LEVEL1_KEYS,
    UPDATE_LEVEL2_KEYS,
    UPDATE_COOLDOWN_PARAMETERS,
    UPDATE_TIME_PARAMETERS,
    UPDATE_TIMEOUT_PARAMETERS,
    UPDATE_MIN_BLOCK_TIME,
    UPDATE_BLOCK_ENERGY_LIMIT,
    UPDATE_FINALIZATION_COMMITTEE_PARAMETERS,
  ];

  static final $core.Map<$core.int, UpdateType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UpdateType? valueOf($core.int value) => _byValue[value];

  const UpdateType._($core.int v, $core.String n) : super(v, n);
}

/// The type of transaction.
class TransactionType extends $pb.ProtobufEnum {
  static const TransactionType DEPLOY_MODULE = TransactionType._(0, _omitEnumNames ? '' : 'DEPLOY_MODULE');
  static const TransactionType INIT_CONTRACT = TransactionType._(1, _omitEnumNames ? '' : 'INIT_CONTRACT');
  static const TransactionType UPDATE = TransactionType._(2, _omitEnumNames ? '' : 'UPDATE');
  static const TransactionType TRANSFER = TransactionType._(3, _omitEnumNames ? '' : 'TRANSFER');
  static const TransactionType ADD_BAKER = TransactionType._(4, _omitEnumNames ? '' : 'ADD_BAKER');
  static const TransactionType REMOVE_BAKER = TransactionType._(5, _omitEnumNames ? '' : 'REMOVE_BAKER');
  static const TransactionType UPDATE_BAKER_STAKE = TransactionType._(6, _omitEnumNames ? '' : 'UPDATE_BAKER_STAKE');
  static const TransactionType UPDATE_BAKER_RESTAKE_EARNINGS = TransactionType._(7, _omitEnumNames ? '' : 'UPDATE_BAKER_RESTAKE_EARNINGS');
  static const TransactionType UPDATE_BAKER_KEYS = TransactionType._(8, _omitEnumNames ? '' : 'UPDATE_BAKER_KEYS');
  static const TransactionType UPDATE_CREDENTIAL_KEYS = TransactionType._(9, _omitEnumNames ? '' : 'UPDATE_CREDENTIAL_KEYS');
  static const TransactionType ENCRYPTED_AMOUNT_TRANSFER = TransactionType._(10, _omitEnumNames ? '' : 'ENCRYPTED_AMOUNT_TRANSFER');
  static const TransactionType TRANSFER_TO_ENCRYPTED = TransactionType._(11, _omitEnumNames ? '' : 'TRANSFER_TO_ENCRYPTED');
  static const TransactionType TRANSFER_TO_PUBLIC = TransactionType._(12, _omitEnumNames ? '' : 'TRANSFER_TO_PUBLIC');
  static const TransactionType TRANSFER_WITH_SCHEDULE = TransactionType._(13, _omitEnumNames ? '' : 'TRANSFER_WITH_SCHEDULE');
  static const TransactionType UPDATE_CREDENTIALS = TransactionType._(14, _omitEnumNames ? '' : 'UPDATE_CREDENTIALS');
  static const TransactionType REGISTER_DATA = TransactionType._(15, _omitEnumNames ? '' : 'REGISTER_DATA');
  static const TransactionType TRANSFER_WITH_MEMO = TransactionType._(16, _omitEnumNames ? '' : 'TRANSFER_WITH_MEMO');
  static const TransactionType ENCRYPTED_AMOUNT_TRANSFER_WITH_MEMO = TransactionType._(17, _omitEnumNames ? '' : 'ENCRYPTED_AMOUNT_TRANSFER_WITH_MEMO');
  static const TransactionType TRANSFER_WITH_SCHEDULE_AND_MEMO = TransactionType._(18, _omitEnumNames ? '' : 'TRANSFER_WITH_SCHEDULE_AND_MEMO');
  static const TransactionType CONFIGURE_BAKER = TransactionType._(19, _omitEnumNames ? '' : 'CONFIGURE_BAKER');
  static const TransactionType CONFIGURE_DELEGATION = TransactionType._(20, _omitEnumNames ? '' : 'CONFIGURE_DELEGATION');

  static const $core.List<TransactionType> values = <TransactionType> [
    DEPLOY_MODULE,
    INIT_CONTRACT,
    UPDATE,
    TRANSFER,
    ADD_BAKER,
    REMOVE_BAKER,
    UPDATE_BAKER_STAKE,
    UPDATE_BAKER_RESTAKE_EARNINGS,
    UPDATE_BAKER_KEYS,
    UPDATE_CREDENTIAL_KEYS,
    ENCRYPTED_AMOUNT_TRANSFER,
    TRANSFER_TO_ENCRYPTED,
    TRANSFER_TO_PUBLIC,
    TRANSFER_WITH_SCHEDULE,
    UPDATE_CREDENTIALS,
    REGISTER_DATA,
    TRANSFER_WITH_MEMO,
    ENCRYPTED_AMOUNT_TRANSFER_WITH_MEMO,
    TRANSFER_WITH_SCHEDULE_AND_MEMO,
    CONFIGURE_BAKER,
    CONFIGURE_DELEGATION,
  ];

  static final $core.Map<$core.int, TransactionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TransactionType? valueOf($core.int value) => _byValue[value];

  const TransactionType._($core.int v, $core.String n) : super(v, n);
}

/// The different versions of the protocol.
class ProtocolVersion extends $pb.ProtobufEnum {
  static const ProtocolVersion PROTOCOL_VERSION_1 = ProtocolVersion._(0, _omitEnumNames ? '' : 'PROTOCOL_VERSION_1');
  static const ProtocolVersion PROTOCOL_VERSION_2 = ProtocolVersion._(1, _omitEnumNames ? '' : 'PROTOCOL_VERSION_2');
  static const ProtocolVersion PROTOCOL_VERSION_3 = ProtocolVersion._(2, _omitEnumNames ? '' : 'PROTOCOL_VERSION_3');
  static const ProtocolVersion PROTOCOL_VERSION_4 = ProtocolVersion._(3, _omitEnumNames ? '' : 'PROTOCOL_VERSION_4');
  static const ProtocolVersion PROTOCOL_VERSION_5 = ProtocolVersion._(4, _omitEnumNames ? '' : 'PROTOCOL_VERSION_5');
  static const ProtocolVersion PROTOCOL_VERSION_6 = ProtocolVersion._(5, _omitEnumNames ? '' : 'PROTOCOL_VERSION_6');
  static const ProtocolVersion PROTOCOL_VERSION_7 = ProtocolVersion._(6, _omitEnumNames ? '' : 'PROTOCOL_VERSION_7');

  static const $core.List<ProtocolVersion> values = <ProtocolVersion> [
    PROTOCOL_VERSION_1,
    PROTOCOL_VERSION_2,
    PROTOCOL_VERSION_3,
    PROTOCOL_VERSION_4,
    PROTOCOL_VERSION_5,
    PROTOCOL_VERSION_6,
    PROTOCOL_VERSION_7,
  ];

  static final $core.Map<$core.int, ProtocolVersion> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolVersion? valueOf($core.int value) => _byValue[value];

  const ProtocolVersion._($core.int v, $core.String n) : super(v, n);
}

class PeersInfo_Peer_CatchupStatus extends $pb.ProtobufEnum {
  static const PeersInfo_Peer_CatchupStatus UPTODATE = PeersInfo_Peer_CatchupStatus._(0, _omitEnumNames ? '' : 'UPTODATE');
  static const PeersInfo_Peer_CatchupStatus PENDING = PeersInfo_Peer_CatchupStatus._(1, _omitEnumNames ? '' : 'PENDING');
  static const PeersInfo_Peer_CatchupStatus CATCHINGUP = PeersInfo_Peer_CatchupStatus._(2, _omitEnumNames ? '' : 'CATCHINGUP');

  static const $core.List<PeersInfo_Peer_CatchupStatus> values = <PeersInfo_Peer_CatchupStatus> [
    UPTODATE,
    PENDING,
    CATCHINGUP,
  ];

  static final $core.Map<$core.int, PeersInfo_Peer_CatchupStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PeersInfo_Peer_CatchupStatus? valueOf($core.int value) => _byValue[value];

  const PeersInfo_Peer_CatchupStatus._($core.int v, $core.String n) : super(v, n);
}

/// The committee information of a node configured with
/// baker keys but somehow the node is _not_ part of the
/// current baking committee.
class NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo extends $pb.ProtobufEnum {
  static const NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo NOT_IN_COMMITTEE = NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo._(0, _omitEnumNames ? '' : 'NOT_IN_COMMITTEE');
  static const NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo ADDED_BUT_NOT_ACTIVE_IN_COMMITTEE = NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo._(1, _omitEnumNames ? '' : 'ADDED_BUT_NOT_ACTIVE_IN_COMMITTEE');
  static const NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo ADDED_BUT_WRONG_KEYS = NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo._(2, _omitEnumNames ? '' : 'ADDED_BUT_WRONG_KEYS');

  static const $core.List<NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo> values = <NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo> [
    NOT_IN_COMMITTEE,
    ADDED_BUT_NOT_ACTIVE_IN_COMMITTEE,
    ADDED_BUT_WRONG_KEYS,
  ];

  static final $core.Map<$core.int, NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo? valueOf($core.int value) => _byValue[value];

  const NodeInfo_BakerConsensusInfo_PassiveCommitteeInfo._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
