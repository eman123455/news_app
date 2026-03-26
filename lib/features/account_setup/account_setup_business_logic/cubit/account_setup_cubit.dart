import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/account_setup/data/models/news_source_model.dart';
import 'package:news_app/features/account_setup/data/repo/account_setup_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  AccountSetupCubit(this._repo) : super(AccountSetupUiState.initial());

  final AccountSetupRepo _repo;

  AccountSetupUiState get _s => state as AccountSetupUiState;

  void setCountrySearch(String value) {
    emit(_s.copyWith(countrySearch: value));
  }

  void selectCountry({required String code, required String name}) {
    emit(_s.copyWith(
      selectedCountryCode: code,
      selectedCountryLabel: name,
      clearSources: true,
    ));
  }

  void setTopicSearch(String value) {
    emit(_s.copyWith(topicSearch: value));
  }

  void toggleTopicCategory(String apiCategory) {
    final next = Set<String>.from(_s.selectedCategories);
    if (next.contains(apiCategory)) {
      next.remove(apiCategory);
    } else {
      next.add(apiCategory);
    }
    emit(_s.copyWith(selectedCategories: next));
  }

  void setSourceSearch(String value) {
    emit(_s.copyWith(sourceSearch: value));
  }

  void toggleFollowSource(String sourceId) {
    final next = Set<String>.from(_s.followedSourceIds);
    if (next.contains(sourceId)) {
      next.remove(sourceId);
    } else {
      next.add(sourceId);
    }
    emit(_s.copyWith(followedSourceIds: next));
  }

  Future<void> loadSourcesForCurrentCountry() async {
    final code = _s.selectedCountryCode;
    if (!_s.sourcesLoading) {
      emit(_s.copyWith(
        sourcesLoading: true,
        sourcesError: null,
        useSourcesError: true,
      ));
    }
    try {
      final list = await _repo.getSources(country: code);
      list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      emit(_s.copyWith(
        sources: list,
        sourcesLoading: false,
        sourcesError: null,
        useSourcesError: true,
      ));
    } catch (e) {
      emit(_s.copyWith(
        sources: [],
        sourcesLoading: false,
        sourcesError: e.toString(),
        useSourcesError: true,
      ));
    }
  }

  void setUsername(String v) => emit(_s.copyWith(
        username: v,
        profileError: null,
        useProfileError: true,
      ));

  void setFullName(String v) => emit(_s.copyWith(
        fullName: v,
        profileError: null,
        useProfileError: true,
      ));

  void setEmail(String v) => emit(_s.copyWith(
        email: v,
        profileError: null,
        useProfileError: true,
      ));

  void setPhone(String v) => emit(_s.copyWith(
        phone: v,
        profileError: null,
        useProfileError: true,
      ));

  void clearProfileError() =>
      emit(_s.copyWith(profileError: null, useProfileError: true));

  bool validateProfileStep() {
    final email = _s.email.trim();
    final phone = _s.phone.trim();
    final emailOk = RegExp(
      r'^[^@]+@[^@]+\.[^@]+$',
    ).hasMatch(email);
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    final phoneOk = digits.length >= 8;
    if (!emailOk || !phoneOk) {
      final msg = [
        if (!emailOk) 'Enter a valid email address',
        if (!phoneOk) 'Enter a valid phone number',
      ].join(' · ');
      emit(_s.copyWith(profileError: msg, useProfileError: true));
      return false;
    }
    emit(_s.copyWith(profileError: null, useProfileError: true));
    return true;
  }

  Future<void> goNext() async {
    final i = _s.stepIndex;
    if (i >= 3) return;
    final next = i + 1;
    if (next == 2) {
      emit(_s.copyWith(
        stepIndex: next,
        sourcesLoading: true,
        sourcesError: null,
        useSourcesError: true,
      ));
      await loadSourcesForCurrentCountry();
    } else {
      emit(_s.copyWith(stepIndex: next));
    }
  }

  void goBack() {
    final i = _s.stepIndex;
    if (i > 0) {
      emit(_s.copyWith(stepIndex: i - 1));
    }
  }

  /// Whether the current step allows advancing (Next enabled).
  bool canAdvanceFromCurrentStep() {
    switch (_s.stepIndex) {
      case 0:
        return _s.selectedCountryCode != null;
      case 1:
        return _s.selectedCategories.isNotEmpty;
      case 2:
        return true;
      case 3:
        return true;
      default:
        return false;
    }
  }

  Future<void> submitAccountSetupToSupabase() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;

    // Validate required step inputs before sending.
    if (_s.selectedCountryCode == null || _s.selectedCountryLabel == null) {
      emit(
        _s.copyWith(
          isSubmitting: false,
          submitError: 'Please select a country.',
        ),
      );
      return;
    }

    emit(_s.copyWith(isSubmitting: true, submitError: null));

    try {
      await _repo.saveAccountSetup(
        userId: userId,
        countryCode: _s.selectedCountryCode!,
        countryName: _s.selectedCountryLabel!,
        topics: _s.selectedCategories.toList(),
        sourceIds: _s.followedSourceIds.toList(),
        username: _s.username.trim(),
        fullName: _s.fullName.trim(),
        email: _s.email.trim(),
        phone: _s.phone.trim(),
      );

      emit(_s.copyWith(isSubmitting: false, submitError: null));
    } catch (e) {
      emit(
        _s.copyWith(
          isSubmitting: false,
          submitError: e.toString(),
        ),
      );
    }
  }
}
