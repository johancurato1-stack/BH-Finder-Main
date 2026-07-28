import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/image_model.dart';

//============================================================================
//! ADD PROPERTY REQUEST
//============================================================================

class AddPropertyRequest {
  const AddPropertyRequest({
    required this.title,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.images,
    required this.amenities,
    required this.status,
  });

  final String title;

  final String description;

  final String address;

  final double latitude;

  final double longitude;

  final List<ImageModel> images;

  final List<Amenity> amenities;

  final PropertyStatus status;
}
