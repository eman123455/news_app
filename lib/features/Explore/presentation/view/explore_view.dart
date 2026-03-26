import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/components/custom_app_bar.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/Explore/presentation/bloc/explore_cubit.dart';
import 'package:news_app/features/Explore/presentation/widgets/explore_item.dart';
import 'package:news_app/features/Explore/presentation/widgets/topic_card.dart';
import 'package:news_app/features/Trending/presentation/widgets/trending_news_item.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ExploreCubit, ExploreState>(
          builder: (context, state) {
            if (state is ExploreLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ExploreError) {
              return Center(child: Text(state.message));
            }

            if (state is ExploreLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore',
                        style: TextStyle(fontWeight: Fonts.bold, fontSize: 32.sp),
                      ),
                      SizedBox(height: 16.h),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Topic',
                      //       style: TextStyle(fontWeight: Fonts.bold, fontSize: 16.sp),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Text(
                      //         'See all',
                      //         style: TextStyle(
                      //           fontWeight: Fonts.regular,
                      //           fontSize: 14.sp,
                      //           color: Colors.grey,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 16.h),
                      // ListView.separated(
                      //   shrinkWrap: true,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemCount: state.explores.length,
                      //   separatorBuilder: (_, _) => SizedBox(height: 16.h),
                      //   itemBuilder: (context, index) =>
                      //       TopicCard(),
                      // ),
                      // SizedBox(height: 16.h),
                      Text(
                        'Popular Topics',
                        style: TextStyle(fontWeight: Fonts.bold, fontSize: 16.sp),
                      ),
                      SizedBox(height: 16.h),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.explores.length,
                        separatorBuilder: (_, _) => SizedBox(height: 8.h),
                        itemBuilder: (context, index) =>
                            ExploreItem(explore: state.explores[index]),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
