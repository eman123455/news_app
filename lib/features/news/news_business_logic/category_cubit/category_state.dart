part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class GetCategoriesSuccess extends CategoryState {
  final List<CategoryModel> categories;
  const GetCategoriesSuccess({required this.categories});
}

final class GetCategoriesFailed extends CategoryState {
  final String errMsg;

  const GetCategoriesFailed({required this.errMsg});
}

final class GetCategoriesLoading extends CategoryState {}
