import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/features/Trending/api/dio_client.dart';

class TrendingRepo {
  final Dio _dio = DioClient.instance;
  Future<List<dynamic>> getTrending() async {
    try {
      final response = await _dio.get(
        AppConstants.newsApiTrendingEndPoint,
        queryParameters: {
          'country': 'us',
          // 'sources': 'bbc-news',
          'pageSize': 10,
        },
      );
      return response.data['articles'];
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}