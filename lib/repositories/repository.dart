import 'dart:typed_data';
import 'dart:html' as html;
import 'package:detectionApp/constants.dart';
import 'package:detectionApp/global_app/cubit/global_app_cubit.dart';
import 'package:detectionApp/services/dio_service.dart';
import 'package:detectionApp/services/locator.dart';
import 'package:dio/dio.dart';

class DetectionRepository {
  final DioService _dioService;
  DetectionRepository(this._dioService);

  Future<Uint8List> _readImageBytes(String path) async {
    final html.HttpRequest response = await html.HttpRequest.request(
      path,
      responseType: 'arraybuffer',
    );
    final ByteBuffer buffer = response.response as ByteBuffer;
    return Uint8List.view(buffer);
  }

  Future<Map<String, dynamic>?> submitImage(
      String filePath, String fileName) async {
    try {
      Uint8List imageBytes = await _readImageBytes(filePath);
      FormData formData = FormData.fromMap({
        "image": MultipartFile.fromBytes(imageBytes, filename: fileName),
      });

      Response response =
          await _dioService.dio.post("detection/submit/", data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> result = Map<String, dynamic>.from(response.data);
        return result;
      } else {
        print(
            'Erreur lors de l\'envoie de l\'image: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de l\'envoie de l\'image: $e');
      locator<GlobalAppCubit>().stopLoading();

      return null;
    } finally {
      locator<GlobalAppCubit>().stopLoading();
    }
  }

  Future<Map<String, dynamic>?> downLoadImage(int id) async {
    try {
      Response imageResponse =
          await _dioService.dio.get("detection/results/$id/");
      if (imageResponse.statusCode == 200 || imageResponse.statusCode == 201) {
        Map<String, dynamic> imageResponseToReturn =
            Map<String, dynamic>.from(imageResponse.data);

        return imageResponseToReturn;
      } else {
        print(
            'Erreur lors de la recuperation de l\'image: ${imageResponse.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la recuperation de l\'image: ${e}');
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(Map<String, dynamic> data) async {
    try {
      Response response = await Dio(BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
        sendTimeout: Duration(milliseconds: 60000),
      )).post("users/login/", data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Map<String, dynamic>.from(response.data);
      } else {
        print('Erreur lors de la connexion: ${response.statusMessage}');
        return null;
      }
    } catch (e) {}
    return {};
  }
}
