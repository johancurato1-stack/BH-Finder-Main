import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/landlord_model.dart';
import 'package:bh_finder/core/models/room_model.dart';

//============================================================================
//! PROPERTY DETAIL DATA
//============================================================================

class PropertyDetailData {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailData({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.minimumPrice,
    required this.roomCount,
    required this.genderPreference,
    required this.amenities,
    required this.favoriteCount,
    required this.latitude,
    required this.longitude,
    required this.landlord,
    required this.status,
    required this.distance,
    required this.rooms,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String id;

  final String title;

  final String description;

  final List<String> imageUrls;

  final double minimumPrice;

  final int roomCount;

  final GenderPreference genderPreference;

  final List<Amenity> amenities;

  final int favoriteCount;

  final double latitude;

  final double longitude;

  final LandlordModel landlord;

  final PropertyStatus status;

  final double distance;

  final List<RoomModel> rooms;
}
