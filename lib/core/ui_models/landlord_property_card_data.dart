import 'package:bh_finder/core/enums/enums.dart';

//============================================================================
//! LANDLORD PROPERTY CARD DATA
//============================================================================

class LandlordPropertyCardData {
  //============================================================================
  //! FIELDS
  //============================================================================

  final String id;

  final String title;

  final String coverImageUrl;

  final PropertyStatus status;

  final String address;

  final int totalRooms;

  final int totalViews;

  final int totalFavorites;

  final int totalInquiries;

  final bool isVerified;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const LandlordPropertyCardData({
    required this.id,
    required this.title,
    required this.coverImageUrl,
    required this.status,
    required this.address,
    required this.totalRooms,
    required this.totalViews,
    required this.totalFavorites,
    required this.totalInquiries,
    this.isVerified = false,
  });
}
