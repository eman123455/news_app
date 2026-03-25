import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_images.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/core/resources/app_text_style.dart';

class ConfimeResetPass extends StatelessWidget {
  const ConfimeResetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Spacer(),
            Column(
              children: [
                Image.asset(AppImages.logo),
                const SizedBox(height: 24),
                Text(
                  'Congratulations!',
                  style: AppTextStyle.font48BlackW700.copyWith(
                    fontSize: 32,
                    color: AppColors.grey4E,
                  ),
                ),
                Text(
                  'Your account is ready to use',
                  style: AppTextStyle.font16Grey4EW400,
                ),
              ],
            ),
            Spacer(),
            CustomeButton(
              height: 50,
              color: AppColors.navBarBlue,
              onPressend: () {
                context.go(AppRoutes.kLogin);
              },
              buttonName: 'Go to login page',
            ),
          ],
        ),
      ),
    );
  }
}
