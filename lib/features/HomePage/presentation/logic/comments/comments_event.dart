import '../../../Data/models/comment_model.dart';

abstract class CommentsEvent {}
class CommentsWatchStarted extends CommentsEvent {
  final String postId;
  CommentsWatchStarted(this.postId);
}

class CommentsAdded extends CommentsEvent {
  final String postId;
  final String content;
  CommentsAdded({required this.postId, required this.content});
}

class commentUpdate extends CommentsEvent {
  final List<Comment> comments;
  commentUpdate(this.comments);
}