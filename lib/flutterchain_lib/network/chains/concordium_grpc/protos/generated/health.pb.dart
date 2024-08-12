//
//  Generated code. Do not modify.
//  source: lib/flutterchain_lib/network/chains/concordium_grpc/protos/health.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Parameters to the node health query. The default message gives a good
/// default.
class NodeHealthRequest extends $pb.GeneratedMessage {
  factory NodeHealthRequest() => create();
  NodeHealthRequest._() : super();
  factory NodeHealthRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeHealthRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeHealthRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'concordium.health'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeHealthRequest clone() => NodeHealthRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeHealthRequest copyWith(void Function(NodeHealthRequest) updates) => super.copyWith((message) => updates(message as NodeHealthRequest)) as NodeHealthRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeHealthRequest create() => NodeHealthRequest._();
  NodeHealthRequest createEmptyInstance() => create();
  static $pb.PbList<NodeHealthRequest> createRepeated() => $pb.PbList<NodeHealthRequest>();
  @$core.pragma('dart2js:noInline')
  static NodeHealthRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeHealthRequest>(create);
  static NodeHealthRequest? _defaultInstance;
}

/// Response to the health check. A return code of "OK" is used for success, and
/// errors are handled via RPC status codes
class NodeHealthResponse extends $pb.GeneratedMessage {
  factory NodeHealthResponse() => create();
  NodeHealthResponse._() : super();
  factory NodeHealthResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeHealthResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeHealthResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'concordium.health'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeHealthResponse clone() => NodeHealthResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeHealthResponse copyWith(void Function(NodeHealthResponse) updates) => super.copyWith((message) => updates(message as NodeHealthResponse)) as NodeHealthResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeHealthResponse create() => NodeHealthResponse._();
  NodeHealthResponse createEmptyInstance() => create();
  static $pb.PbList<NodeHealthResponse> createRepeated() => $pb.PbList<NodeHealthResponse>();
  @$core.pragma('dart2js:noInline')
  static NodeHealthResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeHealthResponse>(create);
  static NodeHealthResponse? _defaultInstance;
}


const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
