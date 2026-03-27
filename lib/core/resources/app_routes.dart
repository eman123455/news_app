import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/HomePage/presentation/home_page.dart';
<<<<<<< Updated upstream
import 'package:news_app/features/splash/presentation/views/splash_view.dart';

=======
import 'package:news_app/features/HomePage/presentation/widgets/notification_screen.dart';
import 'package:news_app/features/account_setup/presentation/views/acount_setup.dart';
import 'package:news_app/features/news/presentation/widgets/comments_bottom_sheet.dart';
import 'package:news_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:news_app/features/profile/presentation/profile_view.dart';
import 'package:news_app/features/settings/presentation/views/settings_view.dart';
>>>>>>> Stashed changes
import '../../features/Explore/presentation/view/explore_view.dart';
import '../components/nav_bar.dart';


class AppRoutes {
  static const String kSplashView = '/';
<<<<<<< Updated upstream
=======
  static const String kExplore= '/Explore';
  static const String kOnboardingView = '/OnboardingView ';
  static const String kForgetPassView = '/ForgetPassView ';
  static const String kLogin= '/Login';
  static const String kSignUp= '/SignUp';
  static const String kAcountSetup= '/AcountSetup';
  static const String kBookMarkView= '/BookMarkView';
  static const String kHomePage= '/HomePage';
  static const String kNewsView= '/NewsView';
  static const String kProfileView= '/ProfileView';
  static const String kSettingsView= '/SettingsView';
  static const String kNotificationView= '/NotificationView';
>>>>>>> Stashed changes
  

  static GoRouter routes = GoRouter(
    routes: [
<<<<<<< Updated upstream
      // GoRoute(path: kSplashView, builder: (context, state) => SplashView()),
      GoRoute(
        path: '/',
            builder: (context, state) => NavBar(),
=======
      GoRoute(path: kSplashView, builder: (context, state) => NavBar()),
      GoRoute(path: kSplashView, builder: (context, state) => OnboardingView()),

      GoRoute(path: kExplore,builder: (context, state) => Explore()),
      GoRoute(path: kOnboardingView ,builder: (context, state) => OnboardingView()),
      GoRoute(path: kForgetPassView ,builder: (context, state) => ForgetPassView()),
      GoRoute(path: kLogin ,builder: (context, state) => Login()),
      GoRoute(path: kSignUp ,builder: (context, state) => SignUp()),
      GoRoute(path: kAcountSetup ,builder: (context, state) => AcountSetup()),
      GoRoute(path: kBookMarkView ,builder: (context, state) => BookMarkView()),
      GoRoute(path: kNotificationView ,builder: (context, state) => NotificationScreen()),

      GoRoute(
        path: kHomePage,
        builder: (context, state) => BlocProvider(
          create: (context) => NewsBloc(
            UseCaseNews(RepoImpl()),
          )..add(FetchNews(category: null)),
          child: const HomePage(),
        ),

      ),
      GoRoute(
        path: '/post/:postId',
        builder: (context, state) {
          final postId = state.pathParameters['postId']!;
          return CommentsSheet();
        },
>>>>>>> Stashed changes
      ),
      GoRoute(path: '/',
      builder: (context, state) => HomePage()),
      GoRoute(path: '/explore',
      builder: (context, state) => Explore()),

  
    ],
    redirect: (context, state) async {},
  );
}
