import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custom_circular_progress_indicator.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/profile/data/profile_web_services/profile_web_services.dart';
import 'package:news_app/features/profile/presentation/views/news_part.dart';
import 'package:news_app/features/profile/presentation/views/recent.dart';
import 'package:news_app/core/components/custom_button.dart';
import 'package:news_app/features/profile/presentation/widgets/custom_profile_photo.dart';
import 'package:news_app/features/profile/presentation/widgets/profile_stat_item.dart';
import 'package:news_app/features/profile/profile_business_logic/profile_cubit/profile_cubit.dart';
import 'package:news_app/features/profile/profile_business_logic/posts_cubit/posts_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileCubit()..getProfile()),
          BlocProvider(create: (context) => PostsCubit()..getUserPosts()),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile', style: AppTextStyle.text16Regular),
            centerTitle: true,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () async {
                    context.push(AppRoutes.kSettingsView);
                  },
                  icon: Icon(Icons.settings),
                ),
              ),
            ],
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoading) {
                return CustomCircularProgressIndicator();
              } else if (state is GetProfileSuccess) {
                final profile = state.profile;
                final followers = state.followers;
                final following = state.following;
                final postsCount = state.postsCount;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomProfilePhoto(
                            imageUrl: profile.imageUrl!,
                            height: 100.h,
                            width: 100.h,
                            fontsize: 24.sp,
                            userName: profile.fullName,
                          ),
                          ProfileStatItem(
                            count: '$followers',
                            label: 'Followers',
                          ),
                          ProfileStatItem(
                            count: '$following',
                            label: 'Following',
                          ),
                          ProfileStatItem(count: '$postsCount', label: 'News'),
                        ],
                      ),
                      SizedBox(height: 16.h),

                      Text(
                        profile.fullName ?? 'default user',
                        style: AppTextStyle.text16Regular.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      Text(
                        profile.bio ??
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: AppTextStyle.text16RegularGrey,
                      ),
                      SizedBox(height: 16.h),

                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              onPressed: () async {
                                final result = await context.push(
                                  AppRoutes.kEditProfileView,
                                  extra: profile,
                                );
                                if (result == true) {
                                  context.read<ProfileCubit>().getProfile();
                                }
                              },
                              buttonText: 'Edit Profile',
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {},
                              buttonText: 'Website',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      TabBar(
                        dividerColor: Colors.transparent,
                        indicatorColor: AppColors.kPrimaryColor,
                        indicatorWeight: 3,
                        labelColor: AppColors.kPrimaryColor,
                        unselectedLabelColor: AppColors.grey4E,
                        labelStyle: AppTextStyle.text16Regular,
                        tabs: const [
                          Tab(text: 'News'),
                          Tab(text: 'Recent'),
                        ],
                      ),

                      SizedBox(height: 10.h),

                      Expanded(
                        child: TabBarView(
                          children: [
                            NewsPart(user: profile),
                            Recent(user: profile),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is GetProfileFailed) {
                return Text(state.errMsg);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          floatingActionButton: Builder(
            builder: (context) => FloatingActionButton(
              backgroundColor: AppColors.kPrimaryColor,
              onPressed: () async {
                final result = await context.push(AppRoutes.kCreateNewsView);
                if (result == true) {
                  context.read<PostsCubit>().getUserPosts();
                  // context.read<ProfileCubit>().getProfile();
                }
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
