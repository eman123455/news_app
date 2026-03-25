import 'dart:convert';

import 'package:news_app/features/account_setup/data/account_setup_web_services/account_setup_web_services.dart';
import 'package:news_app/features/account_setup/data/models/news_source_model.dart';
import 'package:news_app/features/account_setup/data/repo/account_setup_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountSetupRepoImplementation implements AccountSetupRepo {
  final AccountSetupWebServices _webServices;

  AccountSetupRepoImplementation({AccountSetupWebServices? webServices})
      : _webServices = webServices ?? AccountSetupWebServices();

  @override
  Future<List<NewsSourceModel>> getSources({String? country}) {
    return _webServices.fetchSources(country: country);
  }

  static const String _table = 'profiles';

  static const String _idColumn = 'id';
  static const String _usernameColumn = 'username';
  static const String _fullNameColumn = 'full_name';
  static const String _emailColumn = 'email';
  static const String _phoneColumn = 'phone';
  static const String _countryColumn = 'country';
  static const String _bioColumn = 'bio';

  @override
  Future<void> saveAccountSetup({
    String? userId,
    required String countryCode,
    required String countryName,
    required List<String> topics,
    required List<String> sourceIds,
    required String username,
    required String fullName,
    required String email,
    required String phone,
  }) async {
    final supabase = Supabase.instance.client;

    // Matches existing public.profiles: id, username, full_name, email, phone,
    // bio, country, … (no country_code / topics / source_ids columns).
    final payload = <String, dynamic>{
      _usernameColumn: username,
      _fullNameColumn: fullName,
      _emailColumn: email,
      _phoneColumn: phone,
      _countryColumn: '$countryName ($countryCode)',
      _bioColumn: jsonEncode(<String, dynamic>{
        'topics': topics,
        'source_ids': sourceIds,
        'country_code': countryCode,
        'country_name': countryName,
      }),
    };

    try {
      if (userId != null && userId.isNotEmpty) {
        payload[_idColumn] = userId;
        await supabase
            .from(_table)
            .upsert(payload, onConflict: _idColumn)
            .select();
      } else {
        await supabase.from(_table).insert(payload).select();
      }
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
