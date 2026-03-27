import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/utils/service_locator.dart';
import 'package:news_app/features/news/data/models/category_model.dart';
import 'package:news_app/features/news/data/repo/category_repo/category_repo_implementation.dart';
import 'package:news_app/core/storage/local_storage.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  final repo = getIt.get<CategoryRepoImplementation>();
  Future<String> get _userId async => await LocalStorage.getUserId();
  Future<dynamic> getSavedCategories() async {
    emit(GetCategoriesLoading());
    try {
      final userId = await _userId;
      final List<CategoryModel> categories = await repo.getSavedCategories(
        userId,
      );
      emit(GetCategoriesSuccess(categories: categories));
    } catch (e) {
      emit(GetCategoriesFailed(errMsg: e.toString()));
    }
  }
}
