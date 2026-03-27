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
}
