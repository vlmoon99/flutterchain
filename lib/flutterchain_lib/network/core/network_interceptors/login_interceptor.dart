import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      'Make ${options.method} request to route ${options.baseUrl + options.path} with data ${options.data}',
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'Get response status code(${response.statusCode})'
      'Response body (${response.data.toString()})',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(
      'Get error status code(${err.response?.statusCode})'
      'Response body (${err.response?.data.toString()})',
    );
    return super.onError(err, handler);
  }
}
