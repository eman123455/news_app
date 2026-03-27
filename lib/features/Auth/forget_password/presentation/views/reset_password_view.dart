import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Auth/forget_password/forget_pass_business_logic/cubit/forget_password_cubit.dart';
import 'package:news_app/features/Auth/forget_password/presentation/widgets/hero-section.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ForgetPasswordCubit>().initDeepLink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      builder: (context, state) {
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
                HeroSection(
                  head1: 'Reset',
                  head2: 'Password',
                  welcomeParagph: '',
                ),
                const SizedBox(height: 12),
                CustomeTextField(
                  label: 'New Password',
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 12),
                CustomeTextField(
                  label: 'Confirme New Password',
                  isPassword: true,
                  controller: _confirmPasswordController,
                ),
                Spacer(),
                CustomeButton(
                  height: 50,
                  color: AppColors.navBarBlue,
                  onPressend: () {
                    context.read<ForgetPasswordCubit>().restPassword(
                      _passwordController.text,
                    );
                  },
                  buttonName: 'Submit',
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          context.go(AppRoutes.kConfirmePassView);
        }
        if (state is DeepLinkReceived) {
          context.go(AppRoutes.kResetPassView);
        }
        if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Email or Password is Incorrect',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}