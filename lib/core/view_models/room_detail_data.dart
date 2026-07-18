import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! ROOM DETAIL DATA
//============================================================================

class RoomDetailData {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailData({
    required this.id,
    required this.propertyId,
    required this.roomNumber,
    required this.description,
    required this.price,
    required this.capacity,
    required this.genderPreference,
    required this.imageUrls,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String id;

  final String propertyId;

  final String roomNumber;

  final String description;

  final double price;

  final int capacity;

  final GenderPreference genderPreference;

  final List<String> imageUrls;
}
