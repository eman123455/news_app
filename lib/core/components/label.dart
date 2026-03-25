import 'package:flutter/cupertino.dart';
import 'package:news_app/core/resources/app_text_style.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title, style: AppTextStyle.font14Grey4ERegular),
      ),
    );
  }
}
