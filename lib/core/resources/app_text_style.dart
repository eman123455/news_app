import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/app_colors.dart';

import 'app_fonts.dart';

class AppTextStyle {
  static TextStyle font16BlackW600 = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: Fonts.semiBold,
    color: AppColors.black,
  );
  static TextStyle font14Grey4ERegular = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: Fonts.regular,
    color: AppColors.grey4E,
  );
  static ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static TextStyle text16Regular = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle text16RegularGrey = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey4E,
  );
  static TextStyle text13RegularGrey = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey4E,
  );
}
