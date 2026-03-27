import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              'assets/images/png/test_bbc.png',
              width: 96.w,
              height: 96.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Europe',
                  style: TextStyle(fontSize: 16.sp, fontWeight: Fonts.regular),
                ),
                Text(
                  "Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil",
                  style: TextStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                        ),SizedBox(width: 8.w),
                        Icon(
                          Icons.access_time_rounded,
                          size: 14.sp,
                          // color: Colors.grey,
                        ),
                        SizedBox(width: 4.w),
                        Text('2 hours ago', style: TextStyle(fontSize: 14.sp)),

                      ],
                    ),

                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.more_horiz_outlined),
                        ),
                        ],
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
