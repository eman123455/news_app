import 'package:flutter/material.dart';
import 'package:news_app/features/account_setup/presentation/screens/select_country_view.dart';

/// Entry point for the account-setup flow.
/// The [AccountSetupCubit] is provided via a ShellRoute in AppRoutes.
class AccountSetup extends StatelessWidget {
  const AccountSetup({super.key});

  @override
  Widget build(BuildContext context) {
    return const SelectCountryView();
  }
}
