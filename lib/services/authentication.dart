import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signUp(String phone, String password) async {
    final response = await _supabase.auth.signUp(
      phone: phone,
      password: password,
    );
    return response;
  }

  Future<AuthResponse> signIn(String phone, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      phone: phone,
      password: password,
    );
    return response;
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }
}
