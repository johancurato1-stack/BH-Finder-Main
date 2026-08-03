import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/image_model.dart';

//============================================================================
//! ROOM MODEL
//============================================================================

class RoomModel {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  final String propertyId;

  final String title;

  final String description;

  final double price;

  final int capacity;

  final GenderPreference genderPreference;

  /// Local files or uploaded images.
  final List<ImageModel> images;

  /// Room creation date.
  final DateTime createdAt;

  /// Last updated date.
  final DateTime updatedAt;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomModel({
    required this.id,
    required this.propertyId,
    required this.title,
    required this.description,
    required this.price,
    required this.capacity,
    required this.genderPreference,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
  });
}
