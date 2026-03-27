import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/features/news/data/models/category_model.dart';

class CategoryWebServices {
  late Dio dio;
  CategoryWebServices() {
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
  Future<dynamic> getSavedCategories(String userId) async {
    try {
      final response = await dio.get('/categories');
      final data = response.data;
      List<CategoryModel> categories = [];
      for (var item in data) {
        final cat = item;
        categories.add(CategoryModel.fromJson(cat));
      }
      return categories;
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
