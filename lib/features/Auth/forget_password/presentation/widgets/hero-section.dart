import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';

class HeroSection extends StatelessWidget {
  final String head1;
  final String? head2;
  final String welcomeParagph;
  const HeroSection({
    super.key,
    required this.head1,
    this.head2,
    required this.welcomeParagph,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(head1, style: AppTextStyle.font48BlackW700.copyWith(fontSize: 32)),
        Text(
          head2 ?? '',
          style: AppTextStyle.font48BlackW700.copyWith(
            color: AppColors.navBarBlue,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 4),
        Text(welcomeParagph, style: AppTextStyle.font16Grey4EW400),
      ],
    );
  }
}
