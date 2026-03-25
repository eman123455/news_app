import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';

class SettingsInfoRow extends StatelessWidget {
  const SettingsInfoRow({
    super.key,
    required this.prefexIcon,
    required this.text,
    this.trailing,
    this.onPressed,
  });

  final IconData prefexIcon;
  final String text;
  final Widget? trailing;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(prefexIcon, color: AppColors.kblack05),
            SizedBox(width: 12),
            Text(text, style: AppTextStyle.text16Regular),
            Spacer(),
            ?trailing,
          ],
        ),
      ),
    );
  }
}
