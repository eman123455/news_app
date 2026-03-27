part of 'book_mark_cubit.dart';

sealed class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkLoaded extends BookmarkState {
  final List<ExploreModel> bookmarks;
  final List<ExploreModel> filtered;
  final String searchQuery;
  final List<dynamic> followingsUsersList;

  BookmarkLoaded({
    required this.bookmarks,
    required this.followingsUsersList,
    List<ExploreModel>? filtered,
    this.searchQuery = '',
  }) : filtered = filtered ?? bookmarks;
}

class BookmarkError extends BookmarkState {
  final String message;
  BookmarkError(this.message);
}