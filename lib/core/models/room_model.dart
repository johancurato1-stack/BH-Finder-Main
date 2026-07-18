import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! ROOM MODEL
//============================================================================

@immutable
class RoomModel {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomModel({
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

  /// Unique room ID.
  final String id;

  /// Property that owns this room.
  final String propertyId;

  /// Example: 101
  final String roomNumber;

  /// Room description.
  final String description;

  /// Monthly rental price.
  final double price;

  /// Maximum occupants.
  final int capacity;

  /// Male, Female, or Mixed.
  final GenderPreference genderPreference;

  /// Room photos.
  final List<String> imageUrls;
}
