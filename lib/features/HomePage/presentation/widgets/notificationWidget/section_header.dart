import 'package:flutter/cupertino.dart';
import 'package:news_app/core/resources/app_text_style.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: AppTextStyle.font16BlackW600.copyWith(
          fontSize: 14,)

        ),

    );
  }
}
