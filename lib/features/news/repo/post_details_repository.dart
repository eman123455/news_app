// features/Explore/data/repo/post_details_repository.dart

import 'package:dio/dio.dart';
import 'package:news_app/features/Explore/data/model/comment_model.dart';
import 'package:news_app/features/Explore/network/dio_client.dart';

class PostDetailsRepository {
  PostDetailsRepository({DioClient? client})
    : _dio = (client ?? DioClient()).dio;

  final Dio _dio;

  // ── Check Follow ─────────────────────────────────────────
  // Future<bool> checkIsFollowing({
  //   required String followerId,
  //   required String followingId,
  // }) async {
  //   final response = await _dio.get(
  //     '/follows',
  //     queryParameters: {
  //       'select': '*',
  //       'follower_id': 'eq.$followerId',
  //       'following_id': 'eq.$followingId',
  //     },
  //   );
  //   final List data = response.data as List;
  //   return data.isNotEmpty;
  // }

  // ── Follow ───────────────────────────────────────────────
  Future<void> followUser({
    required String followerId,
    required String followingId,
  }) async {
    await _dio.post(
      '/follows',
      data: {'follower_id': followerId, 'following_id': followingId},
    );
  }

  // ── Unfollow ─────────────────────────────────────────────
  Future<void> unfollowUser({
    required String followerId,
    required String followingId,
  }) async {
    await _dio.delete(
      '/follows',
      queryParameters: {
        'follower_id': 'eq.$followerId',
        'following_id': 'eq.$followingId',
      },
    );
  }

  // ── Like ─────────────────────────────────────────────────
  Future<void> likePost({required int postId, required String userId}) async {
    await _dio.post('/likes', data: {'post_id': postId, 'user_id': userId});
  }

  // ── Unlike ───────────────────────────────────────────────
  Future<void> unlikePost({required int postId, required String userId}) async {
    await _dio.delete(
      '/likes',
      queryParameters: {'post_id': 'eq.$postId', 'user_id': 'eq.$userId'},
    );
  }
  Future<bool> checkIsBookmark({required String userId,required int postId}) async {
    final response = await _dio.get(
      '/bookmarks',
      queryParameters: {
        'select': '*',
        'user_id': 'eq.$userId',
      },
    );
    List bookmarks = response.data as List;

    print('test bookmark');
    print(postId);
    print(bookmarks);
    bool exists = bookmarks.any((item) => item['post_id'] == postId);
    print(exists);
    return exists;

    // return bookmarks.contains(postId);


    // final List data = response.data as List;
    // print('test test');
    // print(data.first);


  }



  Future<void> bookmarkPost({
    required int postId,
    required String userId,
  }) async {
    final response = await _dio.post(
      '/bookmarks',
      data: {'post_id': postId, 'user_id': userId},
    );

    final response2 = await _dio.get(
      '/bookmarks',

      queryParameters: {
        'select': '*,profile:profiles!user_id(*)',
        'user_id': 'eq.$userId',
        'order': 'created_at.desc',
      },
    );

    final List data = response2.data as List;
    print('test test');
    print(data.first);
    // return BookmarkModel.fromJson(data.first as Map<String, dynamic>);
  }
  Future<void> unbookmarkPost({
    required int postId,
    required String userId,
  }) async {
    await _dio.delete(
      '/bookmarks',
      queryParameters: {
        'post_id': 'eq.$postId',
        'user_id': 'eq.$userId',
      },
    );

  }

  // ── Add Comment / Reply ──────────────────────────────────
  Future<CommentModel> addComment({
    required int postId,
    required String userId,
    required String content,
    int? parentId,
  }) async {
    final response = await _dio.post(
      '/comments',
      data: {
        'post_id': postId,
        'user_id': userId,
        'content': content,
        if (parentId != null) 'parent_id': parentId,
      },
    );
    final response2 = await _dio.get(
      '/comments',

      queryParameters: {
        'select': '*,profile:profiles!user_id(*)',
        'post_id': 'eq.$postId',
        'order': 'created_at.desc',
      },
    );

    final List data = response2.data as List;
    print('test test');
    print(data.first);
    return CommentModel.fromJson(data.first as Map<String, dynamic>);
  }

  // ── Fetch Comments ───────────────────────────────────────
  Future<List<CommentModel>> fetchComments(int postId) async {
    final response = await _dio.get(
      '/comments',
      queryParameters: {
        'select': '*,profile:profiles!user_id(*)',
        'post_id': 'eq.$postId',
        'parent_id': 'is.null',
        'order': 'created_at.asc',
      },
    );
    final List data = response.data as List;
    return data
        .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
