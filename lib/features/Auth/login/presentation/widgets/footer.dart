import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/social_media_button.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            "or continue with",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        const SizedBox(height: 20),

        const Row(
          children: [
            SocialMediaButton(
              label: "Facebook",
              iconPath: "assets/images/png/facebook_icon.png",
            ),
            SizedBox(width: 16),
            SocialMediaButton(
              label: "Google",
              iconPath: "assets/images/png/google_icon.png",
            ),
          ],
        ),

        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: .center,
          children: [
            const Text('Don\'t have and account?'),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.kSignUp);
              },
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  color: AppColors.navBarBlue,
                  fontSize: 14,
                  fontWeight: .w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
