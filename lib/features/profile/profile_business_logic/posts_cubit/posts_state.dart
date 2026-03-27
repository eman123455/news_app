part of 'posts_cubit.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

final class GetPostsSuccess extends PostsState {
  final List<PostModel> posts;

  const GetPostsSuccess({required this.posts});
}

final class GetPostsFailed extends PostsState {
  final String errMsg;

  const GetPostsFailed({required this.errMsg});
}

final class GetPostsLoading extends PostsState {}
