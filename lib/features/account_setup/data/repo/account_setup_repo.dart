import 'package:news_app/features/account_setup/data/models/news_source_model.dart';

abstract class AccountSetupRepo {
  Future<List<NewsSourceModel>> getSources({String? country});
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
  });
}
