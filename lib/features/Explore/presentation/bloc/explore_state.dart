part of 'explore_cubit.dart';

@immutable
sealed class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<ExploreModel> explores;
  final List<ExploreModel> followingExplores;
  final int selectedTab;

  ExploreLoaded({
    required this.explores,
    required this.followingExplores,
    this.selectedTab = 0,
  });

  ExploreLoaded copyWith({int? selectedTab}) {
    return ExploreLoaded(
      explores: explores,
      followingExplores: followingExplores,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

class ExploreError extends ExploreState {
  final String message;

  ExploreError(this.message);
}
