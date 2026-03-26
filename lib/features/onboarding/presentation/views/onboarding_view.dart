import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/core/storage/local_storage.dart';
import 'package:news_app/core/ui_constants/ui_constants.dart';
import 'package:news_app/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:news_app/features/onboarding/presentation/widgets/onboarding_screen.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .spaceBetween,
            children: [
              OnboardingScreen(pageIndex: pageIndex),
              OnboardingFooter(
                pageIndex: pageIndex,
                onBackPressed: () {
                  setState(() {
                    pageIndex--;
                  });
                },
                onNextPressed: () async {
                  if (pageIndex == UiConstants.onboardingItems.length - 1) {
                    // Last page → save flag and navigate
                    await LocalStorage.setOnboardingSeen();
                    if (mounted) {
                      context.go(AppRoutes.kLogin);
                    }
                  } else {
                    setState(() {
                      pageIndex++; // Only update state synchronously
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
