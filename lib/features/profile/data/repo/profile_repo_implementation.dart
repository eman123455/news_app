import 'package:news_app/features/profile/data/profile_web_services/profile_web_services.dart';
import 'package:news_app/features/profile/data/repo/profile_repo.dart';

class ProfileRepoImplementation implements ProfileRepo {
  final ProfileWebServices profileWebServices;

  ProfileRepoImplementation(this.profileWebServices);

  @override
  Future<dynamic> getProfile(String userId) async {
    final response = await profileWebServices.getProfile(userId);
    return response;
  }

  @override
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
  }) async {
    final response = await profileWebServices.updateProfile(
      userId: userId,
      username: username,
      fullName: fullName,
      email: email,
      phone: phone,
      bio: bio,
      website: website,
      imageUrl: imageUrl,
      country: country,
      role: role,
    );
    return response;
  }
  @override
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
  })async {
    final response = await profileWebServices.addProfile(
      userId: userId,
      username: username,
      fullName: fullName,
      email: email,
      phone: phone,
      bio: bio,
      website: website,
      imageUrl: imageUrl,
      country: country,
      role: role,
    );
    return response;
  }

  @override
  Future<dynamic> getUserPosts(String userId) async {
    final response = await profileWebServices.getUserPosts(userId);
    return response;
  }

  @override
  Future<dynamic> getNewestUserPosts(String userId) async {
    final response = await profileWebServices.getNewestUserPosts(userId);
    return response;
  }

  @override
  Future<dynamic> deletePost(int postId, String userId) async {
    final response = await profileWebServices.deletePost(postId, userId);
    return response;
  }

  @override
  Future<dynamic> getFollowersCount(String userId) async {
    final response = await profileWebServices.getFollowersCount(userId);
    return response;
  }
  @override
  Future<dynamic> getFollowingCount(String userId) async {
    final response = await profileWebServices.getFollowingCount(userId);
    return response;
  }
  @override
  Future<dynamic> getUserPostCount(String userId) async {
    final response = await profileWebServices.getUserPostCount(userId);
    return response;
  }
}
