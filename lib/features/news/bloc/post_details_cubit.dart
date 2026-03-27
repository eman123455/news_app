import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/storage/local_storage.dart';
import 'package:news_app/features/Explore/data/model/comment_model.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/news/repo/post_details_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit(this._repository) : super(PostDetailsInitial());

  final PostDetailsRepository _repository;
  late ExploreModel _post;
  late String _currentUserId;

  late bool isBookmarked;


  Future<void> init({
    required ExploreModel post,
    required List<dynamic> followingsUsersList,
  }) async {
    _post = post;
    emit(PostDetailsLoading());
    try {
      _currentUserId = await LocalStorage.getUserId();
      isBookmarked = await _repository.checkIsBookmark(
        userId: _currentUserId,
        postId: _post.id!,
      );
      final isLiked = post.likes.any((l) => l.userId == _currentUserId);

      final isFollowing = followingsUsersList.any(
        (f) => f['following_id'] == post.userId,
      );

      emit(
        PostDetailsLoaded(
          isLiked: isLiked,
          likesCount: post.likes.length,
          isFollowing: isFollowing,
          isBookmarked: isBookmarked,
          comments: post.comments.where((c) => c.parentId == null).toList(),
        ),
      );
    } catch (e) {
      emit(PostDetailsError(e.toString()));
    }
  }

  Future<void> toggleLike() async {
    final current = state;
    if (current is! PostDetailsLoaded) return;

    final wasLiked = current.isLiked;


    emit(
      current.copyWith(
        isLiked: !wasLiked,
        likesCount: wasLiked ? current.likesCount - 1 : current.likesCount + 1,
      ),
    );

    try {
      if (wasLiked) {
        await _repository.unlikePost(postId: _post.id!, userId: _currentUserId);
      } else {
        await _repository.likePost(postId: _post.id!, userId: _currentUserId);
      }
    } catch (e) {
      // Rollback on error
      emit(current);
    }
  }


  Future<void> toggleFollow() async {
    final current = state;
    if (current is! PostDetailsLoaded) return;

    final wasFollowing = current.isFollowing;


    emit(current.copyWith(isFollowing: !wasFollowing));

    try {
      if (wasFollowing) {
        await _repository.unfollowUser(
          followerId: _currentUserId,
          followingId: _post.userId,
        );
      } else {
        await _repository.followUser(
          followerId: _currentUserId,
          followingId: _post.userId,
        );
      }
    } catch (e) {
      // Rollback on error
      emit(current);
    }
  }


  Future<void> toggleBookmark() async {
    final current = state;
    if (current is! PostDetailsLoaded) return;
    final wasBookmarked = current.isBookmarked;
    emit(current.copyWith(isBookmarked: !wasBookmarked));

    try {
      if (wasBookmarked) {
        await _repository.unbookmarkPost(
          postId: _post.id!,
          userId: _currentUserId,
        );
      } else {
        await _repository.bookmarkPost(
          postId: _post.id!,
          userId: _currentUserId,
        );
      }
    } catch (e) {

      emit(current);
    }
  }


  Future<void> addComment(String content) async {
    final current = state;
    if (current is! PostDetailsLoaded) return;
    if (content.trim().isEmpty) return;

    try {
      final newComment = await _repository.addComment(
        postId: _post.id!,
        userId: _currentUserId,
        content: content,
      );

      emit(current.copyWith(comments: [...current.comments, newComment]));
    } catch (e) {
      emit(PostDetailsError(e.toString()));
    }
  }


  Future<void> addReply({
    required int parentCommentId,
    required String content,
  }) async {
    final current = state;
    if (current is! PostDetailsLoaded) return;
    if (content.trim().isEmpty) return;

    try {
      final reply = await _repository.addComment(
        postId: _post.id!,
        userId: _currentUserId,
        content: content,
        parentId: parentCommentId,
      );

      final updatedComments = current.comments.map((c) {
        if (c.id == parentCommentId) {
          return c.copyWith(replies: [...c.replies, reply]);
        }
        return c;
      }).toList();

      emit(current.copyWith(comments: updatedComments));
    } catch (e) {
      emit(PostDetailsError(e.toString()));
    }
  }

  void setReply(int commentId, String name) {
    final current = state;
    if (current is! PostDetailsLoaded) return;
    emit(
      current.copyWith(replyingToCommentId: commentId, replyingToName: name),
    );
  }

  void clearReply() {
    final current = state;
    if (current is! PostDetailsLoaded) return;
    emit(current.copyWith(clearReply: true));
  }

  void toggleExpandComment(int commentId) {
    final current = state;
    if (current is! PostDetailsLoaded) return;
    final expanded = Set<int>.from(current.expandedComments);
    if (expanded.contains(commentId)) {
      expanded.remove(commentId);
    } else {
      expanded.add(commentId);
    }
    emit(current.copyWith(expandedComments: expanded));
  }
}
