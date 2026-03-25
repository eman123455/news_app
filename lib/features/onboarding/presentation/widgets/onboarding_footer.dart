import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_buttons_style.dart';
import 'package:news_app/core/resources/app_colors.dart';
import 'package:news_app/core/resources/app_text_style.dart';
import 'package:news_app/core/ui_constants/ui_constants.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    super.key,
    required this.onNextPressed,
    required this.onBackPressed,
    required this.pageIndex,
  });

  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0, left: 24.0, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Dots Indicator
          Row(
            children: List.generate(
              UiConstants.onboardingItems.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: pageIndex == index ? 10 : 8,
                height: pageIndex == index ? 10 : 8,
                decoration: BoxDecoration(
                  color: pageIndex == index
                      ? AppColors.navBarBlue
                      : AppColors.greyB0,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const Spacer(),
          if (pageIndex != 0)
            TextButton(
              onPressed: onBackPressed,
              child: Text(
                'Back',
                style: AppTextStyle.font16BlackW600.copyWith(
                  color: AppColors.greyB0,
                ),
              ),
            )
          else
            const SizedBox(),

          ElevatedButton(
            onPressed: onNextPressed,
            style: AppButtonsStyle.primaryButtonStyle,
            child: Text(
              pageIndex == UiConstants.onboardingItems.length - 1
                  ? 'Get Started'
                  : 'Next',
              style: AppTextStyle.font16BlackW600.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
