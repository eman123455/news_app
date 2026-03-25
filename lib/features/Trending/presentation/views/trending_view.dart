import 'package:flutter/material.dart';
import 'package:news_app/core/components/custom_app_bar.dart';

import '../widgets/trending_news_list_view.dart';

class TrendingView extends StatelessWidget {
  const TrendingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Trending',
        actionIconButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
        ),
        leadingIconButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: TrendingNewsListView(),
    );
  }
}
