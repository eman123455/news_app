import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/components/custom_button.dart';
import 'package:news_app/core/components/custom_text_field.dart';
import 'package:news_app/core/components/label.dart';
import 'package:news_app/core/functions/upload_image.dart';
import 'package:news_app/core/functions/validation.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';

class SetupProfileView extends StatefulWidget {
  const SetupProfileView({super.key});

  @override
  State<SetupProfileView> createState() => _SetupProfileViewState();
}

class _SetupProfileViewState extends State<SetupProfileView> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _websiteController;
  final _key = GlobalKey<FormState>();
  File? selectedImage;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();
    _websiteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Fill your Profile', style: AppTextStyle.text16Regular),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Container(
                          height: 140.h,
                          width: 140.w,
                          decoration: BoxDecoration(color: AppColors.kwhiteEF),
                          child: selectedImage != null
                              ? Image.file(selectedImage!, fit: BoxFit.cover)
                              : Container(
                                  height: 140.h,
                                  width: 140.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.kwhiteEF,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 10,
                        child: GestureDetector(
                          onTap: () async {
                            final image = await pickImageFromDevice();
                            setState(() {
                              selectedImage = image;
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.kWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Label(title: 'Full Name'),
                  CustomTextField(
                    hintText: 'Enter your full name',
                    obscureText: false,
                    validator: (value) {
                      return Validation.fullNameValidator(value);
                    },
                    controller: _usernameController,
                  ),
                  const SizedBox(height: 16),
                  Label(title: 'Email Address*'),
                  CustomTextField(
                    hintText: 'Enter your email address',
                    obscureText: false,
                    validator: (value) => Validation.emailValidator(value),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  Label(title: 'Phone Number*'),
                  CustomTextField(
                    hintText: 'Enter your phone number',
                    obscureText: false,
                    validator: (value) => Validation.phoneValidator(value),
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  Label(title: 'Bio'),
                  CustomTextField(
                    hintText: 'Enter your bio',
                    validator: (value) => Validation.bioValidator(value),
                    obscureText: false,
                    controller: _bioController,
                  ),
                  const SizedBox(height: 16),
                  Label(title: 'Website'),
                  CustomTextField(
                    hintText: 'Enter your website',
                    validator: (value) => Validation.websiteValidator(value),
                    obscureText: false,
                    controller: _websiteController,
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    buttonText: 'Next',
                    onPressed: () {
                      if (_key.currentState!.validate()) {}
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
