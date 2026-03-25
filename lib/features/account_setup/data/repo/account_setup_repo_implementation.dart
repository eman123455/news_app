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

  static const String _table = 'account_setup';
  static const String _userIdColumn = 'user_id';
  static const String _countryCodeColumn = 'country_code';
  static const String _countryNameColumn = 'country_name';
  static const String _topicsColumn = 'topics';
  static const String _sourceIdsColumn = 'source_ids';
  static const String _usernameColumn = 'username';
  static const String _fullNameColumn = 'full_name';
  static const String _emailColumn = 'email';
  static const String _phoneColumn = 'phone';

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

    // NOTE:
    // These column/table names must match your Supabase schema.
    // If your project uses different names, update the constants above.
    final payload = <String, dynamic>{
      _countryCodeColumn: countryCode,
      _countryNameColumn: countryName,
      _topicsColumn: topics,
      _sourceIdsColumn: sourceIds,
      _usernameColumn: username,
      _fullNameColumn: fullName,
      _emailColumn: email,
      _phoneColumn: phone,
    };

    try {
      if (userId != null && userId.isNotEmpty) {
        payload[_userIdColumn] = userId;
        await supabase
            .from(_table)
            .upsert(payload, onConflict: _userIdColumn)
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
