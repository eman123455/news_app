import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/news/data/repo/news_repo_implementation.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  final repo = getIt.get<NewsRepoImplementation>();
  final userId = '062b90f8-49cd-4911-8d3a-265924aa0597';
  Future<void> addPost({
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  }) async {
    try {
      await repo.addPost(
        userId: userId,
        title: title,
        content: content,
        imageUrl: imageUrl,
        categoryId: categoryId,
        country: country,
      );
      emit(PostNewsSuccess());
    } catch (e) {
      emit(PostNewsFailed(errMsg: e.toString()));
    }
  }

  Future<void> updatePost({
    required int postId,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  }) async {
    try {
      await repo.updatePost(
        userId: userId,
        postId: postId,
        title: title,
        content: content,
        imageUrl: imageUrl,
        categoryId: categoryId,
        country: country,
      );
      emit(PostNewsSuccess());
    } catch (e) {
      emit(PostNewsFailed(errMsg: e.toString()));
    }
  }
}
