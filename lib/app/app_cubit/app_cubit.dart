import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

enum ThemeModeState { light, dark, system }

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial(ThemeModeState.system));
  // ignore: strict_top_level_inference
  static AppCubit get(context) => BlocProvider.of(context);
  ThemeModeState currentTheme = ThemeModeState.system;
  bool get isDarkTheme {
    switch (currentTheme) {
      case ThemeModeState.dark:
        return true;
      case ThemeModeState.light:
        return false;
      case ThemeModeState.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark;
    }
  }

  void selectTheme(ThemeModeState theme) {
    if (currentTheme == theme) {
      return;
    }
    currentTheme = theme;
    emit(AppThemeChanged(currentTheme));
  }

  ThemeMode getTheme() {
    switch (currentTheme) {
      case ThemeModeState.dark:
        return ThemeMode.dark;
      case ThemeModeState.light:
        return ThemeMode.light;
      case ThemeModeState.system:
        return ThemeMode.system;
    }
  }
}
