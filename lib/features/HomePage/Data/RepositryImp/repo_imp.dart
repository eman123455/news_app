import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/features/HomePage/Domain/Entity/article_entity.dart';
import '../../../../core/resources/app_constants.dart';
import 'package:news_app/features/HomePage/Data/models/news_model.dart';
import '../../Domain/Repo/repo.dart';
import '../mapper/articles_mappers.dart';

class RepoImpl extends Repository {
  @override
  Future<List<ArticleEntity>> getTopHeadLineNews({String? country, String? category}) async {
    String url =
        '${AppConstants.baseUrl}/latest?apikey=${AppConstants.apiKey}&country=${country ?? 'eg'}';
    if (category != null) {
      url += '&category=$category';
    }

    final response = await http.get(Uri.parse(url));
    print('📡 Status: ${response.statusCode}');
    print('📦 Body: ${response.body}');
    print('🔗 URL: $url');

    if (response.statusCode == 200) {
      final NewsModel newsModel = NewsModel.fromJson(jsonDecode(response.body));
      print('📰 Results count: ${newsModel.results?.length}');
      return newsModel.results?.map((a) => a.toEntity()).toList() ?? [];
    } else {
      throw Exception('Failed to load news ${response.statusCode}');
    }
  }
}