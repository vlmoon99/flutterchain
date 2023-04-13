import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(
      'Make ${options.method} request to route ${options.path} with data ${options.data}',
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
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      'Get error status code(${err.response?.statusCode})'
      'Response body (${err.response!.data.toString()})',
    );
    return super.onError(err, handler);
  }
}

class NetworkClient {
  final Dio dio;
  NetworkClient({
    required this.dio,
    required String baseUrl,
  }) {
    // dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 10000);
    dio.interceptors.add(LoggingInterceptor());
  }

  void setUrl(String newUrl) {
    dio.options.baseUrl = newUrl;
  }

  AppExceptions _handleError(DioError e) {
    final details = jsonDecode(e.response?.data)['detail'];
    final exception = AppExceptions(
        messageForUser: details,
        messageForDev: e.error.toString(),
        statusCode: e.response!.statusCode!);
    return exception;
  }

  Future<ApiResponse> getRequest(String url) async {
    AppExceptions? appExceptions;
    try {
      Response response = await dio.get(url);
      return ApiResponse.sucsess(response.data, response.statusCode!, true);
    } on DioError catch (e) {
      appExceptions = _handleError(e);
    }
    return ApiResponse.error(
        appExceptions.messageForDev, appExceptions.statusCode, false);
  }

  Future<ApiResponse> postHTTP(String url, dynamic data) async {
    AppExceptions? appExceptions;

    try {
      Response response = await dio.post(
        url,
        data: data,
      );
      return ApiResponse.sucsess(response.data, response.statusCode!, true);
    } on DioError catch (e) {
      appExceptions = _handleError(e);
    }
    return ApiResponse.error(
        appExceptions.messageForDev, appExceptions.statusCode, false);
  }

  Future<ApiResponse> putHTTP(String url, dynamic data) async {
    AppExceptions? appExceptions;

    try {
      Response response = await dio.put(url, data: data);
      return ApiResponse.sucsess(response.data, response.statusCode!, true);
    } on DioError catch (e) {
      appExceptions = _handleError(e);
    }
    return ApiResponse.error(
        appExceptions.messageForDev, appExceptions.statusCode, false);
  }

  Future<ApiResponse> deleteHTTP(String url, dynamic data) async {
    AppExceptions? appExceptions;

    try {
      Response response = await dio.delete(url, data: data);
      return ApiResponse.sucsess(response.data, response.statusCode!, true);
    } on DioError catch (e) {
      appExceptions = _handleError(e);
    }

    return ApiResponse.error(
        appExceptions.messageForDev, appExceptions.statusCode, false);
  }
}

class ApiResponse {
  ApiResponse.sucsess(this.data, this.statusCode, this.isSucsess);
  ApiResponse.error(this.data, this.statusCode, this.isSucsess);

  dynamic data;
  int statusCode;
  bool isSucsess;
}

class AppExceptions {
  String messageForUser;
  String messageForDev;
  int statusCode;
  AppExceptions(
      {required this.messageForUser,
      required this.messageForDev,
      required this.statusCode});

  @override
  String toString() => "messageForDev$messageForDev";
}
