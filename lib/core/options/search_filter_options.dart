import 'package:flutter/material.dart';

//============================================================================
//! SEARCH FILTER OPTIONS
//============================================================================

class SearchFilterOptions {
  SearchFilterOptions._();

  //============================================================================
  //! DEFAULT VALUE
  //============================================================================

  static const String any = 'Any';

  //============================================================================
  //! BUDGET OPTIONS
  //============================================================================

  static const List<String> budgets = [
    any,
    '₱1,500 - ₱3,000',
    '₱3,000 - ₱5,000',
    '₱5,000+',
  ];

  //============================================================================
  //! GENDER OPTIONS
  //============================================================================

  static const List<String> genders = ['Male', 'Female', 'Mixed', any];

  //============================================================================
  //! AMENITY OPTIONS
  //============================================================================

  static const List<Map<String, dynamic>> amenities = [
    {'label': 'Wi-Fi', 'value': 'wifi', 'icon': Icons.wifi},
    {'label': 'Aircon', 'value': 'airConditioning', 'icon': Icons.ac_unit},
    {'label': 'Own CR', 'value': 'privateBathroom', 'icon': Icons.bathroom},
    {'label': 'Kitchen', 'value': 'kitchen', 'icon': Icons.countertops},
    {
      'label': 'Laundry',
      'value': 'laundry',
      'icon': Icons.local_laundry_service,
    },
    {'label': 'Study', 'value': 'studyArea', 'icon': Icons.menu_book},
    {'label': 'Desk', 'value': 'desk', 'icon': Icons.desk},
    {'label': 'Cabinet', 'value': 'cabinet', 'icon': Icons.shelves},
    {'label': 'CCTV', 'value': 'cctv', 'icon': Icons.videocam},
    {'label': 'Security', 'value': 'security', 'icon': Icons.security},
    {'label': 'Parking', 'value': 'parking', 'icon': Icons.directions_car},
  ];

  //============================================================================
  //! STATUS OPTIONS
  //============================================================================

  static const List<Map<String, dynamic>> statuses = [
    {'label': any},
    {'label': 'Available', 'color': Colors.green},
    {'label': 'Occupied', 'color': Colors.red},
  ];
}
