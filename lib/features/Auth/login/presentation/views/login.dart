import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custome_button.dart';
import 'package:news_app/core/components/custome_text_field.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Auth/forget_password/data/forget_pass_web_services/forget_pass_web_services.dart';
import 'package:news_app/features/Auth/login/login_business_logic/login_cubit/login_cubit.dart';
import 'package:news_app/features/Auth/login/presentation/widgets/footer.dart';
import 'package:news_app/features/Auth/login/presentation/widgets/hero-section.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
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

                Form(
                  key: _formKey,
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.go(AppRoutes.kForgetPassView);
                            },
                            child: const Text(
                              "Forgot the password?",
                              style: TextStyle(
                                color: Color(0xFF1A73E8),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),
                state is LoginLoading
                    ? CustomeButton(
                        height: 55,
                        color: AppColors.navBarBlue,
                        onPressend: () {},
                        buttonName: 'Login',
                      )
                    : CustomeButton(
                        height: 55,
                        color: AppColors.navBarBlue,
                        onPressend: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<LoginCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        buttonName: 'Login',
                      ),

                const SizedBox(height: 20),
                Footer(),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        
        if (state is LoginSuccess) {
          context.go(AppRoutes.kNavBar);
        }

        if (state is LoginError) {
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
