import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Auth/login/presentation/widgets/footer.dart';
import 'package:news_app/features/Auth/login/presentation/widgets/hero-section.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroSection(
              head1: 'Hallo',
              head2: 'Again!',
              welcomeParagph: 'Welcome back you\'ve\nbeen missed',
            ),
            const SizedBox(height: 28),

            const CustomeTextField(label: "Username", isPassword: false),

            const SizedBox(height: 20),
            const CustomeTextField(
              label: "Password",
              isPassword: true,
              suffixIcon: Icon(Icons.visibility_off_outlined),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (val) {},
                      activeColor: const Color(0xFF1A73E8),
                    ),
                    const Text("Remember me", style: TextStyle(fontSize: 12)),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    context.go(AppRoutes.kForgetPassView);
                  },
                  child: const Text(
                    "Forgot the password?",
                    style: TextStyle(color: Color(0xFF1A73E8), fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),
            CustomeButton(
              height: 55,
              color: AppColors.navBarBlue,
              onPressend: () {},
              buttonName: 'Login',
            ),

            const SizedBox(height: 20),
            Footer(),
          ],
        ),
      ),
    );
  }
}
