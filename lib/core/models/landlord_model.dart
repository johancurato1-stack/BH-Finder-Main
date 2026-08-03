import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! LANDLORD MODEL
//============================================================================

@immutable
class LandlordModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  final String fullName;

  final String phoneNumber;

  final String profileImageUrl;

  /// Last recorded activity.
  final DateTime? lastSeenAt;

  final VerificationStatus verificationStatus;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const LandlordModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.lastSeenAt,
    required this.verificationStatus,
  });
}
