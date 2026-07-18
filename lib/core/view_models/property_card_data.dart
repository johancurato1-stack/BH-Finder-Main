import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! PROPERTY CARD DATA
//============================================================================

class PropertyCardData {
  const PropertyCardData({
    required this.id,
    required this.title,
    required this.coverImageUrl,
    required this.minimumPrice,
    required this.roomCount,
    required this.status,
    required this.genderPreference,
    required this.favoriteCount,
    required this.distance,
    required this.amenities,
    required this.isFavorite,
  });

  final String id;

  final String title;

  final String coverImageUrl;

  final double minimumPrice;

  final int roomCount;

  final PropertyStatus status;

  final GenderPreference genderPreference;

  final int favoriteCount;

  final double distance;

  final List<Amenity> amenities;

  final bool isFavorite;
}
