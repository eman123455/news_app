import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/BookMark/book_mark_business_logic/book_mark_cubit/book_mark_cubit.dart';
import 'package:news_app/features/Explore/presentation/widgets/explore_item.dart';
import 'package:news_app/features/news/news_details_args.dart';

class BookMarkView extends StatelessWidget {
  const BookMarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bookmark',
                    style: TextStyle(fontWeight: Fonts.bold, fontSize: 32.sp),
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    onChanged: (value) =>
                        context.read<BookmarkCubit>().search(value),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BookmarkCubit, BookmarkState>(
                builder: (context, state) {
                  if (state is BookmarkLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is BookmarkError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message, textAlign: TextAlign.center),
                          SizedBox(height: 16.h),
                          FilledButton.icon(
                            onPressed: () =>
                                context.read<BookmarkCubit>().refresh(),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Try again'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is BookmarkLoaded) {
                    if (state.filtered.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_outline,
                              size: 64.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.searchQuery.isEmpty
                                  ? 'No bookmarks yet'
                                  : 'No results found',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => context.read<BookmarkCubit>().refresh(),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemCount: state.filtered.length,
                        separatorBuilder: (_, __) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final post = state.filtered[index];
                          return ExploreItem(
                            explore: post,
                            onTap: () {
                              print(
                                'list: ${state.followingsUsersList}',
                              );
                              context.push(
                                AppRoutes.kNewsDetailsView,
                                extra: NewsDetailsArgs(
                                  explore: post,
                                  followingsUsersList: state.followingsUsersList,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
