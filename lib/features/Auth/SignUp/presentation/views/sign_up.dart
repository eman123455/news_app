import 'package:flutter/material.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/features/Auth/SignUp/presentation/widgets/footer.dart';
import 'package:news_app/features/Auth/SignUp/presentation/widgets/hero-section.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              HeroSection(
                head1: 'Hello',
                head2: 'There!',
                welcomeParagph: 'Signup to get started',
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
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (val) {},
                    activeColor: const Color(0xFF1A73E8),
                  ),
                  const Text("Remember me", style: TextStyle(fontSize: 12)),
                ],
              ),

              const SizedBox(height: 18),
              CustomeButton(
                height: 55,
                color: AppColors.navBarBlue,
                onPressend: () {},
                buttonName: 'Sign Up',
              ),

              const SizedBox(height: 20),
              Footer(qeuation: 'Aleardy have account?', textButton: 'Login'),
            ],
          ),
        ),
      ),
    );
  }
}
