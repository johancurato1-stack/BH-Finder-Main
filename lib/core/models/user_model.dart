import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! USER MODEL
//============================================================================

class UserModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String name;
  final String email;
  final String avatarUrl;
  final UserVerificationStatus verificationStatus;
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
