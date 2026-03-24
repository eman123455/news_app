import 'package:go_router/go_router.dart';
import 'package:news_app/features/Auth/SignUp/presentation/views/sign_up.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/confime_reset_pass.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/forget_pass_view.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/otp_view.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/reset_password_view.dart';
import 'package:news_app/features/Auth/login/presentation/views/login.dart';
import 'package:news_app/features/BookMark/presentation/views/book_mark_view.dart';
import 'package:news_app/features/HomePage/presentation/home_page.dart';
import 'package:news_app/features/account_setup/presentation/views/acount_setup.dart';
import 'package:news_app/features/news/presentation/views/news_view.dart';
import 'package:news_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:news_app/features/profile/presentation/profile_view.dart';
import 'package:news_app/features/settings/presentation/views/settings_view.dart';
import '../../features/Explore/presentation/view/explore_view.dart';

class AppRoutes {
  static const String kSplashView = '/';
  static const String kExplore = '/Explore';
  static const String kOnboardingView = '/OnboardingView';
  static const String kForgetPassView = '/ForgetPassView';
  static const String kLogin = '/Login';
  static const String kSignUp = '/SignUp';
  static const String kAcountSetup = '/AcountSetup';
  static const String kBookMarkView = '/BookMarkView';
  static const String kHomePage = '/HomePage';
  static const String kNewsView = '/NewsView';
  static const String kProfileView = '/ProfileView';
  static const String kSettingsView = '/SettingsView';
  static const String kOtpView = '/OtpView';
  static const String kResetPassView = '/ResetPassView';
  static const String kConfirmePassView = '/ConfirmePassView';

  static GoRouter routes = GoRouter(
    routes: [
      GoRoute(path: kSplashView, builder: (context, state) => OnboardingView()),
      GoRoute(path: kExplore, builder: (context, state) => Explore()),
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => OnboardingView(),
      ),
      GoRoute(
        path: kForgetPassView,
        builder: (context, state) => ForgetPassView(),
      ),
      GoRoute(path: kLogin, builder: (context, state) => Login()),
      GoRoute(path: kSignUp, builder: (context, state) => SignUp()),
      GoRoute(path: kAcountSetup, builder: (context, state) => AcountSetup()),
      GoRoute(path: kBookMarkView, builder: (context, state) => BookMarkView()),
      GoRoute(path: kHomePage, builder: (context, state) => HomePage()),
      GoRoute(path: kNewsView, builder: (context, state) => NewsView()),
      GoRoute(path: kProfileView, builder: (context, state) => ProfileView()),
      GoRoute(path: kSettingsView, builder: (context, state) => SettingsView()),
      GoRoute(path: kOtpView, builder: (context, state) => OtpScreen()),
      GoRoute(
        path: kResetPassView,
        builder: (context, state) => ResetPasswordView(),
      ),
      GoRoute(
        path: kConfirmePassView,
        builder: (context, state) => ConfimeResetPass(),
      ),
    ],
    redirect: (context, state) async {},
  );
}
