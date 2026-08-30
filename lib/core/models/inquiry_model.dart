//============================================================================
//! INQUIRY MODEL
//============================================================================

import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! INQUIRY MODEL
//============================================================================

class InquiryModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  final String? chatId;

  // Property Snapshot

  final String propertyName;

  // Room Reference

  final String? roomId;

  // Room Snapshot

  final String roomImageUrl;

  final String roomTitle;

  final double roomPrice;

  final int roomCapacity;

  final String roomGenderPreference;

  // Inquiry

  final String message;

  final InquiryStatus status;

  final DateTime createdAt;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const InquiryModel({
    required this.id,
    required this.chatId,
    required this.propertyName,
    required this.roomId,
    required this.roomImageUrl,
    required this.roomTitle,
    required this.roomPrice,
    required this.roomCapacity,
    required this.roomGenderPreference,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  //============================================================================
  //! FROM MAP
  //============================================================================

  factory InquiryModel.fromMap(Map<String, dynamic> map) {
    return InquiryModel(
      id: map['id'] ?? '',
      chatId: map['chatId'],
      propertyName: map['propertyName'] ?? '',
      roomId: map['roomId'],
      roomImageUrl: map['roomImageUrl'] ?? '',
      roomTitle: map['roomTitle'] ?? '',
      roomPrice: (map['roomPrice'] as num?)?.toDouble() ?? 0,
      roomCapacity: map['roomCapacity'] ?? 0,
      roomGenderPreference: map['roomGenderPreference'] ?? '',

      message: map['message'] ?? '',

      status: InquiryStatus.values.firstWhere(
        (status) => status.name == map['status'],
        orElse: () => InquiryStatus.pending,
      ),

      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  //============================================================================
  //! TO MAP
  //============================================================================

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'propertyName': propertyName,
      'roomId': roomId,
      'roomImageUrl': roomImageUrl,
      'roomTitle': roomTitle,
      'roomPrice': roomPrice,
      'roomCapacity': roomCapacity,
      'roomGenderPreference': roomGenderPreference,
      'message': message,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
