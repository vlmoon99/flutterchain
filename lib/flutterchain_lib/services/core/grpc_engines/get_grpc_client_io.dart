import 'package:grpc/grpc_connection_interface.dart';

ClientChannelBase getGrpcClient(
    {required String baseUrl, required int port, ChannelOptions? options}) {
  return ClientChannel(
    baseUrl.replaceFirstMapped("https://", (m) => ""),
    port: port,
    options: options ?? const ChannelOptions(),
  );
}
