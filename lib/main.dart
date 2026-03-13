import 'package:flutter/material.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/core/resources/app_routes.dart';
import 'package:news_app/features/HomePage/presentation/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: AppRoutes.routes,

    );
  }
}
