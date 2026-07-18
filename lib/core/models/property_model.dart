import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! PROPERTY MODEL
//============================================================================

@immutable
class PropertyModel {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyModel({
    required this.id,
    required this.landlordId,
    required this.title,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
    required this.amenities,
    required this.genderPreference,
    required this.favoriteCount,
    required this.status,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  /// Unique property ID.
  final String id;

  /// Owner of this property.
  final String landlordId;

  /// Example: "Sunrise Boarding House"
  final String title;

  /// Property description.
  final String description;

  /// Human-readable address.
  final String address;

  /// Latitude for maps and distance calculations.
  final double latitude;

  /// Longitude for maps and distance calculations.
  final double longitude;

  /// Property images.
  final List<String> imageUrls;

  /// Available amenities.
  final List<Amenity> amenities;

  /// Male, Female, or Mixed.
  final GenderPreference genderPreference;

  /// Cached number of users who have favorited this property.
  final int favoriteCount;

  /// Available, Occupied.
  final PropertyStatus status;
}
