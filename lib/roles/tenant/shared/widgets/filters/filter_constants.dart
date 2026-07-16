import 'package:flutter/material.dart';

import 'filter_models.dart';

/// ============================================================================
/// FILTER CONSTANTS
/// ----------------------------------------------------------------------------
/// Static filter options used throughout the search feature.
/// ============================================================================

class FilterConstants {
  FilterConstants._();

  //==========================================================================
  //! BUDGETS
  //==========================================================================

  static const List<String> budgets = [
    'Any',
    '₱1,500 - ₱3,000',
    '₱3,000 - ₱5,000',
    '₱5,000+',
  ];

  //==========================================================================
  //! AMENITIES
  //==========================================================================

  static const List<AmenityFilter> amenities = [
    AmenityFilter(label: 'Wi-Fi', icon: Icons.wifi),

    AmenityFilter(label: 'Aircon', icon: Icons.ac_unit),

    AmenityFilter(label: 'Own CR', icon: Icons.bathroom),

    AmenityFilter(label: 'Kitchen', icon: Icons.countertops),

    AmenityFilter(label: 'Laundry', icon: Icons.local_laundry_service),

    AmenityFilter(label: 'Study', icon: Icons.menu_book),

    AmenityFilter(label: 'Desk', icon: Icons.desk),

    AmenityFilter(label: 'Cabinet', icon: Icons.shelves),

    AmenityFilter(label: 'CCTV', icon: Icons.videocam),

    AmenityFilter(label: 'Security', icon: Icons.security),

    AmenityFilter(label: 'Parking', icon: Icons.directions_car),
  ];

  //==========================================================================
  //! DISTANCES
  //==========================================================================

  static const List<String> distances = [
    'Any',
    'Within 5 min walk',
    'Within 10 min walk',
    'Within 15 min walk',
  ];

  //==========================================================================
  //! GENDERS
  //==========================================================================

  static const List<String> genders = ['Male', 'Female', 'Mixed'];

  //==========================================================================
  //! ROOM STATUS
  //==========================================================================

  static const List<StatusFilter> statuses = [
    StatusFilter(label: 'Available', color: Colors.green),

    StatusFilter(label: 'Occupied', color: Colors.red),

    StatusFilter(label: 'Pending', color: Colors.amber),
  ];
}
