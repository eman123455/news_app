import 'package:news_app/features/news/data/news_web_services/posts_web_services.dart';
import 'package:news_app/features/news/data/repo/news_repo.dart';

class NewsRepoImplementation implements NewsRepo {
  late PostsWebServices postsWebServices;
  NewsRepoImplementation(this.postsWebServices);
  @override
  Future<dynamic> addPost({
    required String userId,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  }) async {
    final response = await postsWebServices.addPost(
      userId: userId,
      title: title,
      content: content,
      imageUrl: imageUrl,
      categoryId: categoryId,
      country: country,
    );
    return response;
  }

  @override
  Future<dynamic> updatePost({
    required int postId,
    required String userId,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  }) async {
    final response = await postsWebServices.updatePost(
      userId: userId,
      postId: postId,
      title: title,
      content: content,
      imageUrl: imageUrl,
      categoryId: categoryId,
      country: country,
    );
    return response;
  }
}
