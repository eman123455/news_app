import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_fonts.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              'assets/images/png/test_bbc.png',
              width: 70.w,
              height: 70.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health',
                  style: TextStyle(fontSize: 16.sp, fontWeight: Fonts.semiBold),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Get energizing workout moves, healthy recipes. Get energizing workout moves, healthy recipes.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              fixedSize: Size(78.w, 34.h),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            child: Text(
              'Saved',
              style: TextStyle(fontSize: 16.sp, fontWeight: Fonts.semiBold),
            ),
          ),
        ],
      ),
    );
  }
}
