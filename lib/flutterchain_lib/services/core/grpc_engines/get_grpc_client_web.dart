import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';

ClientChannelBase getGrpcClient(
    {required String baseUrl, required int port, ChannelOptions? options}) {
  return GrpcWebClientChannel.xhr(Uri.parse("$baseUrl:$port"));
}
