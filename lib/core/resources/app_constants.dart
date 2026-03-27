import 'package:supabase_flutter/supabase_flutter.dart';

class AppConstants {
  static const String anonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNlZXZjcXlscGV3Ymt6aWRyem1uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMyMzgwMzgsImV4cCI6MjA4ODgxNDAzOH0.DA4awwFsENzn_0v-07HfDBb7jtBWNf7jKcdf-k8ctV4';
  static const String projectUrl = 'https://seevcqylpewbkzidrzmn.supabase.co';
  static const String baseUrl = 'https://newsdata.io/api/1';
  static const String apiKey = 'pub_1eff6f268df8451fb392023a14582d83';
  static const String baseUrlS =
      'https://seevcqylpewbkzidrzmn.supabase.co/rest/v1';
  static final supabase = Supabase.instance.client;
}
