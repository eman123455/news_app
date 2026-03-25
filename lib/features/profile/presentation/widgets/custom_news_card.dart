import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/functions/time_ago.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/profile/data/models/post_model/post_model.dart';
import 'package:news_app/features/profile/data/models/profile_model.dart';
import 'package:news_app/features/profile/presentation/widgets/custom_profile_photo.dart';
import 'package:news_app/features/profile/profile_business_logic/posts_cubit/posts_cubit.dart';
import 'package:news_app/core/components/delete_confirmation_sheet.dart';

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
          // صورة الخبر
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
                child: Icon(Icons.broken_image, color: Colors.grey[700], size: 40),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // محتوى الخبر
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // اسم الفئة
                Text(
                  postModel.categories?.name ?? '',
                  style: AppTextStyle.text13RegularGrey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),

                // محتوى النص
                Text(
                  postModel.content ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.text16Regular,
                ),
                SizedBox(height: 4.h),

                // معلومات الكاتب و الوقت و القائمة
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

                    // الاسم ياخد كل المساحة المتاحة و يختصر لو طويل
                    Expanded(
                      child: Text(
                        user.fullName ?? '',
                        style: AppTextStyle.font16BlackW600.copyWith(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(width: 8.w),

                    // الوقت ثابت
                    Text(
                      timeAgo(postModel.createdAt!),
                      style: AppTextStyle.text13RegularGrey,
                    ),

                    SizedBox(width: 4.w),

                    // تلت نقط ثابتة
                    PopupMenuButton(
                      icon: Icon(Icons.more_horiz, color: AppColors.grey4E, size: 16),
                      itemBuilder: (context) => [
                        PopupMenuItem(value: 'Edit', child: Text('Edit')),
                        PopupMenuItem(value: 'Delete', child: Text('Delete')),
                      ],
                      onSelected: (value) {
                        if (value == 'Delete') {
                          DeleteConfirmationSheet.show(
                            context,
                            message: 'Are you sure you want to delete this post?',
                            onConfirm: () {
                              BlocProvider.of<PostsCubit>(context).deletePost(
                                postModel.id!,
                              );
                            },
                          );
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