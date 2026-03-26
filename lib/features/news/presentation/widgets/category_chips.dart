import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/components/custom_circular_progress_indicator.dart';
import 'package:news_app/features/news/news_business_logic/category_cubit/category_cubit.dart';

typedef CategorySelectedCallback = void Function(String categoryId);

class CategoryChips extends StatefulWidget {
  final CategorySelectedCallback? onCategorySelected;
  final String? selectedCategoryId;
  const CategoryChips({super.key, this.onCategorySelected, this.selectedCategoryId});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  late String selectedCategoryId;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.selectedCategoryId ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getSavedCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is GetCategoriesLoading) {
            return CustomCircularProgressIndicator();
          } else if (state is GetCategoriesSuccess) {
            final categories = state.categories;
            return SizedBox(
              height: 45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected =
                      selectedCategoryId == ((category.id?.toString()) ?? '');
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategoryId = category.id?.toString() ?? '';
                      });
                      if (widget.onCategorySelected != null &&
                          category.id != null) {
                        widget.onCategorySelected!(category.id!.toString());
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        category.name ?? '',
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is GetCategoriesFailed) {
            return Text(state.errMsg);
          }
          return const Placeholder();
        },
      ),
    );
  }
}
