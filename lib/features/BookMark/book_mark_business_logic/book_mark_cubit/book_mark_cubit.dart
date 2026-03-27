import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/storage/local_storage.dart';
import 'package:news_app/features/BookMark/data/repo/book_mark_repo.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';

part 'book_mark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit(this._repository) : super(BookmarkInitial());

  final BookmarkRepository _repository;

  Future<void> getBookmarks() async {
    emit(BookmarkLoading());
    try {
      final userId = await LocalStorage.getUserId();
      final bookmarks = await _repository.getBookmarks(userId);
      final followings = await _repository.getFollowingsUsersList(userId);
      emit(BookmarkLoaded(
        bookmarks: bookmarks,
        followingsUsersList: followings,
      ));
    } catch (e) {
      emit(BookmarkError(e.toString()));
    }
  }

  void search(String query) {
    final current = state;
    if (current is! BookmarkLoaded) return;
    final filtered = query.isEmpty
        ? current.bookmarks
        : current.bookmarks
        .where(
          (e) =>
      e.title.toLowerCase().contains(query.toLowerCase()) ||
          e.content.toLowerCase().contains(query.toLowerCase()),
    )
        .toList();
    emit(BookmarkLoaded(
      bookmarks: current.bookmarks,
      filtered: filtered,
      searchQuery: query,
      followingsUsersList: current.followingsUsersList,
    ));
  }

  void removeBookmark(int postId) {
    final current = state;
    if (current is! BookmarkLoaded) return;
    final bookmarks = current.bookmarks.where((e) => e.id != postId).toList();
    emit(BookmarkLoaded(
      bookmarks: bookmarks,
      followingsUsersList: current.followingsUsersList,
    ));
  }

  Future<void> refresh() => getBookmarks();
}
