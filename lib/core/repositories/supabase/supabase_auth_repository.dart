import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  //============================================================================
  //! SUPABASE
  //============================================================================

  final SupabaseClient _supabase = Supabase.instance.client;

  //============================================================================
  //! SIGN UP
  //============================================================================

  @override
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'gender': gender,
      },
    );

    if (response.user == null) {
      throw Exception('Failed to create account.');
    }
  }

  //============================================================================
  //! SIGN IN
  //============================================================================

  @override
  Future<void> signIn({required String email, required String password}) async {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Failed to sign in.');
    }
  }

  //============================================================================
  //! SIGN OUT
  //============================================================================

  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  //============================================================================
  //! RESET PASSWORD
  //============================================================================

  @override
  Future<void> resetPassword({required String email}) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  //============================================================================
  //! SESSION
  //============================================================================

  @override
  bool get isLoggedIn => _supabase.auth.currentUser != null;

  @override
  String? get currentUserId => _supabase.auth.currentUser?.id;
}
