part of 'account_setup_cubit.dart';

@immutable
sealed class AccountSetupState {}

final class AccountSetupInitial extends AccountSetupState {}

final class AccountSetupLoading extends AccountSetupState {}

final class AccountSetupSourcesLoaded extends AccountSetupState {
  final List<SourceModel> sources;
  AccountSetupSourcesLoaded(this.sources);
}

final class AccountSetupError extends AccountSetupState {
  final String message;
  AccountSetupError(this.message);
}

/// Emitted when country / topic / source selection changes
/// so the UI can rebuild without losing loaded data.
final class AccountSetupSelectionUpdated extends AccountSetupState {}

final class AccountSetupCompleted extends AccountSetupState {}
