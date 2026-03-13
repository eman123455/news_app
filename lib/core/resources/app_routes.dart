import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/HomePage/presentation/home_page.dart';
import 'package:news_app/features/splash/presentation/views/splash_view.dart';


class AppRoutes {
  static const String kSplashView = '/';
  

  static GoRouter routes = GoRouter(
    routes: [
      // GoRoute(path: kSplashView, builder: (context, state) => SplashView()),
      GoRoute(path: '/',
      builder: (context, state) => HomePage())
  
    ],
    redirect: (context, state) async {
    
    },
  );
}
