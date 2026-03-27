import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/features/HomePage/Domain/Entity/article_entity.dart';
import 'package:news_app/features/HomePage/presentation/widgets/category_filter_tabs.dart';
import 'package:news_app/features/HomePage/presentation/widgets/latest_news_card.dart';
import 'package:news_app/features/HomePage/presentation/widgets/news_items_model.dart';
import 'package:news_app/features/HomePage/presentation/widgets/notification_services.dart';

import '../../../core/components/custom_app_bar.dart';



class HomePage extends StatefulWidget implements PreferredSizeWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<String> newsList = [
    "Football News",
    "Tech News",
    "Political News",
    "Beauty And woman"
  ];
  List<String> filterNews = [];
  void search(String query){
    final suggestion = newsList.where((news) {
      final result = news.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
      }).toList();
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
>>>>>>> Stashed changes
    setState(() {
      filterNews = suggestion;
    });
  }


  @override
  void initState() {
    super.initState();
   
      filterNews = newsList;

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: searchController,
                    onChanged: search,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.tune_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
<<<<<<< Updated upstream
                    ),
=======
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
>>>>>>> Stashed changes
                  ),
                ),
            
                Expanded(
                  child: ListView.builder(
                    itemCount: filterNews.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filterNews[index]),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Branding",
                    style: AppTheme.font16BlackW600
                    ),
                    Text(
                      'See all',
                    style:AppTheme.font14Grey4ERegular ,)
            
                  ]
            
                )
            
              ],
            ),
          ),
        ),
    );
  }
}
