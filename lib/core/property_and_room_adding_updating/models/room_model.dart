import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/image_model.dart';

//============================================================================
//! ROOM MODEL
//============================================================================

class RoomModel {
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
  });

  //============================================================================
  //! PROPERTIES
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
}
