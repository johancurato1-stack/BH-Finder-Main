//============================================================================
//! PROFILE REPOSITORY
//============================================================================

abstract class ProfileRepository {
  //============================================================================
  //! GETTERS
  //============================================================================

  /// Returns the current user's profile data.
  Future<Map<String, dynamic>?> getCurrentProfile();

  /// Returns the total number of favorite properties.
  Future<int> getFavoritesCount();

  /// Returns the total number of inquiries.
  Future<int> getInquiriesCount();

  /// Returns the total number of properties.
  Future<int> getPropertiesCount();

  //============================================================================
  //! COMMANDS
  //============================================================================

  /// Updates the user's avatar path.
  Future<void> updateAvatarPath(String avatarPath);

  /// Updates the user's last active role.
  Future<void> updateLastActiveRole(String role);

  /// Updates the user's last seen timestamp.
  Future<void> updateLastSeen();
}
