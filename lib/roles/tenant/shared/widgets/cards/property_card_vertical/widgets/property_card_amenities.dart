import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD AMENITIES
//============================================================================

class PropertyCardAmenities extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardAmenities({super.key, required this.data});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TenantPropertyCardData data;

  static const int _maxVisibleAmenities = 3;

  static const double _iconSize = 11;

  //============================================================================
  //! ICON
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
  //! TILE
  //============================================================================

  Widget _buildTile({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(3),

      decoration: BoxDecoration(
        color: Colors.grey.shade100,

        border: Border.all(color: Colors.grey.shade300),

        borderRadius: BorderRadius.circular(4),
      ),

      child: child,
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final visibleAmenities = data.amenities.take(_maxVisibleAmenities).toList();

    final remainingCount = data.amenities.length - visibleAmenities.length;

    return Wrap(
      spacing: 4,
      runSpacing: 4,

      children: [
        //==============================================================
        //! VISIBLE AMENITIES
        //==============================================================
        ...visibleAmenities.map(
          (amenity) => _buildTile(
            child: Icon(
              _iconForAmenity(amenity),

              size: _iconSize,
              color: AppColors.tertiary,
            ),
          ),
        ),

        //==============================================================
        //! REMAINING COUNT
        //==============================================================
        if (remainingCount > 0)
          _buildTile(
            child: Text(
              '+$remainingCount',

              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
                color: AppColors.tertiary,
              ),
            ),
          ),
      ],
    );
  }
}
