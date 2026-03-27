
import 'package:dio/dio.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/Explore/network/dio_client.dart';

class BookmarkRepository {
  BookmarkRepository({DioClient? client})
      : _dio = (client ?? DioClient()).dio;

  final Dio _dio;

  Future<List<ExploreModel>> getBookmarks(String userId) async {
    final response = await _dio.get(
      '/bookmarks',
      queryParameters: {
        'select':
        '*,post:posts!post_id(*,profile:profiles!user_id(*),likes(*),comments(*,profile:profiles!user_id(*),replies:comments!parent_id(*,profile:profiles!user_id(*))),category:categories!category_id(*))',
        'user_id': 'eq.$userId',
        'order': 'created_at.desc',
      },
    );

    final List data = response.data as List;
    return data
        .map((e) => ExploreModel.fromJson(e['post'] as Map<String, dynamic>))
        .toList();
  }
  Future<List<dynamic>> getFollowingsUsersList(String userId) async {
    final response = await _dio.get(
      '/follows',
      queryParameters: {
        'select': '*',
        'follower_id': 'eq.$userId',
      },
    );
    return response.data as List;
  }
}