import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_text_style.dart';

class CategoryFilterTabs extends StatefulWidget {
  final Function(String) onCategorySelected;
  final String? selectCats;
  const CategoryFilterTabs({super.key, required this.onCategorySelected,  this.selectCats = 'all'});

  @override
  State<CategoryFilterTabs> createState() => _CategoryFilterTabsState();
}

class _CategoryFilterTabsState extends State<CategoryFilterTabs> {
 final List<String> categories = [
   'All', 'Sports', 'Politics', 'Business', 'Health', 'Travel', 'Science'
  ];
 String selectedCategory = 'All';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final isSelected = category == widget.selectCats;
          return GestureDetector(
            onTap: () {
              setState(() => selectedCategory = category);
              widget.onCategorySelected(category);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.navBarBlue : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                category,
                style: isSelected
                    ? AppTextStyle.font14Grey4ERegular.copyWith(
                  color: AppColors.navBarBlue,
                  fontWeight: FontWeight.w600,
                )
                    : AppTextStyle.font14Grey4ERegular,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}