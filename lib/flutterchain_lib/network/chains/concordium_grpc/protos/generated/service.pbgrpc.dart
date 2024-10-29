//
//  Generated code. Do not modify.
//  source: lib/flutterchain_lib/network/chains/concordium_grpc/protos/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'types.pb.dart' as $1;

export 'service.pb.dart';

@$pb.GrpcServiceName('concordium.v2.Queries')
class QueriesClient extends $grpc.Client {
  static final _$getBlocks = $grpc.ClientMethod<$1.Empty, $1.ArrivedBlockInfo>(
      '/concordium.v2.Queries/GetBlocks',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ArrivedBlockInfo.fromBuffer(value));
  static final _$getFinalizedBlocks = $grpc.ClientMethod<$1.Empty, $1.FinalizedBlockInfo>(
      '/concordium.v2.Queries/GetFinalizedBlocks',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FinalizedBlockInfo.fromBuffer(value));
  static final _$getAccountInfo = $grpc.ClientMethod<$1.AccountInfoRequest, $1.AccountInfo>(
      '/concordium.v2.Queries/GetAccountInfo',
      ($1.AccountInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AccountInfo.fromBuffer(value));
  static final _$getAccountList = $grpc.ClientMethod<$1.BlockHashInput, $1.AccountAddress>(
      '/concordium.v2.Queries/GetAccountList',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AccountAddress.fromBuffer(value));
  static final _$getModuleList = $grpc.ClientMethod<$1.BlockHashInput, $1.ModuleRef>(
      '/concordium.v2.Queries/GetModuleList',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ModuleRef.fromBuffer(value));
  static final _$getAncestors = $grpc.ClientMethod<$1.AncestorsRequest, $1.BlockHash>(
      '/concordium.v2.Queries/GetAncestors',
      ($1.AncestorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockHash.fromBuffer(value));
  static final _$getModuleSource = $grpc.ClientMethod<$1.ModuleSourceRequest, $1.VersionedModuleSource>(
      '/concordium.v2.Queries/GetModuleSource',
      ($1.ModuleSourceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.VersionedModuleSource.fromBuffer(value));
  static final _$getInstanceList = $grpc.ClientMethod<$1.BlockHashInput, $1.ContractAddress>(
      '/concordium.v2.Queries/GetInstanceList',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ContractAddress.fromBuffer(value));
  static final _$getInstanceInfo = $grpc.ClientMethod<$1.InstanceInfoRequest, $1.InstanceInfo>(
      '/concordium.v2.Queries/GetInstanceInfo',
      ($1.InstanceInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.InstanceInfo.fromBuffer(value));
  static final _$getInstanceState = $grpc.ClientMethod<$1.InstanceInfoRequest, $1.InstanceStateKVPair>(
      '/concordium.v2.Queries/GetInstanceState',
      ($1.InstanceInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.InstanceStateKVPair.fromBuffer(value));
  static final _$instanceStateLookup = $grpc.ClientMethod<$1.InstanceStateLookupRequest, $1.InstanceStateValueAtKey>(
      '/concordium.v2.Queries/InstanceStateLookup',
      ($1.InstanceStateLookupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.InstanceStateValueAtKey.fromBuffer(value));
  static final _$getNextAccountSequenceNumber = $grpc.ClientMethod<$1.AccountAddress, $1.NextAccountSequenceNumber>(
      '/concordium.v2.Queries/GetNextAccountSequenceNumber',
      ($1.AccountAddress value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.NextAccountSequenceNumber.fromBuffer(value));
  static final _$getConsensusInfo = $grpc.ClientMethod<$1.Empty, $1.ConsensusInfo>(
      '/concordium.v2.Queries/GetConsensusInfo',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ConsensusInfo.fromBuffer(value));
  static final _$getBlockItemStatus = $grpc.ClientMethod<$1.TransactionHash, $1.BlockItemStatus>(
      '/concordium.v2.Queries/GetBlockItemStatus',
      ($1.TransactionHash value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockItemStatus.fromBuffer(value));
  static final _$getCryptographicParameters = $grpc.ClientMethod<$1.BlockHashInput, $1.CryptographicParameters>(
      '/concordium.v2.Queries/GetCryptographicParameters',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CryptographicParameters.fromBuffer(value));
  static final _$getBlockInfo = $grpc.ClientMethod<$1.BlockHashInput, $1.BlockInfo>(
      '/concordium.v2.Queries/GetBlockInfo',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockInfo.fromBuffer(value));
  static final _$getBakerList = $grpc.ClientMethod<$1.BlockHashInput, $1.BakerId>(
      '/concordium.v2.Queries/GetBakerList',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BakerId.fromBuffer(value));
  static final _$getPoolInfo = $grpc.ClientMethod<$1.PoolInfoRequest, $1.PoolInfoResponse>(
      '/concordium.v2.Queries/GetPoolInfo',
      ($1.PoolInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PoolInfoResponse.fromBuffer(value));
  static final _$getPassiveDelegationInfo = $grpc.ClientMethod<$1.BlockHashInput, $1.PassiveDelegationInfo>(
      '/concordium.v2.Queries/GetPassiveDelegationInfo',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PassiveDelegationInfo.fromBuffer(value));
  static final _$getBlocksAtHeight = $grpc.ClientMethod<$1.BlocksAtHeightRequest, $1.BlocksAtHeightResponse>(
      '/concordium.v2.Queries/GetBlocksAtHeight',
      ($1.BlocksAtHeightRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlocksAtHeightResponse.fromBuffer(value));
  static final _$getTokenomicsInfo = $grpc.ClientMethod<$1.BlockHashInput, $1.TokenomicsInfo>(
      '/concordium.v2.Queries/GetTokenomicsInfo',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.TokenomicsInfo.fromBuffer(value));
  static final _$invokeInstance = $grpc.ClientMethod<$1.InvokeInstanceRequest, $1.InvokeInstanceResponse>(
      '/concordium.v2.Queries/InvokeInstance',
      ($1.InvokeInstanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.InvokeInstanceResponse.fromBuffer(value));
  static final _$getPoolDelegators = $grpc.ClientMethod<$1.GetPoolDelegatorsRequest, $1.DelegatorInfo>(
      '/concordium.v2.Queries/GetPoolDelegators',
      ($1.GetPoolDelegatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DelegatorInfo.fromBuffer(value));
  static final _$getPoolDelegatorsRewardPeriod = $grpc.ClientMethod<$1.GetPoolDelegatorsRequest, $1.DelegatorRewardPeriodInfo>(
      '/concordium.v2.Queries/GetPoolDelegatorsRewardPeriod',
      ($1.GetPoolDelegatorsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DelegatorRewardPeriodInfo.fromBuffer(value));
  static final _$getPassiveDelegators = $grpc.ClientMethod<$1.BlockHashInput, $1.DelegatorInfo>(
      '/concordium.v2.Queries/GetPassiveDelegators',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DelegatorInfo.fromBuffer(value));
  static final _$getPassiveDelegatorsRewardPeriod = $grpc.ClientMethod<$1.BlockHashInput, $1.DelegatorRewardPeriodInfo>(
      '/concordium.v2.Queries/GetPassiveDelegatorsRewardPeriod',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DelegatorRewardPeriodInfo.fromBuffer(value));
  static final _$getBranches = $grpc.ClientMethod<$1.Empty, $1.Branch>(
      '/concordium.v2.Queries/GetBranches',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Branch.fromBuffer(value));
  static final _$getElectionInfo = $grpc.ClientMethod<$1.BlockHashInput, $1.ElectionInfo>(
      '/concordium.v2.Queries/GetElectionInfo',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ElectionInfo.fromBuffer(value));
  static final _$getIdentityProviders = $grpc.ClientMethod<$1.BlockHashInput, $1.IpInfo>(
      '/concordium.v2.Queries/GetIdentityProviders',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.IpInfo.fromBuffer(value));
  static final _$getAnonymityRevokers = $grpc.ClientMethod<$1.BlockHashInput, $1.ArInfo>(
      '/concordium.v2.Queries/GetAnonymityRevokers',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ArInfo.fromBuffer(value));
  static final _$getAccountNonFinalizedTransactions = $grpc.ClientMethod<$1.AccountAddress, $1.TransactionHash>(
      '/concordium.v2.Queries/GetAccountNonFinalizedTransactions',
      ($1.AccountAddress value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.TransactionHash.fromBuffer(value));
  static final _$getBlockTransactionEvents = $grpc.ClientMethod<$1.BlockHashInput, $1.BlockItemSummary>(
      '/concordium.v2.Queries/GetBlockTransactionEvents',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockItemSummary.fromBuffer(value));
  static final _$getBlockSpecialEvents = $grpc.ClientMethod<$1.BlockHashInput, $1.BlockSpecialEvent>(
      '/concordium.v2.Queries/GetBlockSpecialEvents',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockSpecialEvent.fromBuffer(value));
  static final _$getBlockPendingUpdates = $grpc.ClientMethod<$1.BlockHashInput, $1.PendingUpdate>(
      '/concordium.v2.Queries/GetBlockPendingUpdates',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PendingUpdate.fromBuffer(value));
  static final _$getNextUpdateSequenceNumbers = $grpc.ClientMethod<$1.BlockHashInput, $1.NextUpdateSequenceNumbers>(
      '/concordium.v2.Queries/GetNextUpdateSequenceNumbers',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.NextUpdateSequenceNumbers.fromBuffer(value));
  static final _$getBakerEarliestWinTime = $grpc.ClientMethod<$1.BakerId, $1.Timestamp>(
      '/concordium.v2.Queries/GetBakerEarliestWinTime',
      ($1.BakerId value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Timestamp.fromBuffer(value));
  static final _$shutdown = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/concordium.v2.Queries/Shutdown',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$peerConnect = $grpc.ClientMethod<$1.IpSocketAddress, $1.Empty>(
      '/concordium.v2.Queries/PeerConnect',
      ($1.IpSocketAddress value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$peerDisconnect = $grpc.ClientMethod<$1.IpSocketAddress, $1.Empty>(
      '/concordium.v2.Queries/PeerDisconnect',
      ($1.IpSocketAddress value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getBannedPeers = $grpc.ClientMethod<$1.Empty, $1.BannedPeers>(
      '/concordium.v2.Queries/GetBannedPeers',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BannedPeers.fromBuffer(value));
  static final _$banPeer = $grpc.ClientMethod<$1.PeerToBan, $1.Empty>(
      '/concordium.v2.Queries/BanPeer',
      ($1.PeerToBan value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$unbanPeer = $grpc.ClientMethod<$1.BannedPeer, $1.Empty>(
      '/concordium.v2.Queries/UnbanPeer',
      ($1.BannedPeer value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$dumpStart = $grpc.ClientMethod<$1.DumpRequest, $1.Empty>(
      '/concordium.v2.Queries/DumpStart',
      ($1.DumpRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$dumpStop = $grpc.ClientMethod<$1.Empty, $1.Empty>(
      '/concordium.v2.Queries/DumpStop',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$getPeersInfo = $grpc.ClientMethod<$1.Empty, $1.PeersInfo>(
      '/concordium.v2.Queries/GetPeersInfo',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PeersInfo.fromBuffer(value));
  static final _$getNodeInfo = $grpc.ClientMethod<$1.Empty, $1.NodeInfo>(
      '/concordium.v2.Queries/GetNodeInfo',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.NodeInfo.fromBuffer(value));
  static final _$sendBlockItem = $grpc.ClientMethod<$1.SendBlockItemRequest, $1.TransactionHash>(
      '/concordium.v2.Queries/SendBlockItem',
      ($1.SendBlockItemRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.TransactionHash.fromBuffer(value));
  static final _$getAccountTransactionSignHash = $grpc.ClientMethod<$1.PreAccountTransaction, $1.AccountTransactionSignHash>(
      '/concordium.v2.Queries/GetAccountTransactionSignHash',
      ($1.PreAccountTransaction value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AccountTransactionSignHash.fromBuffer(value));
  static final _$getBlockChainParameters = $grpc.ClientMethod<$1.BlockHashInput, $1.ChainParameters>(
      '/concordium.v2.Queries/GetBlockChainParameters',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChainParameters.fromBuffer(value));
  static final _$getBlockFinalizationSummary = $grpc.ClientMethod<$1.BlockHashInput, $1.BlockFinalizationSummary>(
      '/concordium.v2.Queries/GetBlockFinalizationSummary',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockFinalizationSummary.fromBuffer(value));
  static final _$getBlockItems = $grpc.ClientMethod<$1.BlockHashInput, $1.BlockItem>(
      '/concordium.v2.Queries/GetBlockItems',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockItem.fromBuffer(value));
  static final _$getBakersRewardPeriod = $grpc.ClientMethod<$1.BlockHashInput, $1.BakerRewardPeriodInfo>(
      '/concordium.v2.Queries/GetBakersRewardPeriod',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BakerRewardPeriodInfo.fromBuffer(value));
  static final _$getBlockCertificates = $grpc.ClientMethod<$1.BlockHashInput, $1.BlockCertificates>(
      '/concordium.v2.Queries/GetBlockCertificates',
      ($1.BlockHashInput value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockCertificates.fromBuffer(value));
  static final _$getWinningBakersEpoch = $grpc.ClientMethod<$1.EpochRequest, $1.WinningBaker>(
      '/concordium.v2.Queries/GetWinningBakersEpoch',
      ($1.EpochRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.WinningBaker.fromBuffer(value));
  static final _$getFirstBlockEpoch = $grpc.ClientMethod<$1.EpochRequest, $1.BlockHash>(
      '/concordium.v2.Queries/GetFirstBlockEpoch',
      ($1.EpochRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BlockHash.fromBuffer(value));
  static final _$dryRun = $grpc.ClientMethod<$1.DryRunRequest, $1.DryRunResponse>(
      '/concordium.v2.Queries/DryRun',
      ($1.DryRunRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DryRunResponse.fromBuffer(value));

  QueriesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$1.ArrivedBlockInfo> getBlocks($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBlocks, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.FinalizedBlockInfo> getFinalizedBlocks($1.Empty request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getFinalizedBlocks, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.AccountInfo> getAccountInfo($1.AccountInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountInfo, request, options: options);
  }

  $grpc.ResponseStream<$1.AccountAddress> getAccountList($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getAccountList, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.ModuleRef> getModuleList($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getModuleList, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.BlockHash> getAncestors($1.AncestorsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getAncestors, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.VersionedModuleSource> getModuleSource($1.ModuleSourceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getModuleSource, request, options: options);
  }

  $grpc.ResponseStream<$1.ContractAddress> getInstanceList($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getInstanceList, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.InstanceInfo> getInstanceInfo($1.InstanceInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInstanceInfo, request, options: options);
  }

  $grpc.ResponseStream<$1.InstanceStateKVPair> getInstanceState($1.InstanceInfoRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getInstanceState, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.InstanceStateValueAtKey> instanceStateLookup($1.InstanceStateLookupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$instanceStateLookup, request, options: options);
  }

  $grpc.ResponseFuture<$1.NextAccountSequenceNumber> getNextAccountSequenceNumber($1.AccountAddress request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNextAccountSequenceNumber, request, options: options);
  }

  $grpc.ResponseFuture<$1.ConsensusInfo> getConsensusInfo($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getConsensusInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.BlockItemStatus> getBlockItemStatus($1.TransactionHash request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlockItemStatus, request, options: options);
  }

  $grpc.ResponseFuture<$1.CryptographicParameters> getCryptographicParameters($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCryptographicParameters, request, options: options);
  }

  $grpc.ResponseFuture<$1.BlockInfo> getBlockInfo($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlockInfo, request, options: options);
  }

  $grpc.ResponseStream<$1.BakerId> getBakerList($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBakerList, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.PoolInfoResponse> getPoolInfo($1.PoolInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPoolInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.PassiveDelegationInfo> getPassiveDelegationInfo($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPassiveDelegationInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.BlocksAtHeightResponse> getBlocksAtHeight($1.BlocksAtHeightRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlocksAtHeight, request, options: options);
  }

  $grpc.ResponseFuture<$1.TokenomicsInfo> getTokenomicsInfo($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTokenomicsInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.InvokeInstanceResponse> invokeInstance($1.InvokeInstanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$invokeInstance, request, options: options);
  }

  $grpc.ResponseStream<$1.DelegatorInfo> getPoolDelegators($1.GetPoolDelegatorsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getPoolDelegators, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.DelegatorRewardPeriodInfo> getPoolDelegatorsRewardPeriod($1.GetPoolDelegatorsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getPoolDelegatorsRewardPeriod, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.DelegatorInfo> getPassiveDelegators($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getPassiveDelegators, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.DelegatorRewardPeriodInfo> getPassiveDelegatorsRewardPeriod($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getPassiveDelegatorsRewardPeriod, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.Branch> getBranches($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBranches, request, options: options);
  }

  $grpc.ResponseFuture<$1.ElectionInfo> getElectionInfo($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getElectionInfo, request, options: options);
  }

  $grpc.ResponseStream<$1.IpInfo> getIdentityProviders($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getIdentityProviders, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.ArInfo> getAnonymityRevokers($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getAnonymityRevokers, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.TransactionHash> getAccountNonFinalizedTransactions($1.AccountAddress request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getAccountNonFinalizedTransactions, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.BlockItemSummary> getBlockTransactionEvents($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBlockTransactionEvents, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.BlockSpecialEvent> getBlockSpecialEvents($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBlockSpecialEvents, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.PendingUpdate> getBlockPendingUpdates($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBlockPendingUpdates, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.NextUpdateSequenceNumbers> getNextUpdateSequenceNumbers($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNextUpdateSequenceNumbers, request, options: options);
  }

  $grpc.ResponseFuture<$1.Timestamp> getBakerEarliestWinTime($1.BakerId request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBakerEarliestWinTime, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> shutdown($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$shutdown, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> peerConnect($1.IpSocketAddress request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$peerConnect, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> peerDisconnect($1.IpSocketAddress request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$peerDisconnect, request, options: options);
  }

  $grpc.ResponseFuture<$1.BannedPeers> getBannedPeers($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBannedPeers, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> banPeer($1.PeerToBan request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$banPeer, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> unbanPeer($1.BannedPeer request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unbanPeer, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> dumpStart($1.DumpRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$dumpStart, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> dumpStop($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$dumpStop, request, options: options);
  }

  $grpc.ResponseFuture<$1.PeersInfo> getPeersInfo($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPeersInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.NodeInfo> getNodeInfo($1.Empty request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodeInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.TransactionHash> sendBlockItem($1.SendBlockItemRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendBlockItem, request, options: options);
  }

  $grpc.ResponseFuture<$1.AccountTransactionSignHash> getAccountTransactionSignHash($1.PreAccountTransaction request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAccountTransactionSignHash, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChainParameters> getBlockChainParameters($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlockChainParameters, request, options: options);
  }

  $grpc.ResponseFuture<$1.BlockFinalizationSummary> getBlockFinalizationSummary($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlockFinalizationSummary, request, options: options);
  }

  $grpc.ResponseStream<$1.BlockItem> getBlockItems($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBlockItems, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.BakerRewardPeriodInfo> getBakersRewardPeriod($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getBakersRewardPeriod, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.BlockCertificates> getBlockCertificates($1.BlockHashInput request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBlockCertificates, request, options: options);
  }

  $grpc.ResponseStream<$1.WinningBaker> getWinningBakersEpoch($1.EpochRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getWinningBakersEpoch, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.BlockHash> getFirstBlockEpoch($1.EpochRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getFirstBlockEpoch, request, options: options);
  }

  $grpc.ResponseStream<$1.DryRunResponse> dryRun($async.Stream<$1.DryRunRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$dryRun, request, options: options);
  }
}

@$pb.GrpcServiceName('concordium.v2.Queries')
abstract class QueriesServiceBase extends $grpc.Service {
  $core.String get $name => 'concordium.v2.Queries';

  QueriesServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.ArrivedBlockInfo>(
        'GetBlocks',
        getBlocks_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.ArrivedBlockInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.FinalizedBlockInfo>(
        'GetFinalizedBlocks',
        getFinalizedBlocks_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.FinalizedBlockInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AccountInfoRequest, $1.AccountInfo>(
        'GetAccountInfo',
        getAccountInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AccountInfoRequest.fromBuffer(value),
        ($1.AccountInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.AccountAddress>(
        'GetAccountList',
        getAccountList_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.AccountAddress value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.ModuleRef>(
        'GetModuleList',
        getModuleList_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.ModuleRef value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AncestorsRequest, $1.BlockHash>(
        'GetAncestors',
        getAncestors_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.AncestorsRequest.fromBuffer(value),
        ($1.BlockHash value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ModuleSourceRequest, $1.VersionedModuleSource>(
        'GetModuleSource',
        getModuleSource_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ModuleSourceRequest.fromBuffer(value),
        ($1.VersionedModuleSource value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.ContractAddress>(
        'GetInstanceList',
        getInstanceList_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.ContractAddress value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.InstanceInfoRequest, $1.InstanceInfo>(
        'GetInstanceInfo',
        getInstanceInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.InstanceInfoRequest.fromBuffer(value),
        ($1.InstanceInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.InstanceInfoRequest, $1.InstanceStateKVPair>(
        'GetInstanceState',
        getInstanceState_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.InstanceInfoRequest.fromBuffer(value),
        ($1.InstanceStateKVPair value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.InstanceStateLookupRequest, $1.InstanceStateValueAtKey>(
        'InstanceStateLookup',
        instanceStateLookup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.InstanceStateLookupRequest.fromBuffer(value),
        ($1.InstanceStateValueAtKey value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AccountAddress, $1.NextAccountSequenceNumber>(
        'GetNextAccountSequenceNumber',
        getNextAccountSequenceNumber_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AccountAddress.fromBuffer(value),
        ($1.NextAccountSequenceNumber value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.ConsensusInfo>(
        'GetConsensusInfo',
        getConsensusInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.ConsensusInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.TransactionHash, $1.BlockItemStatus>(
        'GetBlockItemStatus',
        getBlockItemStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.TransactionHash.fromBuffer(value),
        ($1.BlockItemStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.CryptographicParameters>(
        'GetCryptographicParameters',
        getCryptographicParameters_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.CryptographicParameters value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BlockInfo>(
        'GetBlockInfo',
        getBlockInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BlockInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BakerId>(
        'GetBakerList',
        getBakerList_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BakerId value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PoolInfoRequest, $1.PoolInfoResponse>(
        'GetPoolInfo',
        getPoolInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PoolInfoRequest.fromBuffer(value),
        ($1.PoolInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.PassiveDelegationInfo>(
        'GetPassiveDelegationInfo',
        getPassiveDelegationInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.PassiveDelegationInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlocksAtHeightRequest, $1.BlocksAtHeightResponse>(
        'GetBlocksAtHeight',
        getBlocksAtHeight_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlocksAtHeightRequest.fromBuffer(value),
        ($1.BlocksAtHeightResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.TokenomicsInfo>(
        'GetTokenomicsInfo',
        getTokenomicsInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.TokenomicsInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.InvokeInstanceRequest, $1.InvokeInstanceResponse>(
        'InvokeInstance',
        invokeInstance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.InvokeInstanceRequest.fromBuffer(value),
        ($1.InvokeInstanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetPoolDelegatorsRequest, $1.DelegatorInfo>(
        'GetPoolDelegators',
        getPoolDelegators_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.GetPoolDelegatorsRequest.fromBuffer(value),
        ($1.DelegatorInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetPoolDelegatorsRequest, $1.DelegatorRewardPeriodInfo>(
        'GetPoolDelegatorsRewardPeriod',
        getPoolDelegatorsRewardPeriod_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.GetPoolDelegatorsRequest.fromBuffer(value),
        ($1.DelegatorRewardPeriodInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.DelegatorInfo>(
        'GetPassiveDelegators',
        getPassiveDelegators_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.DelegatorInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.DelegatorRewardPeriodInfo>(
        'GetPassiveDelegatorsRewardPeriod',
        getPassiveDelegatorsRewardPeriod_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.DelegatorRewardPeriodInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Branch>(
        'GetBranches',
        getBranches_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Branch value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.ElectionInfo>(
        'GetElectionInfo',
        getElectionInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.ElectionInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.IpInfo>(
        'GetIdentityProviders',
        getIdentityProviders_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.IpInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.ArInfo>(
        'GetAnonymityRevokers',
        getAnonymityRevokers_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.ArInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AccountAddress, $1.TransactionHash>(
        'GetAccountNonFinalizedTransactions',
        getAccountNonFinalizedTransactions_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.AccountAddress.fromBuffer(value),
        ($1.TransactionHash value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BlockItemSummary>(
        'GetBlockTransactionEvents',
        getBlockTransactionEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BlockItemSummary value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BlockSpecialEvent>(
        'GetBlockSpecialEvents',
        getBlockSpecialEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BlockSpecialEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.PendingUpdate>(
        'GetBlockPendingUpdates',
        getBlockPendingUpdates_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.PendingUpdate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.NextUpdateSequenceNumbers>(
        'GetNextUpdateSequenceNumbers',
        getNextUpdateSequenceNumbers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.NextUpdateSequenceNumbers value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BakerId, $1.Timestamp>(
        'GetBakerEarliestWinTime',
        getBakerEarliestWinTime_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BakerId.fromBuffer(value),
        ($1.Timestamp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'Shutdown',
        shutdown_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.IpSocketAddress, $1.Empty>(
        'PeerConnect',
        peerConnect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.IpSocketAddress.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.IpSocketAddress, $1.Empty>(
        'PeerDisconnect',
        peerDisconnect_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.IpSocketAddress.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.BannedPeers>(
        'GetBannedPeers',
        getBannedPeers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.BannedPeers value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PeerToBan, $1.Empty>(
        'BanPeer',
        banPeer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PeerToBan.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BannedPeer, $1.Empty>(
        'UnbanPeer',
        unbanPeer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BannedPeer.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DumpRequest, $1.Empty>(
        'DumpStart',
        dumpStart_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DumpRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.Empty>(
        'DumpStop',
        dumpStop_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.PeersInfo>(
        'GetPeersInfo',
        getPeersInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.PeersInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.NodeInfo>(
        'GetNodeInfo',
        getNodeInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.NodeInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendBlockItemRequest, $1.TransactionHash>(
        'SendBlockItem',
        sendBlockItem_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SendBlockItemRequest.fromBuffer(value),
        ($1.TransactionHash value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PreAccountTransaction, $1.AccountTransactionSignHash>(
        'GetAccountTransactionSignHash',
        getAccountTransactionSignHash_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PreAccountTransaction.fromBuffer(value),
        ($1.AccountTransactionSignHash value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.ChainParameters>(
        'GetBlockChainParameters',
        getBlockChainParameters_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.ChainParameters value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BlockFinalizationSummary>(
        'GetBlockFinalizationSummary',
        getBlockFinalizationSummary_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BlockFinalizationSummary value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BlockItem>(
        'GetBlockItems',
        getBlockItems_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BlockItem value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BakerRewardPeriodInfo>(
        'GetBakersRewardPeriod',
        getBakersRewardPeriod_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BakerRewardPeriodInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BlockHashInput, $1.BlockCertificates>(
        'GetBlockCertificates',
        getBlockCertificates_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BlockHashInput.fromBuffer(value),
        ($1.BlockCertificates value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EpochRequest, $1.WinningBaker>(
        'GetWinningBakersEpoch',
        getWinningBakersEpoch_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.EpochRequest.fromBuffer(value),
        ($1.WinningBaker value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EpochRequest, $1.BlockHash>(
        'GetFirstBlockEpoch',
        getFirstBlockEpoch_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.EpochRequest.fromBuffer(value),
        ($1.BlockHash value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DryRunRequest, $1.DryRunResponse>(
        'DryRun',
        dryRun,
        true,
        true,
        ($core.List<$core.int> value) => $1.DryRunRequest.fromBuffer(value),
        ($1.DryRunResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$1.ArrivedBlockInfo> getBlocks_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* getBlocks(call, await request);
  }

  $async.Stream<$1.FinalizedBlockInfo> getFinalizedBlocks_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async* {
    yield* getFinalizedBlocks(call, await request);
  }

  $async.Future<$1.AccountInfo> getAccountInfo_Pre($grpc.ServiceCall call, $async.Future<$1.AccountInfoRequest> request) async {
    return getAccountInfo(call, await request);
  }

  $async.Stream<$1.AccountAddress> getAccountList_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getAccountList(call, await request);
  }

  $async.Stream<$1.ModuleRef> getModuleList_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getModuleList(call, await request);
  }

  $async.Stream<$1.BlockHash> getAncestors_Pre($grpc.ServiceCall call, $async.Future<$1.AncestorsRequest> request) async* {
    yield* getAncestors(call, await request);
  }

  $async.Future<$1.VersionedModuleSource> getModuleSource_Pre($grpc.ServiceCall call, $async.Future<$1.ModuleSourceRequest> request) async {
    return getModuleSource(call, await request);
  }

  $async.Stream<$1.ContractAddress> getInstanceList_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getInstanceList(call, await request);
  }

  $async.Future<$1.InstanceInfo> getInstanceInfo_Pre($grpc.ServiceCall call, $async.Future<$1.InstanceInfoRequest> request) async {
    return getInstanceInfo(call, await request);
  }

  $async.Stream<$1.InstanceStateKVPair> getInstanceState_Pre($grpc.ServiceCall call, $async.Future<$1.InstanceInfoRequest> request) async* {
    yield* getInstanceState(call, await request);
  }

  $async.Future<$1.InstanceStateValueAtKey> instanceStateLookup_Pre($grpc.ServiceCall call, $async.Future<$1.InstanceStateLookupRequest> request) async {
    return instanceStateLookup(call, await request);
  }

  $async.Future<$1.NextAccountSequenceNumber> getNextAccountSequenceNumber_Pre($grpc.ServiceCall call, $async.Future<$1.AccountAddress> request) async {
    return getNextAccountSequenceNumber(call, await request);
  }

  $async.Future<$1.ConsensusInfo> getConsensusInfo_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getConsensusInfo(call, await request);
  }

  $async.Future<$1.BlockItemStatus> getBlockItemStatus_Pre($grpc.ServiceCall call, $async.Future<$1.TransactionHash> request) async {
    return getBlockItemStatus(call, await request);
  }

  $async.Future<$1.CryptographicParameters> getCryptographicParameters_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getCryptographicParameters(call, await request);
  }

  $async.Future<$1.BlockInfo> getBlockInfo_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getBlockInfo(call, await request);
  }

  $async.Stream<$1.BakerId> getBakerList_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getBakerList(call, await request);
  }

  $async.Future<$1.PoolInfoResponse> getPoolInfo_Pre($grpc.ServiceCall call, $async.Future<$1.PoolInfoRequest> request) async {
    return getPoolInfo(call, await request);
  }

  $async.Future<$1.PassiveDelegationInfo> getPassiveDelegationInfo_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getPassiveDelegationInfo(call, await request);
  }

  $async.Future<$1.BlocksAtHeightResponse> getBlocksAtHeight_Pre($grpc.ServiceCall call, $async.Future<$1.BlocksAtHeightRequest> request) async {
    return getBlocksAtHeight(call, await request);
  }

  $async.Future<$1.TokenomicsInfo> getTokenomicsInfo_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getTokenomicsInfo(call, await request);
  }

  $async.Future<$1.InvokeInstanceResponse> invokeInstance_Pre($grpc.ServiceCall call, $async.Future<$1.InvokeInstanceRequest> request) async {
    return invokeInstance(call, await request);
  }

  $async.Stream<$1.DelegatorInfo> getPoolDelegators_Pre($grpc.ServiceCall call, $async.Future<$1.GetPoolDelegatorsRequest> request) async* {
    yield* getPoolDelegators(call, await request);
  }

  $async.Stream<$1.DelegatorRewardPeriodInfo> getPoolDelegatorsRewardPeriod_Pre($grpc.ServiceCall call, $async.Future<$1.GetPoolDelegatorsRequest> request) async* {
    yield* getPoolDelegatorsRewardPeriod(call, await request);
  }

  $async.Stream<$1.DelegatorInfo> getPassiveDelegators_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getPassiveDelegators(call, await request);
  }

  $async.Stream<$1.DelegatorRewardPeriodInfo> getPassiveDelegatorsRewardPeriod_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getPassiveDelegatorsRewardPeriod(call, await request);
  }

  $async.Future<$1.Branch> getBranches_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getBranches(call, await request);
  }

  $async.Future<$1.ElectionInfo> getElectionInfo_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getElectionInfo(call, await request);
  }

  $async.Stream<$1.IpInfo> getIdentityProviders_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getIdentityProviders(call, await request);
  }

  $async.Stream<$1.ArInfo> getAnonymityRevokers_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getAnonymityRevokers(call, await request);
  }

  $async.Stream<$1.TransactionHash> getAccountNonFinalizedTransactions_Pre($grpc.ServiceCall call, $async.Future<$1.AccountAddress> request) async* {
    yield* getAccountNonFinalizedTransactions(call, await request);
  }

  $async.Stream<$1.BlockItemSummary> getBlockTransactionEvents_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getBlockTransactionEvents(call, await request);
  }

  $async.Stream<$1.BlockSpecialEvent> getBlockSpecialEvents_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getBlockSpecialEvents(call, await request);
  }

  $async.Stream<$1.PendingUpdate> getBlockPendingUpdates_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getBlockPendingUpdates(call, await request);
  }

  $async.Future<$1.NextUpdateSequenceNumbers> getNextUpdateSequenceNumbers_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getNextUpdateSequenceNumbers(call, await request);
  }

  $async.Future<$1.Timestamp> getBakerEarliestWinTime_Pre($grpc.ServiceCall call, $async.Future<$1.BakerId> request) async {
    return getBakerEarliestWinTime(call, await request);
  }

  $async.Future<$1.Empty> shutdown_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return shutdown(call, await request);
  }

  $async.Future<$1.Empty> peerConnect_Pre($grpc.ServiceCall call, $async.Future<$1.IpSocketAddress> request) async {
    return peerConnect(call, await request);
  }

  $async.Future<$1.Empty> peerDisconnect_Pre($grpc.ServiceCall call, $async.Future<$1.IpSocketAddress> request) async {
    return peerDisconnect(call, await request);
  }

  $async.Future<$1.BannedPeers> getBannedPeers_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getBannedPeers(call, await request);
  }

  $async.Future<$1.Empty> banPeer_Pre($grpc.ServiceCall call, $async.Future<$1.PeerToBan> request) async {
    return banPeer(call, await request);
  }

  $async.Future<$1.Empty> unbanPeer_Pre($grpc.ServiceCall call, $async.Future<$1.BannedPeer> request) async {
    return unbanPeer(call, await request);
  }

  $async.Future<$1.Empty> dumpStart_Pre($grpc.ServiceCall call, $async.Future<$1.DumpRequest> request) async {
    return dumpStart(call, await request);
  }

  $async.Future<$1.Empty> dumpStop_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return dumpStop(call, await request);
  }

  $async.Future<$1.PeersInfo> getPeersInfo_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getPeersInfo(call, await request);
  }

  $async.Future<$1.NodeInfo> getNodeInfo_Pre($grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getNodeInfo(call, await request);
  }

  $async.Future<$1.TransactionHash> sendBlockItem_Pre($grpc.ServiceCall call, $async.Future<$1.SendBlockItemRequest> request) async {
    return sendBlockItem(call, await request);
  }

  $async.Future<$1.AccountTransactionSignHash> getAccountTransactionSignHash_Pre($grpc.ServiceCall call, $async.Future<$1.PreAccountTransaction> request) async {
    return getAccountTransactionSignHash(call, await request);
  }

  $async.Future<$1.ChainParameters> getBlockChainParameters_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getBlockChainParameters(call, await request);
  }

  $async.Future<$1.BlockFinalizationSummary> getBlockFinalizationSummary_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getBlockFinalizationSummary(call, await request);
  }

  $async.Stream<$1.BlockItem> getBlockItems_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getBlockItems(call, await request);
  }

  $async.Stream<$1.BakerRewardPeriodInfo> getBakersRewardPeriod_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async* {
    yield* getBakersRewardPeriod(call, await request);
  }

  $async.Future<$1.BlockCertificates> getBlockCertificates_Pre($grpc.ServiceCall call, $async.Future<$1.BlockHashInput> request) async {
    return getBlockCertificates(call, await request);
  }

  $async.Stream<$1.WinningBaker> getWinningBakersEpoch_Pre($grpc.ServiceCall call, $async.Future<$1.EpochRequest> request) async* {
    yield* getWinningBakersEpoch(call, await request);
  }

  $async.Future<$1.BlockHash> getFirstBlockEpoch_Pre($grpc.ServiceCall call, $async.Future<$1.EpochRequest> request) async {
    return getFirstBlockEpoch(call, await request);
  }

  $async.Stream<$1.ArrivedBlockInfo> getBlocks($grpc.ServiceCall call, $1.Empty request);
  $async.Stream<$1.FinalizedBlockInfo> getFinalizedBlocks($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.AccountInfo> getAccountInfo($grpc.ServiceCall call, $1.AccountInfoRequest request);
  $async.Stream<$1.AccountAddress> getAccountList($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.ModuleRef> getModuleList($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.BlockHash> getAncestors($grpc.ServiceCall call, $1.AncestorsRequest request);
  $async.Future<$1.VersionedModuleSource> getModuleSource($grpc.ServiceCall call, $1.ModuleSourceRequest request);
  $async.Stream<$1.ContractAddress> getInstanceList($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.InstanceInfo> getInstanceInfo($grpc.ServiceCall call, $1.InstanceInfoRequest request);
  $async.Stream<$1.InstanceStateKVPair> getInstanceState($grpc.ServiceCall call, $1.InstanceInfoRequest request);
  $async.Future<$1.InstanceStateValueAtKey> instanceStateLookup($grpc.ServiceCall call, $1.InstanceStateLookupRequest request);
  $async.Future<$1.NextAccountSequenceNumber> getNextAccountSequenceNumber($grpc.ServiceCall call, $1.AccountAddress request);
  $async.Future<$1.ConsensusInfo> getConsensusInfo($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.BlockItemStatus> getBlockItemStatus($grpc.ServiceCall call, $1.TransactionHash request);
  $async.Future<$1.CryptographicParameters> getCryptographicParameters($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.BlockInfo> getBlockInfo($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.BakerId> getBakerList($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.PoolInfoResponse> getPoolInfo($grpc.ServiceCall call, $1.PoolInfoRequest request);
  $async.Future<$1.PassiveDelegationInfo> getPassiveDelegationInfo($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.BlocksAtHeightResponse> getBlocksAtHeight($grpc.ServiceCall call, $1.BlocksAtHeightRequest request);
  $async.Future<$1.TokenomicsInfo> getTokenomicsInfo($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.InvokeInstanceResponse> invokeInstance($grpc.ServiceCall call, $1.InvokeInstanceRequest request);
  $async.Stream<$1.DelegatorInfo> getPoolDelegators($grpc.ServiceCall call, $1.GetPoolDelegatorsRequest request);
  $async.Stream<$1.DelegatorRewardPeriodInfo> getPoolDelegatorsRewardPeriod($grpc.ServiceCall call, $1.GetPoolDelegatorsRequest request);
  $async.Stream<$1.DelegatorInfo> getPassiveDelegators($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.DelegatorRewardPeriodInfo> getPassiveDelegatorsRewardPeriod($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.Branch> getBranches($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.ElectionInfo> getElectionInfo($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.IpInfo> getIdentityProviders($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.ArInfo> getAnonymityRevokers($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.TransactionHash> getAccountNonFinalizedTransactions($grpc.ServiceCall call, $1.AccountAddress request);
  $async.Stream<$1.BlockItemSummary> getBlockTransactionEvents($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.BlockSpecialEvent> getBlockSpecialEvents($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.PendingUpdate> getBlockPendingUpdates($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.NextUpdateSequenceNumbers> getNextUpdateSequenceNumbers($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.Timestamp> getBakerEarliestWinTime($grpc.ServiceCall call, $1.BakerId request);
  $async.Future<$1.Empty> shutdown($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> peerConnect($grpc.ServiceCall call, $1.IpSocketAddress request);
  $async.Future<$1.Empty> peerDisconnect($grpc.ServiceCall call, $1.IpSocketAddress request);
  $async.Future<$1.BannedPeers> getBannedPeers($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.Empty> banPeer($grpc.ServiceCall call, $1.PeerToBan request);
  $async.Future<$1.Empty> unbanPeer($grpc.ServiceCall call, $1.BannedPeer request);
  $async.Future<$1.Empty> dumpStart($grpc.ServiceCall call, $1.DumpRequest request);
  $async.Future<$1.Empty> dumpStop($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.PeersInfo> getPeersInfo($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.NodeInfo> getNodeInfo($grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.TransactionHash> sendBlockItem($grpc.ServiceCall call, $1.SendBlockItemRequest request);
  $async.Future<$1.AccountTransactionSignHash> getAccountTransactionSignHash($grpc.ServiceCall call, $1.PreAccountTransaction request);
  $async.Future<$1.ChainParameters> getBlockChainParameters($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.BlockFinalizationSummary> getBlockFinalizationSummary($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.BlockItem> getBlockItems($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.BakerRewardPeriodInfo> getBakersRewardPeriod($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Future<$1.BlockCertificates> getBlockCertificates($grpc.ServiceCall call, $1.BlockHashInput request);
  $async.Stream<$1.WinningBaker> getWinningBakersEpoch($grpc.ServiceCall call, $1.EpochRequest request);
  $async.Future<$1.BlockHash> getFirstBlockEpoch($grpc.ServiceCall call, $1.EpochRequest request);
  $async.Stream<$1.DryRunResponse> dryRun($grpc.ServiceCall call, $async.Stream<$1.DryRunRequest> request);
}
