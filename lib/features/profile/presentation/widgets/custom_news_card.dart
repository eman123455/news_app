import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/functions/time_ago.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/profile/data/models/post_model/post_model.dart';
import 'package:news_app/features/profile/data/models/profile_model.dart';
import 'package:news_app/features/profile/presentation/widgets/custom_profile_photo.dart';
import 'package:news_app/features/profile/profile_business_logic/posts_cubit/posts_cubit.dart';
import 'package:news_app/core/components/delete_confirmation_sheet.dart';
import 'package:news_app/features/profile/profile_business_logic/profile_cubit/profile_cubit.dart';


class CustomNewsCard extends StatelessWidget {
  const CustomNewsCard({
    super.key,
    required this.postModel,
    required this.user,
  });
  final PostModel postModel;
  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: postModel.imageUrl ?? '',
              height: 120,
              width: 90,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator(strokeWidth: 2)),
              errorWidget: (context, url, error) => Container(
                height: 120,
                width: 90,
                color: Colors.grey[300],
                child: Icon(
                  Icons.broken_image,
                  color: Colors.grey[700],
                  size: 40,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postModel.categories?.name ?? '',
                  style: AppTextStyle.text13RegularGrey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),

                Text(
                  postModel.content ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.text16Regular,
                ),
                SizedBox(height: 4.h),

                Row(
                  children: [
                    CustomProfilePhoto(
                      imageUrl: user.imageUrl ?? '',
                      height: 20.h,
                      width: 20.h,
                      fontsize: 12.sp,
                      userName: user.fullName,
                    ),
                    SizedBox(width: 4.w),

                    Expanded(
                      child: Text(
                        user.fullName ?? '',
                        style: AppTextStyle.font16BlackW600.copyWith(
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(width: 8.w),

                    Text(
                      timeAgo(postModel.createdAt!),
                      style: AppTextStyle.text13RegularGrey,
                    ),

                    SizedBox(width: 4.w),

                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: AppColors.grey4E,
                        size: 16,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 'Edit', child: Text('Edit')),
                        PopupMenuItem(value: 'Delete', child: Text('Delete')),
                      ],
                      onSelected: (value) async{
                        if (value == 'Delete') {
                          DeleteConfirmationSheet.show(
                            context,
                            message:
                                'Are you sure you want to delete this post?',
                            onConfirm: () {
                              BlocProvider.of<PostsCubit>(
                                context,
                              ).deletePost(postModel.id!);
                             context.read<ProfileCubit>().getProfile();

                            },
                          );
                        } else if (value == 'Edit'){
                        final result= await context.push(AppRoutes.kEditNewsView, extra: postModel);
                            if (result == true) {
                          context.read<PostsCubit>().getUserPosts();
                }
                          
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
