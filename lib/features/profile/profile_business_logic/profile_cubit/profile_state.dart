part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  final ProfileModel profile;
  final int followers;
  final int following;
  final int postsCount;


  GetProfileSuccess({required this.profile, required this.followers, required this.following, required this.postsCount});
}

final class GetProfileFailed extends ProfileState {
  final String errMsg;

  GetProfileFailed({required this.errMsg});
}

final class GetProfileLoading extends ProfileState {}

final class ProfileUpdateSuccess extends ProfileState {}

final class ProfileUpdateFailed extends ProfileState {
  final String errMsg;

  ProfileUpdateFailed({required this.errMsg});
}
final class ProfileAddedSuccess extends ProfileState {}

final class ProfileAddedFailed extends ProfileState {
  final String errMsg;

  ProfileAddedFailed({required this.errMsg});
}


