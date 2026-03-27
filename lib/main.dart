<<<<<<< Updated upstream
=======
  import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

<<<<<<< Updated upstream
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConstants.projectUrl,
    anonKey: AppConstants.anonKey,
  );

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.routes,
      ),
    );
=======
  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
  void main() async{
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await NotificationServices().initNotifications();

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
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.routes,
        ),
      );
    }
>>>>>>> Stashed changes
  }
}
