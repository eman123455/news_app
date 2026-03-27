import 'package:get_it/get_it.dart';
import 'package:news_app/features/news/data/news_web_services/category_web_services.dart';
import 'package:news_app/features/news/data/news_web_services/posts_web_services.dart';
import 'package:news_app/features/news/data/repo/category_repo/category_repo_implementation.dart';
import 'package:news_app/features/news/data/repo/news_repo_implementation.dart';
import 'package:news_app/features/profile/data/profile_web_services/profile_web_services.dart';
import 'package:news_app/features/profile/data/repo/profile_repo_implementation.dart';

final getIt = GetIt.instance;
void startServiceLocator() {
  getIt.registerSingleton<ProfileRepoImplementation>(
    ProfileRepoImplementation(ProfileWebServices()),
  );
  getIt.registerSingleton<CategoryRepoImplementation>(
    CategoryRepoImplementation(CategoryWebServices()),
  );
  getIt.registerSingleton<NewsRepoImplementation>(
    NewsRepoImplementation(PostsWebServices()),
  );
}
