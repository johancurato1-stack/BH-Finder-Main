import 'package:flutter/foundation.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/image_model.dart';

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
    required this.images,
    required this.amenities,
    required this.minimumPrice,
    required this.genderPreference,
    required this.views,
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
  final List<ImageModel> images;

  /// Available amenities.
  final List<Amenity> amenities;

  /// Cached minimum room price.
  final double minimumPrice;

  /// Cached gender preference derived from all rooms.
  final GenderPreference genderPreference;

  /// Cached number of property views.
  final int views;

  /// Available, Occupied.
  final PropertyStatus status;
}
