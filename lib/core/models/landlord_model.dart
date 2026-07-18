import 'package:bh_finder/core/enums/enums.dart';
import 'package:flutter/foundation.dart';

//============================================================================
//! LANDLORD MODEL
//============================================================================

@immutable
class LandlordModel {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const LandlordModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.responseTime,
    required this.verificationStatus,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String id;

  final String fullName;

  final String phoneNumber;

  final String profileImageUrl;

  final ResponseTime responseTime;

  final VerificationStatus verificationStatus;
}
