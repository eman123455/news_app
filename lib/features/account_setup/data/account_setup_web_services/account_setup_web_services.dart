import 'package:dio/dio.dart';
import 'package:news_app/features/Trending/api/dio_client.dart';
import 'package:news_app/features/account_setup/data/models/news_source_model.dart';

class AccountSetupWebServices {
  final Dio _dio;

  AccountSetupWebServices({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<List<NewsSourceModel>> fetchSources({String? country}) async {
    try {
      final response = await _dio.get(
        'sources',
        queryParameters: {
          if (country != null && country.isNotEmpty) 'country': country,
        },
      );
      final data = response.data;
      if (data is! Map<String, dynamic> || data['sources'] is! List) {
        return [];
      }
      final list = data['sources'] as List<dynamic>;
      return list
          .map((e) => NewsSourceModel.fromJson(e as Map<String, dynamic>))
          .where((s) => s.id.isNotEmpty && s.name.isNotEmpty)
          .toList();
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to load news sources');
    }
  }
}
