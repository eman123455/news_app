part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  final ProfileModel profile;

  GetProfileSuccess({required this.profile});
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
