import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/Auth/SignUp/presentation/views/sign_up.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/forget_pass_view.dart';
import 'package:news_app/features/Auth/login/presentation/views/login.dart';
import 'package:news_app/features/BookMark/presentation/views/book_mark_view.dart';
import 'package:news_app/features/HomePage/presentation/home_page.dart';
import 'package:news_app/features/account_setup/business_logic/cubit/account_setup_cubit.dart';
import 'package:news_app/features/account_setup/data/repo/account_setup_repo_implementation.dart';
import 'package:news_app/features/account_setup/presentation/views/account_setup.dart';
import 'package:news_app/features/account_setup/presentation/screens/choose_topics_view.dart';
import 'package:news_app/features/account_setup/presentation/screens/choose_sources_view.dart';
import 'package:news_app/features/account_setup/presentation/screens/fill_profile_view.dart';
import 'package:news_app/features/account_setup/presentation/screens/select_country_view.dart';
import 'package:news_app/features/news/presentation/views/news_view.dart';
import 'package:news_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:news_app/features/profile/presentation/profile_view.dart';
import 'package:news_app/features/settings/presentation/views/settings_view.dart';
import 'package:news_app/features/splash/presentation/views/splash_view.dart';
import '../../features/Explore/presentation/view/explore_view.dart';

class AppRoutes {
  static const String kSplashView = '/';
  static const String kExplore = '/Explore';
  static const String kOnboardingView = '/OnboardingView';
  static const String kForgetPassView = '/ForgetPassView';
  static const String kLogin = '/Login';
  static const String kSignUp = '/SignUp';
  static const String kAccountSetup = '/AccountSetup';
  
  static const String kSelectCountry = '/SelectCountry';
  static const String kChooseTopics = '/ChooseTopics';
  static const String kChooseSources = '/ChooseSources';
  static const String kFillProfile = '/FillProfile';

  static const String kBookMarkView = '/BookMarkView';
  static const String kHomePage = '/HomePage';
  static const String kNewsView = '/NewsView';
  static const String kProfileView = '/ProfileView';
  static const String kSettingsView = '/SettingsView';

  static GoRouter routes = GoRouter(
    routes: [
      GoRoute(path: kSplashView, builder: (context, state) => const OnboardingView()),
      GoRoute(path: kExplore, builder: (context, state) => Explore()),
      GoRoute(path: kOnboardingView, builder: (context, state) => const OnboardingView()),
      GoRoute(path: kForgetPassView, builder: (context, state) => ForgetPassView()),
      GoRoute(path: kLogin, builder: (context, state) => Login()),
      GoRoute(path: kSignUp, builder: (context, state) => SignUp()),
      
      // Account Setup Flow with Shared Cubit
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
            create: (_) => AccountSetupCubit(AccountSetupRepoImplementation()),
            child: child,
          );
        },
        routes: [
          GoRoute(path: kAccountSetup, builder: (context, state) => const AccountSetup()),
          GoRoute(path: kSelectCountry, builder: (context, state) => const SelectCountryView()),
          GoRoute(path: kChooseTopics, builder: (context, state) => const ChooseTopicsView()),
          GoRoute(path: kChooseSources, builder: (context, state) => const ChooseSourcesView()),
          GoRoute(path: kFillProfile, builder: (context, state) => const FillProfileView()),
        ],
      ),

      GoRoute(path: kBookMarkView, builder: (context, state) => BookMarkView()),
      GoRoute(path: kHomePage, builder: (context, state) => HomePage()),
      GoRoute(path: kNewsView, builder: (context, state) => NewsView()),
      GoRoute(path: kProfileView, builder: (context, state) => ProfileView()),
      GoRoute(path: kSettingsView, builder: (context, state) => SettingsView()),
    ],
    redirect: (context, state) async {},
  );
}
