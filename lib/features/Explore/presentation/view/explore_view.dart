import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/components/custom_app_bar.dart';
import 'package:news_app/core/resources/app_fonts.dart';
import 'package:news_app/features/Explore/presentation/bloc/explore_cubit.dart';
import 'package:news_app/features/Explore/presentation/widgets/explore_item.dart';
import 'package:news_app/features/Explore/presentation/widgets/topic_card.dart';
import 'package:news_app/features/Trending/presentation/widgets/trending_news_item.dart';

// class Explore extends StatelessWidget {
//   const Explore({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<ExploreCubit, ExploreState>(
//           builder: (context, state) {
//             if (state is ExploreLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (state is ExploreError) {
//               return Center(child: Text(state.message));
//             }
//
//             if (state is ExploreLoaded) {
//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Explore',
//                         style: TextStyle(fontWeight: Fonts.bold, fontSize: 32.sp),
//                       ),
//                       SizedBox(height: 16.h),
//
//                       Text(
//                         'Popular Topics',
//                         style: TextStyle(fontWeight: Fonts.bold, fontSize: 16.sp),
//                       ),
//                       SizedBox(height: 16.h),
//                       ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: state.explores.length,
//                         separatorBuilder: (_, _) => SizedBox(height: 8.h),
//                         itemBuilder: (context, index) =>
//                             ExploreItem(explore: state.explores[index]),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }
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
class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

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
              final currentList = state.selectedTab == 0
                  ? state.explores
                  : state.followingExplores;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  //   child: Text(
                  //     'Explore',
                  //     style: TextStyle(fontWeight: Fonts.bold, fontSize: 32.sp),
                  //   ),
                  // ),

                  // ── Tab switcher ──────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _TabButton(
                          label: 'For You',
                          isSelected: state.selectedTab == 0,
                          onTap: () {
                            if (state.selectedTab == 0) {
                              context.read<ExploreCubit>().refresh();
                            } else {
                              context.read<ExploreCubit>().changeTab(0);
                            }
                          },
                        ),
                        SizedBox(width: 24.w),
                        _TabButton(
                          label: 'Following',
                          isSelected: state.selectedTab == 1,
                          onTap: () {
                            if (state.selectedTab == 1) {
                              context.read<ExploreCubit>().refresh();
                            } else {
                              context.read<ExploreCubit>().changeTab(1);
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // ── List ─────────────────────────────────
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      itemCount: currentList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (context, index) =>
                          ExploreItem(explore: currentList[index]),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

// ── Tab Button Widget ─────────────────────────────────────
class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: isSelected ? Fonts.bold : Fonts.regular,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          if (isSelected)
            Container(
              height: 2,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}