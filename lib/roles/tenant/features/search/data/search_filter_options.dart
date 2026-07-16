import 'package:flutter/material.dart';

class SearchFilterOptions {
  SearchFilterOptions._();

  //============================================================================
  //! BUDGET OPTIONS
  //============================================================================

  static const List<String> budgets = [
    'Any',
    '₱1,500 - ₱3,000',
    '₱3,000 - ₱5,000',
    '₱5,000+',
  ];

  //============================================================================
  //! AMENITY OPTIONS
  //============================================================================

  static const List<Map<String, dynamic>> amenities = [
    {'label': 'Wi-Fi', 'icon': Icons.wifi},
    {'label': 'Aircon', 'icon': Icons.ac_unit},
    {'label': 'Own CR', 'icon': Icons.bathroom},
    {'label': 'Kitchen', 'icon': Icons.countertops},
    {'label': 'Laundry', 'icon': Icons.local_laundry_service},
    {'label': 'Study', 'icon': Icons.menu_book},
    {'label': 'Desk', 'icon': Icons.desk},
    {'label': 'Cabinet', 'icon': Icons.shelves},
    {'label': 'CCTV', 'icon': Icons.videocam},
    {'label': 'Security', 'icon': Icons.security},
    {'label': 'Parking', 'icon': Icons.directions_car},
  ];

  //============================================================================
  //! DISTANCE OPTIONS
  //============================================================================

  static const List<String> distances = [
    'Any',
    'Within 5 min walk',
    'Within 10 min walk',
    'Within 15 min walk',
  ];

  //============================================================================
  //! GENDER OPTIONS
  //============================================================================

  static const List<String> genders = ['Male', 'Female', 'Mixed'];

  //============================================================================
  //! STATUS OPTIONS
  //============================================================================

  static const List<Map<String, dynamic>> statuses = [
    {'label': 'Available', 'color': Colors.green},
    {'label': 'Occupied', 'color': Colors.red},
    {'label': 'Pending', 'color': Colors.amber},
  ];
}
