part of 'post_details_cubit.dart';

sealed class PostDetailsState {}

final class PostDetailsInitial extends PostDetailsState {}
class PostDetailsLoading extends PostDetailsState {}

class PostDetailsLoaded extends PostDetailsState {
  final bool isLiked;
  final int likesCount;
  final bool isFollowing;
  final List<CommentModel> comments;
  final int? replyingToCommentId;
  final String? replyingToName;
  final Set<int> expandedComments;

  PostDetailsLoaded({
    required this.isLiked,
    required this.likesCount,
    required this.isFollowing,
    required this.comments,
    this.replyingToCommentId,
    this.replyingToName,
    this.expandedComments = const {},
  });

  PostDetailsLoaded copyWith({
    bool? isLiked,
    int? likesCount,
    bool? isFollowing,
    List<CommentModel>? comments,
    int? replyingToCommentId,
    String? replyingToName,
    bool clearReply = false,
    Set<int>? expandedComments,
  }) {
    return PostDetailsLoaded(
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
      isFollowing: isFollowing ?? this.isFollowing,
      comments: comments ?? this.comments,
      replyingToCommentId: clearReply ? null : replyingToCommentId ?? this.replyingToCommentId,
      replyingToName: clearReply ? null : replyingToName ?? this.replyingToName,
      expandedComments: expandedComments ?? this.expandedComments,
    );
  }
}

class PostDetailsError extends PostDetailsState {
  final String message;
  PostDetailsError(this.message);
}
