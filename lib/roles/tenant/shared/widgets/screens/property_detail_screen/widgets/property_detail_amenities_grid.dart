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
  //! VARIABLES
  //============================================================================

  final List<Amenity> amenities;

  static const double _spacing = 10;

  //============================================================================
  //! AMENITY ICON
  //============================================================================

  IconData _iconForAmenity(Amenity amenity) {
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

  String _labelForAmenity(Amenity amenity) {
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
      spacing: _spacing,
      runSpacing: _spacing,

      children: amenities.map((amenity) {
        return _AmenityBox(
          title: _labelForAmenity(amenity),
          icon: _iconForAmenity(amenity),
        );
      }).toList(),
    );
  }
}

//============================================================================
//! AMENITY BOX
//============================================================================

class _AmenityBox extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const _AmenityBox({required this.title, required this.icon});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final String title;

  final IconData icon;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.sizeOf(context).width - 70) / 4;

    return Container(
      width: width,

      padding: const EdgeInsets.symmetric(vertical: 12),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .10),
            blurRadius: 3,
          ),
        ],
      ),

      child: Column(
        children: [
          //==============================================================
          //! ICON
          //==============================================================
          Icon(icon, size: 24, color: AppColors.tertiary),

          const SizedBox(height: 6),

          //==============================================================
          //! LABEL
          //==============================================================
          Text(
            title,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Roboto',
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
