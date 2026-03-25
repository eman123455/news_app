import 'package:flutter/material.dart';
import 'package:news_app/core/ui_constants/ui_constants.dart';

import '../../../../core/resources/app_text_style.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Image.asset(
          UiConstants.onboardingItems[pageIndex].imageUrl,
          width: .infinity,
          height: MediaQuery.of(context).size.height * 0.65,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            UiConstants.onboardingItems[pageIndex].title,
            style: AppTextStyle.font24BlackW700,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            UiConstants.onboardingItems[pageIndex].description,
            style: AppTextStyle.font14Grey4ERegular,
          ),
        ),
      ],
    );
  }
}
