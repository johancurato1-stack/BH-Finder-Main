enum InquiryStatus { pending, accepted, rejected, reserved, completed }

class InquiryModel {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final String id;
  final String boardingHouseId;
  final String boardingHouseName;
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
    required this.boardingHouseId,
    required this.boardingHouseName,
    required this.roomId,
    required this.price,
    required this.genderRule,
    required this.distance,
    required this.status,
    this.roomName,
  });
}
