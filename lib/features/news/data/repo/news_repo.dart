abstract class NewsRepo {
  Future<dynamic> addPost({
    required String userId,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  });
  Future<dynamic> updatePost({
    required int postId,
    required String userId,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
    required String country,
  });
}
