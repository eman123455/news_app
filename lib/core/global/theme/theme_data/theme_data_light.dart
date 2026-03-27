import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';

ThemeData getThemeDataLight() => ThemeData(
  scaffoldBackgroundColor: AppColors.kWhite,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.kWhite),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: AppTextStyle.text13RegularGrey,
    filled: true,
    fillColor: AppColors.kWhite,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColors.grey4E),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColors.grey4E),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: AppColors.kPrimaryColor),
    ),
  ),
);
