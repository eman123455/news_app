import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/HomePage/presentation/widgets/news_items_model.dart';
import '../../../../core/resources/app_text_style.dart';

class LatestNewsCard extends StatelessWidget {
  final NewsModel newsModel;

  const LatestNewsCard({required this.newsModel, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //context.push(AppRoutes.kNewsDetailsView);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                newsModel.imageUrl,
                height: 80.h,
                width: 80.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 80.h,
                  width: 80.w,
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 80.h,
                    width: 80.w,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsModel.category,
                    style: AppTextStyle.font13Grey4ERegular,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    newsModel.title,
                    style: AppTextStyle.font16BlackW600.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: Colors.grey[200],
                        child: ClipOval(
                          child: Image.network(
                            newsModel.sourceLogo,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.newspaper, size: 12.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          newsModel.source,
                          style: AppTextStyle.font13Grey4ERegular.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.watch_later_outlined, size: 12.sp),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          newsModel.time,
                          style: AppTextStyle.font13Grey4ERegular,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}