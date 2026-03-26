import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/features/Trending/api/trending_repo.dart';
import 'package:news_app/features/Trending/presentation/widgets/trending_news_item.dart';

class TrendingNewsListView extends StatefulWidget {

  const TrendingNewsListView({super.key});

  @override
  State<TrendingNewsListView> createState() => _TrendingNewsListViewState();
}

class _TrendingNewsListViewState extends State<TrendingNewsListView> {
  TrendingRepo trendingRepo = TrendingRepo();
  late List<dynamic> articles;
  @override
  void initState(){
    // TODO: implement initState
    init();
    super.initState();


  }
  Future<void> init() async {
    // articles = await trendingRepo.getTrending();
    print(articles.length);
    print('--------');
    for (var article in articles) {
      print(article['source']['name']);
      print('--------');
    }
    print('--------');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TrendingNewsItem();
      },
      itemCount: 10,
    );
  }
}
