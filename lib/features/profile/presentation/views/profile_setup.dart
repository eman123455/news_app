import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custom_button.dart';
import 'package:news_app/core/components/custom_text_field.dart';
import 'package:news_app/core/components/label.dart';
import 'package:news_app/core/functions/upload_image.dart';
import 'package:news_app/core/functions/validation.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/profile/profile_business_logic/profile_cubit/profile_cubit.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  late TextEditingController _usernameController;
  late TextEditingController _fullnameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _websiteController;
  late TextEditingController _countryController;
  final _key = GlobalKey<FormState>();
  File? selectedImage;
  String? imageUrl;

  @override
  void initState() {
    _fullnameController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _bioController = TextEditingController();
    _websiteController = TextEditingController();
    _countryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _websiteController.dispose();
    _countryController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        print(state);
        if (state is GetProfileSuccess) {
          context.pop(true);
        } else if (state is ProfileAddedSuccess) {
          // Navigate to the desired view after profile is added
          context.go(AppRoutes.kLogin); 
        } else if (state is ProfileAddedFailed) {
          print(state.errMsg);
        }
      },
      builder: (context, state) {
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
                              decoration: BoxDecoration(
                                color: AppColors.kwhiteEF,
                              ),
                              child: selectedImage != null
                                  ? Image.file(
                                      selectedImage!,
                                      fit: BoxFit.cover,
                                    )
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
                                if (image == null) return;

                                final imageLink = await uploadImageToStorage(
                                  image,
                                );

                                setState(() {
                                  selectedImage = image;
                                  imageUrl = imageLink;
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
                      Label(title: 'Username'),
                      CustomTextField(
                        hintText: 'Enter your username',
                        obscureText: false,
                        validator: (value) {
                          return Validation.fullNameValidator(value);
                        },
                        controller: _usernameController,
                      ),
                      const SizedBox(height: 16),
                      Label(title: 'Full Name'),
                      CustomTextField(
                        hintText: 'Enter your full name',
                        obscureText: false,
                        validator: (value) {
                          return Validation.fullNameValidator(value);
                        },
                        controller: _fullnameController,
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
                      Label(title: 'Country'),
                      CustomTextField(
                        hintText: 'Enter your Country',
                        validator: (value) =>
                            Validation.countryValidator(value),
                        obscureText: false,
                        controller: _countryController,
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
                        validator: (value) =>
                            Validation.websiteValidator(value),
                        obscureText: false,
                        controller: _websiteController,
                        keyboardType: TextInputType.url,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        buttonText: 'Next',
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            BlocProvider.of<ProfileCubit>(context).addProfile(
                              username: _usernameController.text,
                              fullName: _fullnameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              bio: _bioController.text,
                              website: _websiteController.text,
                              imageUrl: imageUrl,
                              country: _countryController.text,
                              role: 'user',
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20.sp),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
