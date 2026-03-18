import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/account_setup/data/models/country_model.dart';
import 'package:news_app/features/account_setup/data/models/source_model.dart';
import 'package:news_app/features/account_setup/data/repo/account_setup_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  final AccountSetupRepo _repo;

  AccountSetupCubit(this._repo) : super(AccountSetupInitial());

  // Selection state
  CountryModel? selectedCountry;
  final Set<String> selectedTopics = {};
  final Set<String> followedSources = {};
  List<SourceModel> sources = [];

  // Profile data
  String username = '';
  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String? profileImageUrl;

  // ─── Country ───────────────────────────────────────────────────────────────
  void selectCountry(CountryModel country) {
    selectedCountry = country;
    emit(AccountSetupSelectionUpdated());
  }

  // ─── Topics ────────────────────────────────────────────────────────────────
  void toggleTopic(String topic) {
    if (selectedTopics.contains(topic)) {
      selectedTopics.remove(topic);
    } else {
      selectedTopics.add(topic);
    }
    emit(AccountSetupSelectionUpdated());
  }

  // ─── Sources ───────────────────────────────────────────────────────────────
  Future<void> fetchSources() async {
    emit(AccountSetupLoading());
    try {
      final apiCategory = _resolveApiCategory();

      sources = await _repo.getSources(
        category: apiCategory,
        country: selectedCountry?.code,
      );
      emit(AccountSetupSourcesLoaded(sources));
    } catch (e) {
      emit(AccountSetupError(e.toString()));
    }
  }

  void toggleSource(String sourceId) {
    if (followedSources.contains(sourceId)) {
      followedSources.remove(sourceId);
    } else {
      followedSources.add(sourceId);
    }
    emit(AccountSetupSelectionUpdated());
  }

  // ─── Profile ───────────────────────────────────────────────────────────────
  void updateProfileField({
    String? username,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    if (username != null) this.username = username;
    if (fullName != null) this.fullName = fullName;
    if (email != null) this.email = email;
    if (phoneNumber != null) this.phoneNumber = phoneNumber;
    if (profileImageUrl != null) this.profileImageUrl = profileImageUrl;
    emit(AccountSetupSelectionUpdated());
  }

  Future<void> completeAccountSetup() async {
    emit(AccountSetupLoading());
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        throw Exception('User NOT authenticated');
      }

      await _repo.saveProfile(
        userId: user.id,
        username: username,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        countryCode: selectedCountry?.code ?? '',
        topics: selectedTopics.toList(),
        sources: followedSources.toList(),
        profileImageUrl: profileImageUrl,
      );

      emit(AccountSetupCompleted());
    } catch (e) {
      emit(AccountSetupError(e.toString()));
    }
  }

  /// Maps the selected topic labels to a single NewsAPI category.
  String? _resolveApiCategory() {
    const topicToCategory = <String, String>{
      'Business': 'business',
      'Entertainment': 'entertainment',
      'Health': 'health',
      'Science': 'science',
      'Sports': 'sports',
      'Technology': 'technology',
      'Sport': 'sports',
    };

    if (selectedTopics.length == 1) {
      final only = selectedTopics.first;
      return topicToCategory[only];
    }
    return null;
  }
}
