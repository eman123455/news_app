import 'package:dio/dio.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/Explore/data/repo/explore_repo.dart';
import 'package:news_app/features/Explore/network/dio_client.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl({DioClient? client})
    : _dio = (client ?? DioClient()).dio;

  final Dio _dio;

  @override
  Future<List<ExploreModel>> getAllExploresNews() async {
    try {
      // final response = await _dio.get(
      //   '/posts',
      //   queryParameters: {
      //     'select': '*',
      //     'order': 'created_at.desc',
      //   },
      // );
      final response = await _dio.get(
        '/posts',
        queryParameters: {
          'select':
              '*,profile:profiles!user_id(*),likes(*),comments(*,profile:profiles!user_id(*))',
          'order': 'created_at.desc',
        },
      );

      final List data = response.data as List;
      // print('----------');
      // // print(response);
      // print(response.data);
      // print('----------');
      return ExploreModel.fromJsonList(data);
    } on DioException catch (e) {
      throw _mapDioError(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ExploreModel>> getFollowingsExplores(
    List<dynamic> followingsUsersList,
  ) async {
    final response = await _dio.get(
      '/posts',
      queryParameters: {
        'select':
            '*,profile:profiles!user_id(*),likes(*),comments(*,profile:profiles!user_id(*))',
        'user_id':
            'in.(${followingsUsersList.map((e) => e['following_id']).join(',')})',
        'order': 'created_at.desc',
      },
    );
    final List data = response.data as List;
    return data.map((e) => ExploreModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<dynamic>> getFollowingsUsersList() async {
    final userId = '062b90f8-49cd-4911-8d3a-265924aa0597';
    print('getFollowings');
    final response = await _dio.get(
      '/follows',
      queryParameters: {
        // 'select': 'following:following_id(follower_id)',
        'select': 'following_id',
        'follower_id': 'eq.$userId',
        'order': 'created_at.desc',
      },
    );
    print(response.data);
    return response.data;
  }

  Exception _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Request timed out.');
      case DioExceptionType.connectionError:
        return Exception('No internet connection.');
      case DioExceptionType.badResponse:
        return Exception('Server error ${e.response?.statusCode}');
      default:
        return Exception(e.message ?? 'Something went wrong.');
    }
  }
}
