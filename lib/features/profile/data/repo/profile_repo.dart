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
  Future<dynamic> getFollowersCount(String userId);
  Future<dynamic> getFollowingCount(String userId);
  Future<dynamic> getUserPostCount(String userId);
  Future<dynamic> addProfile({
    required String userId,
    required String? username,
    required String? fullName,
    required String? email,
    required String? phone,
    required String? bio,
    required String? website,
    required String? imageUrl,
    required String? country,
    required String? role,
  });
}
