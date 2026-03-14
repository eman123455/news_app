import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/app_colors.dart';

import 'app_fonts.dart';

class AppTheme {
  static TextStyle font16BlackW600 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: Fonts.semiBold,
    color: AppColors.black
  );
  static TextStyle font14Grey4ERegular = GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: Fonts.regular,
      color: AppColors.grey4E
  );
  static ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
  );
}