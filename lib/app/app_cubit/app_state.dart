part of 'app_cubit.dart';

sealed class AppState extends Equatable {
  final ThemeModeState themeMode;
  const AppState(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

final class AppInitial extends AppState {
  const AppInitial(super.themeMode);
}

final class AppThemeChanged extends AppState {
  const AppThemeChanged(super.themeMode);
}
