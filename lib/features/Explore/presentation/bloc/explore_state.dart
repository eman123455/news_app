part of 'explore_cubit.dart';

@immutable
sealed class ExploreState {}


class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<ExploreModel> explores;
  ExploreLoaded(this.explores);
}

class ExploreError extends ExploreState {
  final String message;
  ExploreError(this.message);
}