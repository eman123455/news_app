import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Auth/forget_password/presentation/widgets/hero-section.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            context.go(AppRoutes.kOtpView);
          },
          icon: Icon(Icons.arrow_back, color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            HeroSection(head1: 'Reset', head2: 'Password', welcomeParagph: ''),
            const SizedBox(height: 12),
            CustomeTextField(label: 'New Password', isPassword: true),
            const SizedBox(height: 12),
            CustomeTextField(label: 'Confirme New Password', isPassword: true),
            Spacer(),
            CustomeButton(
              height: 50,
              color: AppColors.navBarBlue,
              onPressend: () {
                context.go(AppRoutes.kConfirmePassView);
              },
              buttonName: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
