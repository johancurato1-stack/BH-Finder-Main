import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bh_finder/core/authentication/repositories/auth_repository.dart';

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
      emailRedirectTo: 'bhfinder://confirmation',
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
    await _supabase.auth.resetPasswordForEmail(
      email,
      redirectTo: 'bhfinder://reset-password',
    );
  }

  //============================================================================
  //! UPDATE PASSWORD
  //============================================================================

  @override
  Future<void> updatePassword({required String password}) async {
    await _supabase.auth.updateUser(UserAttributes(password: password));
  }

  //============================================================================
  //! RESEND EMAIL VERIFICATION
  //============================================================================

  @override
  Future<void> resendEmailVerification({required String email}) async {
    await _supabase.auth.resend(
      type: OtpType.signup,
      email: email,
      emailRedirectTo: 'bhfinder://confirmation',
    );
  }

  //============================================================================
  //! CHECK EMAIL VERIFICATION
  //============================================================================

  @override
  Future<bool> isEmailVerified() async {
    await _supabase.auth.refreshSession();

    final user = _supabase.auth.currentUser;

    return user?.emailConfirmedAt != null;
  }

  //============================================================================
  //! SESSION
  //============================================================================

  @override
  bool get isLoggedIn => _supabase.auth.currentUser != null;

  @override
  String? get currentUserId => _supabase.auth.currentUser?.id;
}
