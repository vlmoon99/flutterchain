import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_interceptors/loggin_intereptor.dart';

class NetworkClient {
  final Dio dio;
  NetworkClient({
    required this.dio,
    required String baseUrl,
  }) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 5000);
    dio.interceptors.add(LoggingInterceptor());
  }

  void setUrl(String newUrl) {
    dio.options.baseUrl = newUrl;
  }

  AppExceptions _handleError(DioException e) {
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
      return ApiResponse.success(response.data, response.statusCode!, true);
    } on DioException catch (e) {
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
      return ApiResponse.success(response.data, response.statusCode!, true);
    } on DioException catch (e) {
      appExceptions = _handleError(e);
    }
    return ApiResponse.error(
        appExceptions.messageForDev, appExceptions.statusCode, false);
  }

  Future<ApiResponse> putHTTP(String url, dynamic data) async {
    AppExceptions? appExceptions;

    try {
      Response response = await dio.put(url, data: data);
      return ApiResponse.success(response.data, response.statusCode!, true);
    } on DioException catch (e) {
      appExceptions = _handleError(e);
    }
    return ApiResponse.error(
        appExceptions.messageForDev, appExceptions.statusCode, false);
  }

  Future<ApiResponse> deleteHTTP(String url, dynamic data) async {
    AppExceptions? appExceptions;

    try {
      Response response = await dio.delete(url, data: data);
      return ApiResponse.success(response.data, response.statusCode!, true);
    } on DioException catch (e) {
      appExceptions = _handleError(e);
    }

    return ApiResponse.error(
        appExceptions.messageForDev, appExceptions.statusCode, false);
  }
}

class ApiResponse {
  ApiResponse.success(this.data, this.statusCode, this.isSuccess);
  ApiResponse.error(this.data, this.statusCode, this.isSuccess);

  dynamic data;
  int statusCode;
  bool isSuccess;
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
