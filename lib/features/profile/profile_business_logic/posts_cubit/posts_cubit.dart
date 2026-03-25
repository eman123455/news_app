import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/profile/data/models/post_model/post_model.dart';
import 'package:news_app/features/profile/data/repo/profile_repo_implementation.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
  final repo = getIt.get<ProfileRepoImplementation>();
  final userId = '062b90f8-49cd-4911-8d3a-265924aa0597';
  Future<void> getUserPosts() async {
    emit(GetPostsLoading());
    try {
      final List<PostModel> posts = await repo.getUserPosts(userId);
      emit(GetPostsSuccess(posts: posts));
    } catch (e) {
      emit(GetPostsFailed(errMsg: e.toString()));
    }
  }

  Future<void> getNewestUserPosts() async {
    emit(GetPostsLoading());
    try {
      final List<PostModel> posts = await repo.getNewestUserPosts(userId);
      emit(GetPostsSuccess(posts: posts));
    } catch (e) {
      emit(GetPostsFailed(errMsg: e.toString()));
    }
  }

  Future<void> deletePost(int postId,) async {
    try {
      await repo.deletePost(postId, userId);
      await getNewestUserPosts();
      await getUserPosts();
    } catch (e) {
      emit(GetPostsFailed(errMsg: e.toString()));
    }
  }
}
