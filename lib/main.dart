import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/app/app_cubit/app_cubit.dart';
import 'package:news_app/core/global/theme/theme_data/theme_data_dark.dart';
import 'package:news_app/core/global/theme/theme_data/theme_data_light.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/HomePage/presentation/widgets/notification_services.dart';
import 'package:news_app/core/utils/service_locator.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationServices().initNotifications();
  startServiceLocator();
  await Supabase.initialize(
    url: AppConstants.projectUrl,
    anonKey: AppConstants.anonKey,
  );

  runApp(const NewsApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocProvider(
        create: (context) => AppCubit(),
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRoutes.routes,
              theme: getThemeDataLight(),
              darkTheme: getThemeDataDark(),
              themeMode: AppCubit.get(context).getTheme(),
            );
          },
        ),
      ),
    );
  }
}
