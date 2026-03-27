import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/models/comment_model.dart';
import '../../../Data/models/comment_subaBase.dart';
import 'comment_state.dart';
import 'comments_event.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository _repository;
  StreamSubscription<List<Comment>>? _commentsSubscription;

  CommentsBloc(this._repository) : super(CommentsInitial()) {
    on<CommentsWatchStarted>(_onWatchStarted);
    on<CommentsAdded>(_onCommentAdded);
    on<commentUpdate>(_onCommentsUpdated);
  }
  Future<void> _onWatchStarted(
      CommentsWatchStarted event,
      Emitter<CommentsState> emit,
      ) async {
    emit(CommentsLoading());

    await _commentsSubscription?.cancel();

    _commentsSubscription = _repository
        .watchComments(event.postId)
        .listen(
          (comments) => add(commentUpdate(comments)),
      onError: (e) => emit(CommentsError(e.toString())),
    );
  }
  void _onCommentsUpdated(
      commentUpdate event,
      Emitter<CommentsState> emit,
      ) {
    emit(CommentsSuccess(event.comments));
  }
  Future<void> _onCommentAdded(
      CommentsAdded event,
      Emitter<CommentsState> emit,
      ) async {
    final currentComments =
    state is CommentsSuccess ? (state as CommentsSuccess).comments : <Comment>[];

    emit(CommentSubmitting(currentComments));

    try {
      await _repository.addComment(
        postId: event.postId,
        content: event.content,
      );

    } catch (e) {
      emit(CommentsError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _commentsSubscription?.cancel();
    return super.close();
  }
}