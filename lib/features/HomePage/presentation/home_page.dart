import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/HomePage/Domain/Entity/article_entity.dart';
import 'package:news_app/features/HomePage/presentation/widgets/category_filter_tabs.dart';
import 'package:news_app/features/HomePage/presentation/widgets/latest_news_card.dart';
import 'package:news_app/features/HomePage/presentation/widgets/news_items_model.dart';
import 'package:news_app/features/HomePage/presentation/widgets/notification_services.dart';

import '../../../core/resources/app_colors.dart';
import 'logic/news_bloc.dart';
import 'logic/news_event.dart';
import 'logic/news_state.dart';
import 'widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<ArticleEntity> allArticles = [];
  List<ArticleEntity> filteredArticles = [];
  bool isSearching = false;
  String selectCats = 'All';

  final NotificationServices _notificationServices = NotificationServices();
  @override
  void initState(){
    super.initState();
    initNotifications();

  }

  Future<void> initNotifications() async{
    await _notificationServices.initNotifications();
    _notificationServices.onNotificationTap((postId) {
      if(!mounted) return;
      Navigator.pushNamed(context, '/post', arguments: postId);
    });
    final postId = await _notificationServices.getInitialPostId();
    if (postId != null && mounted) {
      Navigator.pushNamed(context, '/post', arguments: postId);
    }


  }

  void search(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        filteredArticles = allArticles;
      } else {
        filteredArticles = allArticles
            .where((article) =>
        article.title?.toLowerCase().contains(query.toLowerCase()) ??
            false)
            .toList();
      }
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectCats = category;
    });
    final String? categoryPara =
    category == 'All' ? null : category.toLowerCase();
    context.read<NewsBloc>().add(FetchNews(category: categoryPara));
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return Center(child: Text(state.message));
          }

          if (state is SuccessState) {
            if (!isSearching) {
              allArticles = state.articles;
              filteredArticles = state.articles;
            } else {
              allArticles = state.articles;
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: searchController,
                        onChanged: search,
                        cursorColor: AppColors.navBarBlue,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Icon(Icons.tune_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Trending",
                              style: AppTextStyle.font16BlackW600),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (filteredArticles.isNotEmpty) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            filteredArticles[0].urlToImage ?? '',
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 200.h,
                              color: Colors.grey[300],
                              child: Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text(
                              filteredArticles[0].sourceName ?? '',
                              style: AppTextStyle.font13Grey4ERegular,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          filteredArticles[0].title ?? '',
                          style: AppTextStyle.font16BlackW600.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10.r,
                              backgroundImage: NetworkImage(
                                  filteredArticles[0].sourceIcon ?? ''),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              filteredArticles[0].sourceName ?? '',
                              style:
                              AppTextStyle.font13Grey4ERegular.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(Icons.watch_later_outlined),
                            SizedBox(width: 8.w),
                            Text(
                              filteredArticles[0].publishedAt ?? '',
                              style: AppTextStyle.font13Grey4ERegular,
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Latest", style: AppTextStyle.font16BlackW600),
                          GestureDetector(
                            onTap: () {},
                            child: Text('See all',
                                style: AppTextStyle.font14Grey4ERegular),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      CategoryFilterTabs(
                        onCategorySelected: filterByCategory,
                        selectCats: selectCats,
                      ),
                      SizedBox(height: 12.h),
                      if (filteredArticles.isEmpty)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 40.h),
                            Image.asset(
                              'assets/images/png/oops.png',
                              height: 200.h,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                                'No results found',
                                style: AppTextStyle.font16BlackW600.copyWith(
                                  color: AppColors.navBarBlue,)
                            ),
                          ],
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredArticles.length,
                          itemBuilder: (context, index) => LatestNewsCard(
                            newsModel: NewsModel(
                              imageUrl:
                              filteredArticles[index].urlToImage ?? '',
                              category:
                              filteredArticles[index].sourceName ?? '',
                              title: filteredArticles[index].title ?? '',
                              source:
                              filteredArticles[index].sourceName ?? '',
                              sourceLogo:
                              filteredArticles[index].sourceIcon ?? '',
                              time: filteredArticles[index].publishedAt ?? '',
                            ), article: filteredArticles[index],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}