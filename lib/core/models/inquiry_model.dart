import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! INQUIRY MODEL
//============================================================================

class InquiryModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  final String propertyId;

  final String propertyName;

  final String roomId;

  final String price;

  final String genderRule;

  final String distance;

  final InquiryStatus status;

  final String? roomName;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const InquiryModel({
    required this.id,
    required this.propertyId,
    required this.propertyName,
    required this.roomId,
    required this.price,
    required this.genderRule,
    required this.distance,
    required this.status,
    this.roomName,
  });
}
