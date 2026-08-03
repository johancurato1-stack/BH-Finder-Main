//============================================================================
//! AUTH REPOSITORY
//============================================================================

abstract class AuthRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  /// Returns whether a user is currently signed in.
  bool get isLoggedIn;

  /// Returns the ID of the currently signed-in user.
  String? get currentUserId;

  /// Returns whether the current user's email is verified.
  Future<bool> isEmailVerified();

  //============================================================================
  //! COMMANDS
  //============================================================================

  /// Creates a new user account.
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String password,
  });

  /// Signs in an existing user.
  Future<void> signIn({required String email, required String password});

  /// Signs out the current user.
  Future<void> signOut();

  /// Sends a password reset email.
  Future<void> resetPassword({required String email});

  /// Updates the current user's password.
  Future<void> updatePassword({required String password});

  /// Resends the email verification link.
  Future<void> resendEmailVerification({required String email});
}
