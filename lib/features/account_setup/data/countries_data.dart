class CountryOption {
  final String code;
  final String name;

  const CountryOption({required this.code, required this.name});
}

String flagEmojiForCountryCode(String code) {
  if (code.length != 2) return '';
  final upper = code.toUpperCase();
  const base = 0x1f1e6;
  final u0 = upper.codeUnitAt(0);
  final u1 = upper.codeUnitAt(1);
  if (u0 < 65 || u0 > 90 || u1 < 65 || u1 > 90) return '';
  return String.fromCharCodes([base + u0 - 65, base + u1 - 65]);
}

/// ISO 3166-1 alpha-2 codes supported by News API for sources/top headlines.
const List<CountryOption> kAccountSetupCountries = [
  CountryOption(code: 'us', name: 'United States'),
  CountryOption(code: 'gb', name: 'United Kingdom'),
  CountryOption(code: 'id', name: 'Indonesia'),
  CountryOption(code: 'au', name: 'Australia'),
  CountryOption(code: 'in', name: 'India'),
  CountryOption(code: 'ca', name: 'Canada'),
  CountryOption(code: 'de', name: 'Germany'),
  CountryOption(code: 'fr', name: 'France'),
  CountryOption(code: 'it', name: 'Italy'),
  CountryOption(code: 'es', name: 'Spain'),
  CountryOption(code: 'nl', name: 'Netherlands'),
  CountryOption(code: 'be', name: 'Belgium'),
  CountryOption(code: 'ch', name: 'Switzerland'),
  CountryOption(code: 'at', name: 'Austria'),
  CountryOption(code: 'se', name: 'Sweden'),
  CountryOption(code: 'no', name: 'Norway'),
  CountryOption(code: 'ie', name: 'Ireland'),
  CountryOption(code: 'nz', name: 'New Zealand'),
  CountryOption(code: 'jp', name: 'Japan'),
  CountryOption(code: 'kr', name: 'South Korea'),
  CountryOption(code: 'sg', name: 'Singapore'),
  CountryOption(code: 'my', name: 'Malaysia'),
  CountryOption(code: 'ph', name: 'Philippines'),
  CountryOption(code: 'th', name: 'Thailand'),
  CountryOption(code: 'vn', name: 'Vietnam'),
  CountryOption(code: 'cn', name: 'China'),
  CountryOption(code: 'hk', name: 'Hong Kong'),
  CountryOption(code: 'tw', name: 'Taiwan'),
  CountryOption(code: 'ae', name: 'United Arab Emirates'),
  CountryOption(code: 'sa', name: 'Saudi Arabia'),
  CountryOption(code: 'eg', name: 'Egypt'),
  CountryOption(code: 'za', name: 'South Africa'),
  CountryOption(code: 'ng', name: 'Nigeria'),
  CountryOption(code: 'br', name: 'Brazil'),
  CountryOption(code: 'mx', name: 'Mexico'),
  CountryOption(code: 'ar', name: 'Argentina'),
  CountryOption(code: 'co', name: 'Colombia'),
  CountryOption(code: 'ru', name: 'Russia'),
  CountryOption(code: 'pl', name: 'Poland'),
  CountryOption(code: 'pt', name: 'Portugal'),
  CountryOption(code: 'gr', name: 'Greece'),
  CountryOption(code: 'tr', name: 'Turkey'),
  CountryOption(code: 'il', name: 'Israel'),
];
