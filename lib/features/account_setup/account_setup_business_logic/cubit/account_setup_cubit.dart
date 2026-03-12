import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'account_setup_state.dart';

class AccountSetupCubit extends Cubit<AccountSetupState> {
  AccountSetupCubit() : super(AccountSetupInitial());
}
