import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../services/services.dart';

class DioClient {
  static BaseOptions options = BaseOptions(
    baseUrl: locator<LocalStorageService>().apiBaseUrl,
    headers: {
      'Content-Type': 'application/json',
    },
  );

  Dio dio = Dio(options);
}

class CustomInterceptors extends Interceptor {
  var instance = Dio();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    }
    super.onResponse(response, handler);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
          'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    }
    return super.onError(err, handler);
  }
}

void initializeDioClient() {
  Dio dioClient = Dio(
    BaseOptions(
      baseUrl: locator<LocalStorageService>().apiBaseUrl,
      responseType: ResponseType.plain,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      contentType: 'application/json',
    ),
  );

  dioClient.interceptors.add(InterceptorsWrapper(
    onRequest: (request, handler) {
      String? token = locator<LocalStorageService>().shoppyUserAuthData;
      request.headers['Authorization'] = "Bearer $token";
      return handler.next(request);
    },
  ));
}
