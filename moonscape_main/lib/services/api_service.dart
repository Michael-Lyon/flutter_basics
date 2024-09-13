import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiService {
  final String baseUrl = "https://abpharmaceutical.com";
  // final String baseUrl = "https://novels-changelog-asbestos-myself.trycloudflare.com";
  // final String baseUrl = "https://michaellyon.pythonanywhere.com";
  final Logger logger = Logger();
  final Dio dio = Dio();

  Future<Map<String, dynamic>?> uploadImage(
      String imagePath, String imageName) async {
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imagePath, filename: imageName),
    });

    try {
      final response = await dio.post(
        '$baseUrl/upload/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          validateStatus: (status) {
            return status != null && status < 5000;
          },
        ),
      );

      if (response.statusCode == 202) {
        logger.d('Image uploaded successfully: ${response.data}');
        return response.data;
      } else if (response.statusCode == 429) {
        logger.d('Rate limit exceeded: ${response.statusCode}');
        return {'error': 'Rate limit exceeded. Please try again later.'};
      } else {
        logger.d('Failed to upload image: ${response.statusCode}');
        return {'error': 'Failed to upload image.'};
      }
    } catch (e, stacktrace) {
      logger.e('Error uploading image: $e: $stacktrace');
      return {'error': 'Error uploading image.'};
    }
  }

  Future<Map<String, dynamic>?> checkStatus(String taskId) async {
    try {
      final response = await dio.get(
        '$baseUrl/status/$taskId/',
        options: Options(
          validateStatus: (status) {
            return status != null && status < 600;
          },
        ),
      );
      logger.e('RESPONSE checking status: $response');

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 202) {
        return {'status': 'processing'};
      } else if (response.statusCode == 404) {
        return {'error': 'Model not found. Please try again later.'};
      } else {
        return {'error': 'Failed to fetch model data. Please try again later.'};
      }
    } catch (e) {
      logger.e('Error checking status: $e');
      return {'error': 'Error checking status. Please try again later.'};
    }
  }
}
