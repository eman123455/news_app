import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_colors.dart';

class AppButtonsStyle {
  AppButtonsStyle._();

  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.navBarBlue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    minimumSize: Size(85, 50),
  );
}
