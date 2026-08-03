import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! TENANT PROPERTY CARD DATA
//============================================================================

class TenantPropertyCardData {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  final String title;

  final String coverImageUrl;

  final double minimumPrice;

  final int roomCount;

  final PropertyStatus status;

  final GenderPreference genderPreference;

  final int favoriteCount;

  final String address;

  final List<Amenity> amenities;

  final bool isFavorite;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const TenantPropertyCardData({
    required this.id,
    required this.title,
    required this.coverImageUrl,
    required this.minimumPrice,
    required this.roomCount,
    required this.status,
    required this.genderPreference,
    required this.favoriteCount,
    required this.address,
    required this.amenities,
    required this.isFavorite,
  });
}
