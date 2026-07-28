import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/image_model.dart';

//============================================================================
//! ADD ROOM REQUEST
//============================================================================

class AddRoomRequest {
  const AddRoomRequest({
    required this.propertyId,
    required this.roomNumber,
    required this.price,
    required this.capacity,
    required this.description,
    required this.genderPreference,
    required this.images,
  });

  final String propertyId;

  final String roomNumber;

  final double price;

  final int capacity;

  final String description;

  final GenderPreference genderPreference;

  final List<ImageModel> images;
}
