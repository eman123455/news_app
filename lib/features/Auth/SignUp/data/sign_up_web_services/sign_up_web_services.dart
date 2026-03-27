import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpWebServices {

   final supabase = Supabase.instance.client;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
    );
  }
  
}
