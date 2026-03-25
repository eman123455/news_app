import '../../Domain/Entity/article_entity.dart';
import '../models/results.dart';

extension ResultMapper on Results {
  ArticleEntity toEntity() {
    return ArticleEntity(
      title: title,
      description: description,
      urlToImage: imageUrl,
      publishedAt: pubDate,
      sourceName: sourceName,
      sourceIcon: sourceIcon,
    );
  }
}