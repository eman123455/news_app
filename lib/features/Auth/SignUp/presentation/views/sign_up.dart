import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Auth/SignUp/presentation/widgets/footer.dart';
import 'package:news_app/features/Auth/SignUp/presentation/widgets/hero-section.dart';
import 'package:news_app/features/Auth/SignUp/sign_up_business_logic/sign_up_cubit/sign_up_cubit.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  bool isPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      builder: (context, state) {
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

                  Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        CustomeTextField(
                          controller: _emailController,
                          label: "Email",
                          isPassword: false,
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

                        const SizedBox(height: 20),
                        CustomeTextField(
                          controller: _passwordController,
                          label: "Password",
                          isPassword: isPassword,
                          suffixIcon: GestureDetector(
                            child: isPassword
                                ? Icon(Icons.visibility_off_outlined)
                                : Icon(Icons.visibility_sharp),
                            onTap: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Password is required")),
                              );
                              return "Email is required";
                            }

                            if (value.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Password must be at lest 6 chars",
                                  ),
                                ),
                              );
                              return "Password must be at lest 6 chars";
                            }

                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (val) {},
                              activeColor: const Color(0xFF1A73E8),
                            ),
                            const Text(
                              "Remember me",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),
                        state is SignUpLoading
                            ? CustomeButton(
                                height: 55,
                                color: AppColors.navBarBlue,
                                onPressend: () {},
                                buttonName: 'Sign Up',
                              )
                            : CustomeButton(
                                height: 55,
                                color: AppColors.navBarBlue,
                                onPressend: () {
                                  if (_globalKey.currentState?.validate() ??
                                      false) {
                                    context.read<SignUpCubit>().signUp(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  }
                                },
                                buttonName: 'Sign Up',
                              ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Footer(
                    qeuation: 'Aleardy have account?',
                    textButton: 'Login',
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SignUpSuccess) {
          context.go(AppRoutes.kAcountSetup);
        }

        if (state is SignUpError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
