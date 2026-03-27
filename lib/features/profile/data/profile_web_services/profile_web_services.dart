import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/features/profile/data/models/post_model/post_model.dart';
import 'package:news_app/features/profile/data/models/profile_model.dart';

class ProfileWebServices {
  late Dio dio;
  ProfileWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: AppConstants.baseUrl,
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
  Future<dynamic> getProfile(String userId) async {
    try {
      final response = await dio.get('/profiles?id=eq.$userId');
      final data = response.data;
      final user = ProfileModel.fromJson(data[0]);
      return user;
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

  Future<dynamic> updateProfile({
    required String userId,
    required String? username,
    required String? fullName,
    required String? email,
    required String? phone,
    required String? bio,
    required String? website,
    required String? imageUrl,
    required String? country,
    required String? role,
  }) async {
    try {
      final Map<String, dynamic> requestBody = {
        'username': username,
        'full_name': fullName,
        'email': email,
        'phone': phone,
        'bio': bio,
        'website': website,
        'image_url': imageUrl,
        'country': country,
        'role': role,
      };
      final response = await dio.patch(
        '/profiles?id=eq.$userId',
        data: requestBody,
        options: Options(headers: {'Prefer': 'return=representation'}),
      );
      final data = response.data;
      final user = ProfileModel.fromJson(data[0]);
      return user;
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

  Future<dynamic> getUserPosts(String userId) async {
    try {
      final response = await dio.get(
        '/posts?user_id=eq.$userId&select=*,categories(*)',
      );
      final data = response.data;
      List<PostModel> posts = [];
      for (var post in data) {
        posts.add(PostModel.fromJson(post));
      }
      return posts;
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
            throw Exception('posts not found');
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

  Future<dynamic> getNewestUserPosts(String userId) async {
    try {
      final response = await dio.get(
        '/posts?user_id=eq.$userId&select=*,categories(name)&order=created_at.desc',
      );
      final data = response.data;
      List<PostModel> posts = [];
      for (var post in data) {
        posts.add(PostModel.fromJson(post));
      }
      return posts;
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
            throw Exception('posts not found');
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

  Future<dynamic> deletePost(int postId, String userId) async {
    try {
      final response = await dio.delete(
        '/posts?id=eq.$postId&user_id=eq.$userId',
      );
      if (response.statusCode == 204) {
        return;
      } else if (response.statusCode == 404) {
        throw Exception('Post not found or does not belong to this user');
      } else {
        throw Exception(
          'Failed to delete post. Status: ${response.statusCode}',
        );
      }
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
            throw Exception('post not found ${e.response}');
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
