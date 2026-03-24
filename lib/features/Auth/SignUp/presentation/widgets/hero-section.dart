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
        const SizedBox(height: 60),
        Text(head1, style: AppTextStyle.font48BlackW700),
        Text(
          head2 ?? '',
          style: AppTextStyle.font48BlackW700.copyWith(
            color: AppColors.navBarBlue,
          ),
        ),
        const SizedBox(height: 8),
        Text(welcomeParagph, style: AppTextStyle.font20GreyW400),
      ],
    );
  }
}
