// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../services/services.dart';

class ApiIntercetor {
  Dio dio = Dio();

  initApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: locator<LocalStorageService>().apiBaseUrl,
        responseType: ResponseType.plain,
        connectTimeout: const Duration(milliseconds: 60000),
        receiveTimeout: const Duration(milliseconds: 60000),
        contentType: 'application/json',
      ),
    );
    initialApiInterceptor();
  }

  initialApiInterceptor() {
    // GlobalKey<NavigatorState>? navigator;
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          RequestOptions? origin = error.response?.requestOptions;
          if (origin != null && error.response?.statusCode == 401) {
            // Call refresh token endpoint
            var shoppyAuthData =
                locator<LocalStorageService>().shoppyUserAuthData;
            var savedToken =
                shoppyAuthData != null ? jsonDecode(shoppyAuthData) : null;
            if (savedToken != null) {
              try {
                Response<dynamic> response = await dio.post(
                    "${locator<LocalStorageService>().apiBaseUrl}auth/refresh-token",
                    data: {'refreshToken': savedToken["refresh_token"]});
                locator<LocalStorageService>().shoppyAuthData = response.data;
                var token =
                    response.data != null ? jsonDecode(response.data) : null;
                origin.headers["Authorization"] =
                    'Bearer ${token['access_token']}';
                final options = Options(
                  method: origin.method,
                  headers: origin.headers,
                );
                var retryResponse =
                    await dio.request(origin.path, options: options);
                return handler.resolve(retryResponse);
              } on DioException catch (err) {
                // The refresh token does not exist on server side
                if (err.response?.statusCode == 404) {
                  await locator<LocalStorageService>().logOut();
                  NotificationService.notify(
                    'Vous devez vous connecter pour pouvoir continuer.',
                    textStyle: const TextStyle(color: Colors.red),
                  );
                }
              }
            }
          } else if (error.response?.statusCode == 500) {
            NotificationService.notify(
              error.response?.statusMessage ?? error.message ?? "",
              textStyle: const TextStyle(color: Colors.red),
            );
          }
          return handler.next(error);
        },
        onRequest: (request, handler) {
          if (!request.path.contains('auth/')) {
            var shoppyAuthData =
                locator<LocalStorageService>().shoppyUserAuthData;
            var token =
                shoppyAuthData != null ? jsonDecode(shoppyAuthData) : null;
            if (token != null) {
              request.headers['Authorization'] =
                  "Bearer ${token['access_token']}";
            }
          }
          return handler.next(request);
        },
        onResponse: (response, handler) {
          if (response.realUri.toString().contains('auth/login')) {
            if (response.statusCode == 200 || response.statusCode == 201) {
              locator<LocalStorageService>().shoppyAuthData = response.data;
            }
          }
          handler.next(response);
        },
      ),
    );
  }
}
