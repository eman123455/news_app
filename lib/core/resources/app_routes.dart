import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/storage/local_storage.dart';
import 'package:news_app/core/components/nav_bar.dart';
import 'package:news_app/features/Auth/SignUp/data/sign_up_web_services/sign_up_web_services.dart';
import 'package:news_app/features/Auth/SignUp/presentation/views/sign_up.dart';
import 'package:news_app/features/Auth/SignUp/sign_up_business_logic/sign_up_cubit/sign_up_cubit.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/confime_reset_pass.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/forget_pass_view.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/otp_view.dart';
import 'package:news_app/features/Auth/forget_password/presentation/views/reset_password_view.dart';
import 'package:news_app/features/Auth/login/data/login_web_services/login_web_services.dart';
import 'package:news_app/features/Auth/login/login_business_logic/login_cubit/login_cubit.dart';
import 'package:news_app/features/Auth/login/presentation/views/login.dart';
import 'package:news_app/features/BookMark/presentation/views/book_mark_view.dart';
import 'package:news_app/features/Explore/data/model/explore_model.dart';
import 'package:news_app/features/Explore/data/repo/explore_repo_implementation.dart';
import 'package:news_app/features/Explore/network/dio_client.dart';
import 'package:news_app/features/Explore/presentation/bloc/explore_cubit.dart';
import 'package:news_app/features/Explore/presentation/view/explore_view.dart';
import 'package:news_app/features/HomePage/Data/RepositryImp/repo_imp.dart';
import 'package:news_app/features/HomePage/Domain/UsesCase/use_case_news.dart';
import 'package:news_app/features/HomePage/presentation/home_page.dart';
import 'package:news_app/features/HomePage/presentation/logic/news_bloc.dart';
import 'package:news_app/features/HomePage/presentation/logic/news_event.dart';
import 'package:news_app/features/Trending/presentation/views/trending_view.dart';
import 'package:news_app/features/account_setup/account_setup_business_logic/cubit/account_setup_cubit.dart';
import 'package:news_app/features/account_setup/data/repo/account_setup_repo_implementation.dart';
import 'package:news_app/features/account_setup/presentation/views/acount_setup.dart';
import 'package:news_app/features/news/presentation/views/news_details_view.dart';
import 'package:news_app/features/news/news_business_logic/news_cubit/news_cubit.dart';
import 'package:news_app/features/news/presentation/views/create_news_view.dart';
import 'package:news_app/features/news/presentation/views/edit_news_view.dart';
import 'package:news_app/features/news/presentation/views/news_view.dart';
import 'package:news_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:news_app/features/profile/data/models/post_model/post_model.dart';
import 'package:news_app/features/profile/data/models/profile_model.dart';
import 'package:news_app/features/profile/presentation/views/edit_profile_view.dart';
import 'package:news_app/features/profile/presentation/views/profile_view.dart';
import 'package:news_app/features/profile/profile_business_logic/profile_cubit/profile_cubit.dart';
import 'package:news_app/features/settings/presentation/views/settings_view.dart';

import '../../features/HomePage/Data/RepositryImp/repo_imp.dart';
import '../../features/HomePage/Domain/UsesCase/use_case_news.dart';
import '../../features/HomePage/presentation/logic/news_bloc.dart';
import '../../features/HomePage/presentation/logic/news_event.dart';

class AppRoutes {
  static const String kSplashView = '/';
  static const String kNavBar = '/NaveBar';
  static const String kExplore = '/Explore';
  static const String kOnboardingView = '/OnboardingView';
  static const String kForgetPassView = '/ForgetPassView';
  static const String kLogin = '/Login';
  static const String kSignUp = '/SignUp';
  static const String kAcountSetup = '/AcountSetup';
  static const String kBookMarkView = '/BookMarkView';
  static const String kHomePage = '/HomePage';
  static const String kProfileView = '/ProfileView';
  static const String kSettingsView = '/SettingsView';
  static const String kOtpView = '/OtpView';
  static const String kResetPassView = '/ResetPassView';
  static const String kTrendingView = '/TrendingView';
  static const String kNewsDetailsView = '/newsDetailsView';
  static const String kConfirmePassView = '/ConfirmePassView';
    static const String kEditProfileView = '/EditProfileView';
  static const String kSetupProfileView = '/SetupProfileView';
  static const String kCreateNewsView = '/CreateNewsView';
  static const String kEditNewsView = '/EditNewsView';
  static const String kNewsView = '/NewsView';

