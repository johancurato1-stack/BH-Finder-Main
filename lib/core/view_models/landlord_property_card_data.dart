import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! LANDLORD PROPERTY CARD DATA
//============================================================================

class LandlordPropertyCardData {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const LandlordPropertyCardData({
    required this.id,
    required this.title,
    required this.coverImageUrl,
    required this.status,
    required this.distance,
    required this.totalRooms,
    required this.totalViews,
    required this.totalFavorites,
    required this.totalInquiries,
    this.isVerified = false,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String id;

  final String title;

  final String coverImageUrl;

  final PropertyStatus status;

  /// Distance to the target campus in meters.
  final double distance;

  final int totalRooms;

  final int totalViews;

  final int totalFavorites;

  final int totalInquiries;

  final bool isVerified;
}
