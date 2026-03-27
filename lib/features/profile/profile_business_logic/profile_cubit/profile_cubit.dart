import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/profile/data/models/profile_model.dart';
import 'package:news_app/features/profile/data/repo/profile_repo_implementation.dart';
import 'package:news_app/core/storage/local_storage.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final repo = getIt.get<ProfileRepoImplementation>();
  Future<String> get _userId async => await LocalStorage.getUserId();
  Future<void> getProfile() async {
    emit(GetProfileLoading());
    try {
      final userId = await _userId;
      final profile = await repo.getProfile(userId);
      final followers = await repo.getFollowersCount(userId);
      final following = await repo.getFollowingCount(userId);
      final postsCount = await repo.getUserPostCount(userId);
      emit(GetProfileSuccess(profile: profile, followers: followers, following: following, postsCount: postsCount));
    } catch (e) {
      emit(GetProfileFailed(errMsg: e.toString()));
    }
  }
  Future<void> updateProfile({
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
    try {
      final userId = await _userId;
      await repo.updateProfile(
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
      await getProfile();
    } catch (e) {
      emit(ProfileUpdateFailed(errMsg: e.toString()));
    }
  }
  Future<dynamic> addProfile({
    required String? username,
    required String? fullName,
    required String? email,
    required String? phone,
    required String? bio,
    required String? website,
    required String? imageUrl,
    required String? country,
    required String? role,
  }) async {
    try {
      final userId = await _userId;
      await repo.addProfile(
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
      if (!isClosed) emit(ProfileAddedSuccess());
      if (!isClosed) await getProfile();
    } catch (e) {
      if (!isClosed) emit(ProfileAddedFailed(errMsg: e.toString()));
    }
  }
}
