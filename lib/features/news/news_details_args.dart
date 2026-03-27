import 'package:news_app/features/Explore/data/model/explore_model.dart';

class NewsDetailsArgs {
  final ExploreModel explore;
  final List<dynamic> followingsUsersList;

  NewsDetailsArgs({
    required this.explore,
    required this.followingsUsersList,
  });
}