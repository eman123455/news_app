import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  final supabase = Supabase.instance.client;

  Future<void> resetPassword(String email) async {
    emit(ForgetPasswordLoading());
    try {
      // Supabase v2 method
      await supabase.auth.resetPasswordForEmail(email);

      // If no exception, success
      emit(ForgetPasswordSuccess());
    } on AuthException catch (e) {
      // Supabase-specific errors
      emit(ForgetPasswordFailure(e.message));
    } catch (e) {
      // Other unexpected errors
      emit(ForgetPasswordFailure(e.toString()));
    }
  }
}
