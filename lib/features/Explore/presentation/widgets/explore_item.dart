import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/functions/time_ago.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/Explore/presentation/bloc/explore_cubit.dart';
import 'package:news_app/features/news/news_details_args.dart';

class ExploreItem extends StatelessWidget {
  const ExploreItem({super.key, required this.explore,required this.onTap});

  final ExploreModel explore;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: 380.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  explore.imageUrl,
                  width: 364.w,
                  height: 184.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return Image.asset(
                      'assets/images/png/splash_logo.png',
                      width: 364.w,
                      height: 184.h,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      explore.category?.name ?? 'Unknown Category',
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
                            radius: 10.r,
                            child: Image.network(
                              explore.user!.image ?? '',
                              errorBuilder: (_, _, _) {
                                return Image.asset(
                                  'assets/images/png/splash_logo.png',
                                  // width: 364.w,
                                  // height: 184.h,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              explore.user?.name ?? 'Unknown User',
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
                              Icon(Icons.access_time_rounded, size: 14.sp),
                              SizedBox(width: 4.w),
                              Text(
                                timeAgo(explore.createdAt),
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


}
