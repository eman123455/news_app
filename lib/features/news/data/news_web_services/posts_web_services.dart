import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';

class PostsWebServices {
  late Dio dio;
  PostsWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: AppConstants.supaBaseUrl,
      headers: {
        'apikey': AppConstants.anonKey,
        'Authorization': 'Bearer ${AppConstants.anonKey}',
      },
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
    );
    dio = Dio(baseOptions);
  }

  Future<dynamic> addPost({
    required String userId,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  }) async {
    try {
      final response = await dio.post(
        '/posts',
        data: {
          "user_id": userId,
          "title": title,
          "content": content,
          "image_url": imageUrl,
          "category_id": categoryId,
          "country": country,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            throw Exception('Bad request');
          case 401:
            throw Exception('Unauthorized');
          case 403:
            throw Exception('Forbidden');
          case 404:
            throw Exception('Profile not found');
          case 500:
            throw Exception('Server error');
          default:
            throw Exception('Something went wrong: $statusCode');
        }
      } else {
        if (e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('Network timeout. Check your internet connection.');
        } else {
          throw Exception('No internet connection or unknown network error');
        }
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<dynamic> updatePost({
    required int postId,
    required String userId,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  }) async {
    try {
      final response = await dio.patch(
        '/posts?id=eq.$postId',
        data: {
          "user_id": userId,
          "title": title,
          "content": content,
          "image_url": imageUrl,
          "category_id": categoryId,
          "country": country,
        },
        options: Options(headers: {"Prefer": "return=minimal"}),
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 400:
            throw Exception('Bad request');
          case 401:
            throw Exception('Unauthorized');
          case 403:
            throw Exception('Forbidden');
          case 404:
            throw Exception('Profile not found');
          case 500:
            throw Exception('Server error');
          default:
            throw Exception('Something went wrong: $statusCode');
        }
      } else {
        if (e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw Exception('Network timeout. Check your internet connection.');
        } else {
          throw Exception('No internet connection or unknown network error');
        }
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
