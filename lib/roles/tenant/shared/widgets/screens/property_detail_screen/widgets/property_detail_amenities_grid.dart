import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyAmenitiesGrid extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyAmenitiesGrid({super.key, required this.amenities});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<String> amenities;

  //============================================================================
  //! METHODS
  //============================================================================

  IconData _getAmenityIcon(String title) {
    switch (title.toLowerCase()) {
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
        return Icons.star;
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: amenities.map((amenity) {
        return _AmenityBox(title: amenity, icon: _getAmenityIcon(amenity));
      }).toList(),
    );
  }
}

//============================================================================
//! AMENITY BOX
//============================================================================

class _AmenityBox extends StatelessWidget {
  const _AmenityBox({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 70) / 4,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: AppColors.tertiary),

          const SizedBox(height: 6),

          Text(
            title,
            style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
