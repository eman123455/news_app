import 'package:news_app/features/Explore/data/model/explore_model.dart';

abstract class ExploreRepository {
  Future<List<ExploreModel>> getAllExploresNews();
}