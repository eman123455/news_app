import 'package:dio/dio.dart';
import 'package:news_app/core/resources/app_constants.dart';
import 'package:news_app/features/account_setup/data/models/source_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountSetupWebServices {
  final Dio _dio;
  final SupabaseClient _supabase = Supabase.instance.client;

  AccountSetupWebServices({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetches news sources from NewsAPI.
  /// Optionally filtered by [category] and [country].
  Future<List<SourceModel>> getSources({
    String? category,
    String? country,
  }) async {
    final queryParams = <String, dynamic>{
      'apiKey': AppConstants.newsApiKey,
      if (category != null && category.isNotEmpty) 'category': category,
      if (country != null && country.isNotEmpty) 'country': country,
    };

    final response = await _dio.get(
      '${AppConstants.newsApiBaseUrl}/top-headlines/sources',
      queryParameters: queryParams,
    );

    final List<dynamic> rawSources = response.data['sources'] as List<dynamic>;
    return rawSources
        .map((json) => SourceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Saves the user profile and preferences to Supabase.
  Future<void> saveProfile({
    required String userId,
    required String username,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required List<String> topics,
    required List<String> sources,
    String? profileImageUrl,
  }) async {
    await _supabase.from('profiles').upsert({
      'id': userId,
      'username': username,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'country_code': countryCode,
      'topics': topics,
      'followed_sources': sources,
      'profile_image_url': profileImageUrl,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}