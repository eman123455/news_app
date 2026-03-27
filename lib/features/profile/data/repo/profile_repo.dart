abstract class ProfileRepo {
  Future<dynamic> getProfile(String userId);
  Future<dynamic> updateProfile({
    required String userId,
    String? username,
    String? fullName,
    String? email,
    String? phone,
    String? bio,
    String? website,
    String? imageUrl,
    String? country,
    String? role,
  });
  Future<dynamic> getUserPosts(String userId);
  Future<dynamic> getNewestUserPosts(String userId);
  Future<dynamic> deletePost(int postId, String userId);
}
