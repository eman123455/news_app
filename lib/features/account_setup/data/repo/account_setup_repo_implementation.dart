import 'package:news_app/features/account_setup/data/account_setup_web_services/account_setup_web_services.dart';
import 'package:news_app/features/account_setup/data/models/source_model.dart';
import 'package:news_app/features/account_setup/data/repo/account_setup_repo.dart';

class AccountSetupRepoImplementation implements AccountSetupRepo {
  final AccountSetupWebServices _webServices;

  AccountSetupRepoImplementation({AccountSetupWebServices? webServices})
      : _webServices = webServices ?? AccountSetupWebServices();

  @override
  Future<List<SourceModel>> getSources({
    String? category,
    String? country,
  }) async {
    return await _webServices.getSources(
      category: category,
      country: country,
    );
  }

  @override
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
    await _webServices.saveProfile(
      userId: userId,
      username: username,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      topics: topics,
      sources: sources,
      profileImageUrl: profileImageUrl,
    );
  }
}