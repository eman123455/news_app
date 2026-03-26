import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custom_app_bar.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/news/presentation/widgets/comments_bottom_sheet.dart';
import 'package:news_app/features/news/presentation/widgets/read_more_text.dart';

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({super.key, required this.explore});

  final ExploreModel explore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        actionIconButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
        leadingIconButton: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        child: Image.network(
                          explore.user?.image??'',
                          errorBuilder: (_, _, _) {
                            return Image.asset(
                              'assets/images/png/splash_logo.png',
                              width: 380.w,
                              height: 248.h,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            explore.user?.name ?? "Unknown User",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: Fonts.semiBold,
                            ),
                          ),
                          Text(
                            _formatDate(explore.createdAt),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      fixedSize: Size(102.w, 34.h),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      'Following',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Fonts.semiBold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.network(
                  explore.imageUrl,
                  width: 380.w,
                  height: 248.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return Image.asset(
                      'assets/images/png/splash_logo.png',
                      width: 380.w,
                      height: 248.h,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      explore.category?.name??'Unknown Category',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: Fonts.regular,
                      ),
                    ),
                    ReadMoreText(text: explore.title),
                    SizedBox(height: 16.h),
                    Text(
                      explore.content,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Fonts.regular,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        padding: EdgeInsets.only(left: 24.w, right: 48.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_rounded, color: Colors.red),
                    ),
                    Text(explore.likes.length.toString()),
                  ],
                ),
                SizedBox(width: 30.w),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const CommentsSheet(),
                        );
                      },
                      icon: Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.black,
                      ),
                    ),
                    Text('24.5K'),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.bookmark_outlined, color: Colors.blue),
            ),
          ],
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
