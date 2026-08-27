import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! INQUIRY MODEL
//============================================================================

class InquiryModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  final String chatId;

  final String tenantId;

  final String landlordId;

  final String propertyId;

  final String roomId;

  final String roomTitle;

  final double roomPrice;

  final int roomCapacity;

  final GenderPreference genderPreference;

  final String message;

  final InquiryStatus status;

  final DateTime createdAt;

  final DateTime updatedAt;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const InquiryModel({
    required this.id,
    required this.chatId,
    required this.tenantId,
    required this.landlordId,
    required this.propertyId,
    required this.roomId,
    required this.roomTitle,
    required this.roomPrice,
    required this.roomCapacity,
    required this.genderPreference,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
