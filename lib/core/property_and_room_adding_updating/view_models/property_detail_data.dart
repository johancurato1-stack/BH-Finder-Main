import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/image_model.dart';
import 'package:bh_finder/core/models/landlord_model.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/models/room_model.dart';

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
    required this.images,
    required this.minimumPrice,
    required this.roomCount,
    required this.genderPreference,
    required this.amenities,
    required this.favoriteCount,
    required this.latitude,
    required this.longitude,
    required this.landlord,
    required this.status,
    required this.rooms,
    required this.address,
    required this.totalViews,
    required this.totalInquiries,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String id;

  final String title;

  final String description;

  final List<ImageModel> images;

  final double minimumPrice;

  final int roomCount;

  final GenderPreference genderPreference;

  final List<Amenity> amenities;

  final int favoriteCount;

  final double latitude;

  final double longitude;

  final LandlordModel? landlord;

  final PropertyStatus status;

  final List<RoomModel> rooms;

  final String address;

  final int totalViews;

  final int totalInquiries;
}
