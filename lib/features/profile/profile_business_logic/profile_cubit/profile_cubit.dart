import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/profile/data/models/profile_model.dart';
import 'package:news_app/features/profile/data/repo/profile_repo_implementation.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final repo = getIt.get<ProfileRepoImplementation>();
  // test
  final userId = '062b90f8-49cd-4911-8d3a-265924aa0597';
  Future<void> getProfile() async {
    emit(GetProfileLoading());
    try {
      final profile = await repo.getProfile(userId);
      emit(GetProfileSuccess(profile: profile));
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
}
