import 'package:news_app/core/resources/app_images.dart';
import 'package:news_app/features/onboarding/presentation/ui_model/onbaording_item.dart';

class UiConstants {
  UiConstants._();

  static final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      imageUrl: AppImages.onboarding1,
      description:
          'Get the latest news from around the world in one place. Stay informed with breaking stories and trending topics.',
      title: 'Stay Updated Anytime',
    ),
    OnboardingItem(
      imageUrl: AppImages.onboarding2,
      description:
          'Discover news across different categories like technology, business, sports, and more.',
      title: 'Explore What Matters to You',
    ),
    OnboardingItem(
      imageUrl: AppImages.onboarding3,
      description:
          'Bookmark your favorite articles and read them anytime, even when you\'re on the go.',
      title: 'Save and Read Later',
    ),
  ];
}
