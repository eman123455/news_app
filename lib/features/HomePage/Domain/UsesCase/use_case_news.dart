import 'package:news_app/features/HomePage/Data/RepositryImp/repo_imp.dart';
import 'package:news_app/features/HomePage/Domain/Entity/article_entity.dart';


class UseCaseNews {
  final RepoImpl _repoImpl;
  UseCaseNews(this._repoImpl);
  Future<List<ArticleEntity>> call({String? category}) async {
    return _repoImpl.getTopHeadLineNews(category: category);

  }

}