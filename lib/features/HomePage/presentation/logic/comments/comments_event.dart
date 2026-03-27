import '../../../Data/models/comment_model.dart';

abstract class CommentsEvent {}

class CommentsWatchStarted extends CommentsEvent {
  final String postId;
  CommentsWatchStarted(this.postId);
}

class CommentsAdded extends CommentsEvent {
  final String postId;
  final String content;
  final String postOwnerId;
  final String newsTitle;

  CommentsAdded({
    required this.postId,
    required this.content,
    required this.postOwnerId,
    required this.newsTitle,
  });
}

class commentUpdate extends CommentsEvent {
  final List<Comment> comments;
  commentUpdate(this.comments);
}