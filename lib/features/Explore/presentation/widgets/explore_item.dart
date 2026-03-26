import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';

class ExploreItem extends StatelessWidget {
  const ExploreItem({super.key, required this.explore});

  final ExploreModel explore;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.kNewsDetailsView, extra: explore),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 380.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  explore.imageUrl,
                  width: 364.w,
                  height: 184.h,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      explore.country,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Fonts.semiBold,
                      ),
                    ),
                    Text(
                      explore.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.h, bottom: 8.h),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(explore.imageUrl),
                            radius: 10.r,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              // explore.userId,
                              explore.user?.name??'Unknown User',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: Fonts.semiBold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _formatDate(explore.createdAt),
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inMinutes < 60) return '${difference.inMinutes} min ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    return '${difference.inDays} days ago';
  }
}