import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Auth/forget_password/presentation/widgets/hero-section.dart';

class ForgetPassView extends StatelessWidget {
  const ForgetPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            context.go(AppRoutes.kLogin);
          },
          icon: Icon(Icons.arrow_back),
          color: AppColors.black,
        ),
      ),
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              children: [
                HeroSection(
                  head1: "Forget",
                  head2: "Password?",
                  welcomeParagph:
                      "Don’t worry! it happens. Please enter the address associated with your account",
                ),

                const SizedBox(height: 16),
                CustomeTextField(
                  label: 'Email ID / Mobile Number',
                  isPassword: false,
                ),
              ],
            ),

            CustomeButton(
              height: 50,
              color: AppColors.navBarBlue,
              onPressend: () {
                context.go(AppRoutes.kOtpView);
              },
              buttonName: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
