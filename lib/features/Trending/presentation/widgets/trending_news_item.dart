import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';

class TrendingNewsItem extends StatelessWidget {
  const TrendingNewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .symmetric(horizontal: 24.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 380.w,
        // height: 310.h,
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
                'https://upload.wikimedia.org/wikipedia/commons/2/22/1_Nature_1.png',
                width: 364.w,
                height: 184.h,
                fit: .cover,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Europe',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: Fonts.semiBold,
                    ),
                  ),
                  Text(
                    "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
                    style: TextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.h, bottom: 8.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/png/test_bbc.png',
                          ),
                          radius: 10.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'BBC News',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: Fonts.semiBold,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_rounded,
                              size: 14.sp,
                              // color: Colors.grey,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '2 hours ago',
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
    );
  }
}