  static GoRouter routes = GoRouter(
    routes: [
      // GoRoute(path: kSplashView, builder: (context, state) => NavBar()),
      GoRoute(path: kSplashView, builder: (context, state) => OnboardingView()),
      GoRoute(path: kNavBar, builder: (context, state) => NavBar()),
      GoRoute(
        path: kExplore,
        builder: (context, state) => BlocProvider(
          create: (_) => ExploreCubit(
            ExploreRepositoryImpl(client: DioClient()),
          )..getExplores(),
          child: const Explore(),
        ),
      ),
      GoRoute(
        path: kNewsDetailsView,
        builder: (context, state) => NewsDetailsView(
          explore: state.extra as ExploreModel,
        ),
      ),
      GoRoute(
        path: kLogin,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => LoginCubit(LoginWebServices()),
            child: Login(),
          );
        },
      ),
      GoRoute(
        path: kSignUp,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => SignUpCubit(SignUpWebServices()),
            child: SignUp(),
          );
        },
      ),
      GoRoute(path: kAcountSetup, builder: (context, state) => AcountSetup()),
      GoRoute(path: kBookMarkView, builder: (context, state) => BookMarkView()),
      GoRoute(path: kHomePage, builder: (context, state) => HomePage()),
      GoRoute(path: kProfileView, builder: (context, state) => ProfileView()),
      GoRoute(path: kSettingsView, builder: (context, state) => SettingsView()),
      GoRoute(path: kOtpView, builder: (context, state) => OtpScreen()),
      GoRoute(
        path: kResetPassView,
        builder: (context, state) => ResetPasswordView(),
      ),
      GoRoute(
        path: kAcountSetup,
        builder: (context, state) => BlocProvider(
          create: (_) => AccountSetupCubit(AccountSetupRepoImplementation()),
          child: AcountSetup(),
        ),
      ),

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
      GoRoute(
        path: kHomePage,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              NewsBloc(UseCaseNews(RepoImpl()))..add(FetchNews(category: null)),
          child:  HomePage(),
        ),
      ),
      GoRoute(path: kProfileView, builder: (context, state) => ProfileView()),
      // GoRoute(
      //   path: kSetupProfileView,
      //   builder: (context, state) => SetupProfileView(),
      // ),
      GoRoute(path: kBookMarkView, builder: (context, state) => BookMarkView()),
      GoRoute(path: kHomePage, builder: (context, state) => HomePage()),
      GoRoute(path: kNewsView, builder: (context, state) => NewsView()),
      GoRoute(
        path: kCreateNewsView,
        builder: (context, state) => BlocProvider(
          create: (context) => NewsCubit(),
          child: CreateNewsView(),
        ),
      ),
      GoRoute(
        path: kEditNewsView,
        builder: (context, state) {
          final post = state.extra as PostModel;
          return BlocProvider(
            create: (context) => NewsCubit(),
            child: EditNewsView(postModel: post),
          );
        },
      ),
      GoRoute(path: kProfileView, builder: (context, state) => ProfileView()),
      GoRoute(
        path: kEditProfileView,
        builder: (context, state) {
          final profile = state.extra as ProfileModel;
          return BlocProvider(
            create: (context) => ProfileCubit(),
            child: EditProfileView(profile: profile),
          );
        },
      ),
      GoRoute(path: kSettingsView, builder: (context, state) => SettingsView()),
    ],
    redirect: (context, state) async {
      final seen = await LocalStorage.hasSeenOnboarding();
      final user = await LocalStorage.getUserId();

      final currentLocation = state.matchedLocation;

      // Skip redirect if on reset-password or confirm-reset-password
      if (currentLocation == AppRoutes.kResetPassView ||
          currentLocation == AppRoutes.kConfirmePassView) {
        return null;
      }

      // onboarding
      if (!seen) {
        return AppRoutes.kOnboardingView;
      }

      // user logged in →home
      if (user != null && user.isNotEmpty) {
        if (currentLocation == AppRoutes.kLogin ||
            currentLocation == AppRoutes.kOnboardingView ||
            currentLocation == AppRoutes.kSplashView) {
          return AppRoutes.kNavBar;
        }
      }
     
      // not logged in →login
      if (currentLocation == AppRoutes.kSplashView ||
          currentLocation == AppRoutes.kOnboardingView) {
        return AppRoutes.kLogin;
      }

      return null;
    },
  );
}