import 'dart:developer';
import 'dart:io';

import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';

class NearHelperNetworkClient extends NetworkClient {
  NearHelperNetworkClient({required super.baseUrl, super.dio}) {
    super.dio.options.headers[HttpHeaders.accessControlAllowOriginHeader] = '*';
    super.dio.options.headers[HttpHeaders.accessControlAllowMethodsHeader] =
        'GET, POST, OPTIONS';
    super.dio.options.headers[HttpHeaders.accessControlAllowOriginHeader] =
        'Origin, Content-Type';
    super.dio.options.receiveTimeout = const Duration(seconds: 10);
    super.dio.interceptors.add(
          RetryInterceptor(
            dio: dio,
            logPrint: log,
            retries: 3,
            retryDelays: const [
              Duration(seconds: 5),
              Duration(seconds: 4),
              Duration(seconds: 3),
            ],
          ),
        );
  }
}
