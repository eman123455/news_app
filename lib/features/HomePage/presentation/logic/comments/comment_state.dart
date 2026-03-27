import '../../../Data/models/comment_model.dart';

abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsSuccess extends CommentsState {
  final List<Comment> comments;
  CommentsSuccess(this.comments);
}

class CommentsError extends CommentsState {
  final String message;
  CommentsError(this.message);
}
class CommentSubmitting extends CommentsState {
  final List<Comment> comments;
  CommentSubmitting(this.comments);
}