import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/components/custom_app_bar.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/Explore/presentation/widgets/topic_card.dart';
import 'package:news_app/features/Trending/presentation/widgets/trending_news_item.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Explore',
                  style: TextStyle(fontWeight: Fonts.bold, fontSize: 32.sp),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Topic',
                      style: TextStyle(fontWeight: Fonts.bold, fontSize: 16.sp),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(
                          fontWeight: Fonts.regular,
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TopicCard(),
                  itemCount: 3,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 16.h),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Popular Topics',
                  style: TextStyle(fontWeight: Fonts.bold, fontSize: 16.sp),
                ),
                SizedBox(height: 16.h),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TrendingNewsItem(),
                  itemCount: 10,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 8.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
