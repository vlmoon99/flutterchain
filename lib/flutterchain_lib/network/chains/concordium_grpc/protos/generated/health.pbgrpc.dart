//
//  Generated code. Do not modify.
//  source: lib/flutterchain_lib/network/chains/concordium_grpc/protos/health.proto
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

import 'health.pb.dart' as $0;

export 'health.pb.dart';

@$pb.GrpcServiceName('concordium.health.Health')
class HealthClient extends $grpc.Client {
  static final _$check = $grpc.ClientMethod<$0.NodeHealthRequest, $0.NodeHealthResponse>(
      '/concordium.health.Health/Check',
      ($0.NodeHealthRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.NodeHealthResponse.fromBuffer(value));

  HealthClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.NodeHealthResponse> check($0.NodeHealthRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$check, request, options: options);
  }
}

@$pb.GrpcServiceName('concordium.health.Health')
abstract class HealthServiceBase extends $grpc.Service {
  $core.String get $name => 'concordium.health.Health';

  HealthServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.NodeHealthRequest, $0.NodeHealthResponse>(
        'Check',
        check_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.NodeHealthRequest.fromBuffer(value),
        ($0.NodeHealthResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.NodeHealthResponse> check_Pre($grpc.ServiceCall call, $async.Future<$0.NodeHealthRequest> request) async {
    return check(call, await request);
  }

  $async.Future<$0.NodeHealthResponse> check($grpc.ServiceCall call, $0.NodeHealthRequest request);
}
