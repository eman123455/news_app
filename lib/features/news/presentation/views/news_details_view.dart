import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custom_app_bar.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/HomePage/Domain/Entity/article_entity.dart';

class NewsArticleDetailsView extends StatelessWidget {
  const NewsArticleDetailsView({super.key, required this.article});

  final ArticleEntity article;

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
              // ── Source Info ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Colors.grey[200],
                        child: ClipOval(
                          child: Image.network(
                            article.sourceIcon ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.newspaper, size: 20),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article.sourceName ?? 'Unknown Source',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: Fonts.semiBold,
                            ),
                          ),
                          Text(
                            article.publishedAt ?? '',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // ── Image ──
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.network(
                  article.urlToImage ?? '',
                  width: double.infinity,
                  height: 248.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: double.infinity,
                    height: 248.h,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 50),
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // ── Content ──
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // العنوان
                    Text(
                      article.title ?? '',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: Fonts.semiBold,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // الوصف
                    Text(
                      article.description ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: Fonts.regular,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined, color: Colors.black),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.bookmark_outline, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}