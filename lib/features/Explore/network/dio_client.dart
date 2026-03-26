// core/network/dio_client.dart

import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';

class DioClient {
  DioClient._();
  static final DioClient _instance = DioClient._();
  factory DioClient() => _instance;

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.projectUrl,
      headers: {
        'apikey': AppConstants.anonKey,
        'Authorization': 'Bearer ${AppConstants.anonKey}',
        'Content-Type': 'application/json',
      },
    ),
  );
}