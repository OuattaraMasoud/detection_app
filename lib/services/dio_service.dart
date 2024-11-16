import 'package:detectionApp/constants.dart';
import 'package:detectionApp/services/local_storage_service.dart';
import 'package:detectionApp/services/locator.dart';
import 'package:dio/dio.dart';

class DioService {
  late Dio _dio;
  DioService() {
    _dio = Dio(BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
        sendTimeout: Duration(milliseconds: 60000),
        headers: {
          "Authorization": "Token ${locator<LocalStorageService>().token}",
          // "Access-Control-Allow-Origin": "*",
          // "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
        }));
  }
  Dio get dio => _dio;
}
