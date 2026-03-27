import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/app_cubit/app_cubit.dart';
import 'package:news_app/core/resources/app_colors.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          final bool isDarkTheme = AppCubit.get(context).isDarkTheme;
          return Center(
            child: isDarkTheme
                ? CircularProgressIndicator(color: AppColors.kWhite)
                : CircularProgressIndicator(color: AppColors.kPrimaryColor),
          );
        },
      ),
    );
  }
}
