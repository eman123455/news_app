import 'package:supabase_flutter/supabase_flutter.dart' hide LocalStorage;
import '../../../../../core/storage/local_storage.dart';

class LoginWebServices {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    await LocalStorage.setUserId(response.user!.id);

    return response;
  }
}
