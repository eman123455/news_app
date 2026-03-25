import 'package:news_app/features/HomePage/Domain/Entity/article_entity.dart';

abstract class Repository{
  Future<List<ArticleEntity>> getTopHeadLineNews ({String? country, String? category});

}