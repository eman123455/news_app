part of 'account_setup_cubit.dart';

@immutable
sealed class AccountSetupState {}

@immutable
final class AccountSetupUiState extends AccountSetupState {
  final int stepIndex;
  final String countrySearch;
  final String? selectedCountryCode;
  final String? selectedCountryLabel;
  final String topicSearch;
  final Set<String> selectedCategories;
  final String sourceSearch;
  final Set<String> followedSourceIds;
  final List<NewsSourceModel> sources;
  final bool sourcesLoading;
  final String? sourcesError;
  final String username;
  final String fullName;
  final String email;
  final String phone;
  final String? profileError;
  // Can be null briefly during hot reload after state shape changes.
  final bool? isSubmitting;
  final String? submitError;

  AccountSetupUiState({
    required this.stepIndex,
    required this.countrySearch,
    required this.selectedCountryCode,
    required this.selectedCountryLabel,
    required this.topicSearch,
    required this.selectedCategories,
    required this.sourceSearch,
    required this.followedSourceIds,
    required this.sources,
    required this.sourcesLoading,
    required this.sourcesError,
    required this.username,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.profileError,
    required this.isSubmitting,
    required this.submitError,
  });

  factory AccountSetupUiState.initial() => AccountSetupUiState(
        stepIndex: 0,
        countrySearch: '',
        selectedCountryCode: null,
        selectedCountryLabel: null,
        topicSearch: '',
        selectedCategories: {},
        sourceSearch: '',
        followedSourceIds: {},
        sources: [],
        sourcesLoading: false,
        sourcesError: null,
        username: '',
        fullName: '',
        email: '',
        phone: '',
        profileError: null,
        isSubmitting: false,
        submitError: null,
      );

  AccountSetupUiState copyWith({
    int? stepIndex,
    String? countrySearch,
    String? selectedCountryCode,
    String? selectedCountryLabel,
    bool clearSelectedCountry = false,
    String? topicSearch,
    Set<String>? selectedCategories,
    String? sourceSearch,
    Set<String>? followedSourceIds,
    List<NewsSourceModel>? sources,
    bool? sourcesLoading,
    String? sourcesError,
    bool useSourcesError = false,
    bool clearSources = false,
    String? username,
    String? fullName,
    String? email,
    String? phone,
    String? profileError,
    bool useProfileError = false,
    bool? isSubmitting,
    String? submitError,
  }) {
    return AccountSetupUiState(
      stepIndex: stepIndex ?? this.stepIndex,
      countrySearch: countrySearch ?? this.countrySearch,
      selectedCountryCode: clearSelectedCountry
          ? null
          : (selectedCountryCode ?? this.selectedCountryCode),
      selectedCountryLabel: clearSelectedCountry
          ? null
          : (selectedCountryLabel ?? this.selectedCountryLabel),
      topicSearch: topicSearch ?? this.topicSearch,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      sourceSearch: sourceSearch ?? this.sourceSearch,
      followedSourceIds: followedSourceIds ?? this.followedSourceIds,
      sources: clearSources ? [] : (sources ?? this.sources),
      sourcesLoading:
          clearSources ? false : (sourcesLoading ?? this.sourcesLoading),
      sourcesError: clearSources
          ? null
          : (useSourcesError ? sourcesError : this.sourcesError),
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileError:
          useProfileError ? profileError : this.profileError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitError: submitError ?? this.submitError,
    );
  }
}
