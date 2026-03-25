import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/Auth/SignUp/data/sign_up_web_services/sign_up_web_services.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpWebServices signUpWebServices;
  SignUpCubit(this.signUpWebServices) : super(SignUpInitial());

  Future<void> signUp(String email, String password) async {
    emit(SignUpLoading());
    try {
      await signUpWebServices.signUp(email: email, password: password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
