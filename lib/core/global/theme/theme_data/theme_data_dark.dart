import 'package:flutter/material.dart';
import 'package:news_app/core/global/theme/theme_data/app_colors/app_colors_dark.dart';
import 'package:news_app/core/resources/app_text_style.dart';

ThemeData getThemeDataDark() => ThemeData(
  scaffoldBackgroundColor: AppColorsDark.black,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsDark.black,
    iconTheme: IconThemeData(color: AppColorsDark.greyB0),
    centerTitle: true,
    titleTextStyle: AppTextStyle.text16Regular,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColorsDark.inputBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColorsDark.inputBackground),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColorsDark.inputBackground),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColorsDark.greyE4),
    ),
  ),
  textTheme: TextTheme(),
);
