import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/news/data/models/category_model.dart';
import 'package:news_app/features/news/data/repo/category_repo/category_repo_implementation.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  final repo = getIt.get<CategoryRepoImplementation>();
  final userId = '062b90f8-49cd-4911-8d3a-265924aa0597';
  Future<dynamic> getSavedCategories() async {
    emit(GetCategoriesLoading());
    try {
      final List<CategoryModel> categories = await repo.getSavedCategories(
        userId,
      );
      emit(GetCategoriesSuccess(categories: categories));
    } catch (e) {
      emit(GetCategoriesFailed(errMsg: e.toString()));
    }
  }
}
