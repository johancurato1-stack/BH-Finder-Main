import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/image_model.dart';

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

  final List<ImageModel> images;
}
