import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! PROPERTY AMENITIES GRID
//============================================================================

class PropertyDetailAmenitiesGrid extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailAmenitiesGrid({super.key, required this.amenities});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<Amenity> amenities;

  //============================================================================
  //! AMENITY ICON
  //============================================================================

  /// Returns the appropriate icon for each amenity.
  IconData _getAmenityIcon(Amenity amenity) {
    switch (amenity) {
      case Amenity.wifi:
        return Icons.wifi;

      case Amenity.airConditioning:
        return Icons.ac_unit;

      case Amenity.kitchen:
        return Icons.countertops;

      case Amenity.laundry:
        return Icons.local_laundry_service;

      case Amenity.studyArea:
        return Icons.menu_book;

      case Amenity.cctv:
        return Icons.videocam;

      case Amenity.parking:
        return Icons.directions_car;

      case Amenity.waterIncluded:
        return Icons.water_drop;

      case Amenity.electricityIncluded:
        return Icons.bolt;

      case Amenity.privateBathroom:
        return Icons.bathroom;

      case Amenity.desk:
        return Icons.desk;

      case Amenity.cabinet:
        return Icons.shelves;

      case Amenity.security:
        return Icons.security;
    }
  }

  //============================================================================
  //! AMENITY LABEL
  //============================================================================

  /// Returns a readable amenity label.
  String _getAmenityLabel(Amenity amenity) {
    switch (amenity) {
      case Amenity.wifi:
        return 'Wi-Fi';

      case Amenity.airConditioning:
        return 'Aircon';

      case Amenity.kitchen:
        return 'Kitchen';

      case Amenity.laundry:
        return 'Laundry';

      case Amenity.studyArea:
        return 'Study Area';

      case Amenity.cctv:
        return 'CCTV';

      case Amenity.parking:
        return 'Parking';

      case Amenity.waterIncluded:
        return 'Water';

      case Amenity.electricityIncluded:
        return 'Electricity';

      case Amenity.privateBathroom:
        return 'Own CR';

      case Amenity.desk:
        return 'Desk';

      case Amenity.cabinet:
        return 'Cabinet';

      case Amenity.security:
        return 'Security';
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
        return _AmenityBox(
          title: _getAmenityLabel(amenity),
          icon: _getAmenityIcon(amenity),
        );
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
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}
