abstract class AuthRepository {
  //============================================================================
  //! AUTHENTICATION
  //============================================================================

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String password,
  });

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  Future<void> resetPassword({required String email});

  Future<void> updatePassword({required String password});

  Future<void> resendEmailVerification({required String email});

  Future<bool> isEmailVerified();

  //============================================================================
  //! SESSION
  //============================================================================

  bool get isLoggedIn;

  String? get currentUserId;
}
