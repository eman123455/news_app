import 'package:news_app/features/news/data/news_web_services/category_web_services.dart';
import 'package:news_app/features/news/data/repo/category_repo/category_repo.dart';

class CategoryRepoImplementation implements CategoryRepo {
  late CategoryWebServices categoryWebServices;
  CategoryRepoImplementation(this.categoryWebServices);
  @override
  Future<dynamic> getSavedCategories(String userId) async {
    final response = await categoryWebServices.getSavedCategories(userId);
    return response;
  }
}
