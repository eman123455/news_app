import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/account_setup/business_logic/cubit/account_setup_cubit.dart';
import 'package:news_app/features/account_setup/presentation/widgets/topic_chip.dart';

class ChooseTopicsView extends StatelessWidget {
  const ChooseTopicsView({super.key});

  static const List<String> _topics = [
    'National',
    'International',
    'Sport',
    'Lifestyle',
    'Business',
    'Health',
    'Fashion',
    'Technology',
    'Science',
    'Art',
    'Politics',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColors.black),
        ),
        title: Text(
          'Choose your Topics',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<AccountSetupCubit, AccountSetupState>(
        builder: (context, state) {
          final cubit = context.read<AccountSetupCubit>();
          return Column(
            children: [
              // ── Search bar (decorative, no filtering needed for fixed list) ──
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: TextField(
                    style: GoogleFonts.poppins(fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: AppColors.textGrey,
                      ),
                      prefixIcon:
                          Icon(Icons.search, color: AppColors.textGrey, size: 20.sp),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              // ── Chip wrap ──
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Wrap(
                    spacing: 10.w,
                    runSpacing: 12.h,
                    children: _topics.map((topic) {
                      final isSelected = cubit.selectedTopics.contains(topic);
                      return TopicChip(
                        label: topic,
                        isSelected: isSelected,
                        onTap: () => cubit.toggleTopic(topic),
                      );
                    }).toList(),
                  ),
                ),
              ),

              // ── Next button ──
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.fetchSources();
                      context.push(AppRoutes.kChooseSources);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
