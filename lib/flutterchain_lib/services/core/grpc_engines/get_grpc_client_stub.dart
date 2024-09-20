import 'package:grpc/grpc_connection_interface.dart';

ClientChannelBase getGrpcClient(
    {required String baseUrl, required int port, ChannelOptions? options}) {
  throw UnsupportedError('Grpc client is not supported');
}
