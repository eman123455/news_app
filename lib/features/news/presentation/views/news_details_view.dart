import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/components/custom_app_bar.dart';
import 'package:news_app/core/functions/time_ago.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/news/bloc/post_details_cubit.dart';
import 'package:news_app/features/news/presentation/widgets/comments_bottom_sheet.dart';
import 'package:news_app/features/news/presentation/widgets/read_more_text.dart';

class NewsDetailsView extends StatelessWidget {
  const NewsDetailsView({super.key, required this.explore});

  final ExploreModel explore;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostDetailsCubit, PostDetailsState>(
      builder: (context, state) {
        if (state is PostDetailsLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is PostDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else if (state is PostDetailsLoaded) {
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
                                explore.user?.image ?? '',
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
                                  timeAgo(explore.createdAt),
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () =>
                              context.read<PostDetailsCubit>().toggleFollow(),
                          style: TextButton.styleFrom(
                            fixedSize: Size(102.w, 34.h),
                            foregroundColor: state.isFollowing
                                ? Colors.blue
                                : Colors.white,
                            backgroundColor: state.isFollowing
                                ? Colors.white
                                : Colors.blue,
                            side: state.isFollowing
                                ? const BorderSide(color: Colors.blue)
                                : BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Text(
                            state.isFollowing ? 'Following' : 'Follow',
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
                            explore.category?.name ?? 'Unknown Category',
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
                            onPressed: () =>
                                context.read<PostDetailsCubit>().toggleLike(),
                            icon: Icon(
                              Icons.favorite_rounded,
                              color: state.isLiked ? Colors.red : Colors.grey,
                            ),
                          ),
                          Text(state.likesCount.toString()),
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
                                builder: (_) => BlocProvider.value(
                                  value: context.read<PostDetailsCubit>(),
                                  child: CommentsSheet(
                                    postId: explore.id!,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.black,
                            ),
                          ),
                          Text(state.comments.length.toString()),
                        ],
                      ),
                    ],
                  ),

                  IconButton(
                    onPressed: () => context.read<PostDetailsCubit>().toggleBookmark(),
                    icon: Icon(
                      state.isBookmarked ? Icons.bookmark : Icons.bookmark_outlined,
                      color: state.isBookmarked ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
