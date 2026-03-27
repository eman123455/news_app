import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/Explore/presentation/bloc/explore_cubit.dart';
import 'package:news_app/features/Explore/presentation/widgets/explore_item.dart';
import 'package:news_app/features/Explore/presentation/widgets/tab_button.dart';
import 'package:news_app/features/news/news_details_args.dart';

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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 24.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TabButton(
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
                        TabButton(
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
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => context.read<ExploreCubit>().refresh(),
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemCount: currentList.length,
                        separatorBuilder: (_, _) => SizedBox(height: 8.h),
                        itemBuilder: (context, index) => ExploreItem(
                          explore: currentList[index],
                          onTap: () {
                            context.push(
                              AppRoutes.kNewsDetailsView,
                              extra: NewsDetailsArgs(
                                explore: currentList[index],
                                followingsUsersList: context
                                    .read<ExploreCubit>()
                                    .followingsUsersList,
                              ),
                            );
                          },
                        ),
                      ),
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
