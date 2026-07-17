import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

class PropertyAmenities extends StatelessWidget {
  final BoardingHouseModel boardingHouse;

  const PropertyAmenities({super.key, required this.boardingHouse});

  //============================================================================
  //! AMENITY ICON
  //============================================================================

  /// Returns the appropriate icon for each boarding house amenity.
  IconData _getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'wi-fi':
        return Icons.wifi;

      case 'aircon':
        return Icons.ac_unit;

      case 'own cr':
        return Icons.bathroom;

      case 'kitchen':
        return Icons.countertops;

      case 'laundry':
        return Icons.local_laundry_service;

      case 'study area':
        return Icons.menu_book;

      case 'desk':
        return Icons.desk;

      case 'cabinet':
        return Icons.shelves;

      case 'cctv':
        return Icons.videocam;

      case 'security':
        return Icons.security;

      case 'parking':
        return Icons.directions_car;

      default:
        return Icons.star_border_rounded;
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 5,
      children: boardingHouse.amenities.map((amenity) {
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
          ),

          // Amenity icon.
          child: Icon(
            _getAmenityIcon(amenity),
            size: 11,
            color: Colors.grey.shade600,
          ),
        );
      }).toList(),
    );
  }
}
