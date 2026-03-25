import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/Auth/login/data/login_web_services/login_web_services.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginWebServices loginWebServices;

  LoginCubit(this.loginWebServices) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await loginWebServices.login(email: email, password: password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
