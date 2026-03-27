import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/profile/data/models/post_model/post_model.dart';
import 'package:news_app/features/profile/data/repo/profile_repo_implementation.dart';
import 'package:news_app/core/storage/local_storage.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
  final repo = getIt.get<ProfileRepoImplementation>();
  Future<String> get _userId async => await LocalStorage.getUserId();
  Future<void> getUserPosts() async {
    emit(GetPostsLoading());
    try {
      final userId = '062b90f8-49cd-4911-8d3a-265924aa0597';
      final List<PostModel> posts = await repo.getUserPosts('062b90f8-49cd-4911-8d3a-265924aa0597');
      emit(GetPostsSuccess(posts: posts));
    } catch (e) {
      emit(GetPostsFailed(errMsg: e.toString()));
    }
  }

  Future<void> getNewestUserPosts() async {
    emit(GetPostsLoading());
    try {
      final userId = await _userId;
      final List<PostModel> posts = await repo.getNewestUserPosts(userId);
      emit(GetPostsSuccess(posts: posts));
    } catch (e) {
      emit(GetPostsFailed(errMsg: e.toString()));
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final userId = await _userId;
      await repo.deletePost(postId, userId);
      await getNewestUserPosts();
      await getUserPosts();
    } catch (e) {
      emit(GetPostsFailed(errMsg: e.toString()));
    }
  }
}
