part of 'news_cubit.dart';

@immutable
sealed class NewsState {}

final class NewsInitial extends NewsState {}

final class PostNewsSuccess extends NewsState {}

final class PostNewsFailed extends NewsState {
  final String errMsg;

  PostNewsFailed({required this.errMsg});
}

final class PostNewsLoading extends NewsState {}
