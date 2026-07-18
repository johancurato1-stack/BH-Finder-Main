//============================================================================
//! VERIFICATION STATUS
//============================================================================
enum VerificationStatus { verified, pending, unverified }

//============================================================================
//! VARIABLES
//============================================================================
class UserModel {
  final String name;
  final String email;
  final String avatarUrl;
  final VerificationStatus verificationStatus;
  final int favoritesCount;
  final int recentlyViewedCount;
  final int inquiriesCount;
  final String firstname;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================
  const UserModel({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.verificationStatus,
    required this.favoritesCount,
    required this.recentlyViewedCount,
    required this.inquiriesCount,
    required this.firstname,
  });
}
