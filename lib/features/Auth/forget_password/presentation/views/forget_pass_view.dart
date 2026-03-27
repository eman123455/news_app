import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Auth/forget_password/forget_pass_business_logic/cubit/forget_password_cubit.dart';
import 'package:news_app/features/Auth/forget_password/presentation/widgets/hero-section.dart';

class ForgetPassView extends StatefulWidget {
  const ForgetPassView({super.key});

  @override
  State<ForgetPassView> createState() => _ForgetPassViewState();
}

class _ForgetPassViewState extends State<ForgetPassView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) => Scaffold(
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
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Email is required")),
                        );
                        return "Email is required";
                      }
                      if (!value.contains("@")) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                ],
              ),

              CustomeButton(
                height: 50,
                color: AppColors.navBarBlue,
                onPressend: state is ForgetPasswordLoading
                    ? () {}
                    : () {
                        context.read<ForgetPasswordCubit>().resetPassword(
                          _emailController.text.trim(),
                        );
                      },
                buttonName: 'Next',
              ),
            ],
          ),
        ),
      ),
      listener: (context, state) => {
        if (state is ForgetPasswordSuccess) {context.go(AppRoutes.kConfirmePassView)},

        if (state is ForgetPasswordFailure)
          {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message))),
          },
      },
    );
  }
}