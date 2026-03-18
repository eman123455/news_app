import 'package:news_app/features/account_setup/data/models/source_model.dart';

abstract class AccountSetupRepo {
  Future<List<SourceModel>> getSources({String? category, String? country});
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
  });
}