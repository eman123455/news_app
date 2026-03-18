import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/account_setup/business_logic/cubit/account_setup_cubit.dart';
import 'package:news_app/features/account_setup/presentation/widgets/custom_button.dart';
import 'package:news_app/features/account_setup/presentation/widgets/custom_text_field.dart';

class FillProfileView extends StatelessWidget {
  const FillProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Fill your Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                   CircleAvatar(
                    radius: 60.r,
                    backgroundColor: AppColors.lightGrey,
                    child: Icon(
                      Icons.person,
                      size: 60.sp,
                      color: AppColors.borderGrey,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(4.w),
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              CustomTextField(
                label: 'Username',
                hintText: 'Enter your username',
                onChanged: (val) {
                  context.read<AccountSetupCubit>().updateProfileField(username: val);
                },
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Full Name',
                hintText: 'Enter your full name',
                onChanged: (val) {
                  context.read<AccountSetupCubit>().updateProfileField(fullName: val);
                },
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Email Address',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  context.read<AccountSetupCubit>().updateProfileField(email: val);
                },
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Phone Number',
                hintText: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                onChanged: (val) {
                  context.read<AccountSetupCubit>().updateProfileField(phoneNumber: val);
                },
              ),
              SizedBox(height: 32.h),
              BlocConsumer<AccountSetupCubit, AccountSetupState>(
                listener: (context, state) {
                  if (state is AccountSetupCompleted) {
                    context.go(AppRoutes.kHomePage);
                  } else if (state is AccountSetupError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: 'Next',
                    onPressed: state is AccountSetupLoading
                        ? null
                        : () {
                            context.read<AccountSetupCubit>().completeAccountSetup();
                          },
                  );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
