import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';

class DioClient {
  static Dio get instance {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {
          'apiKey': AppConstants.apiKey,
        },
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    return dio;
  }
}