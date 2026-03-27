import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_text_style.dart';

class ProfileStatItem extends StatelessWidget {
  const ProfileStatItem({super.key, required this.count, required this.label});
  final String count;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: AppTextStyle.font16BlackW600),
        Text(label, style: AppTextStyle.text16RegularGrey),
      ],
    );
  }
}
