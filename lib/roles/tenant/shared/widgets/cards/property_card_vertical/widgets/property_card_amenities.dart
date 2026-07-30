import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD AMENITIES
//============================================================================

class PropertyCardAmenities extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardAmenities({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData data;

  static const int _maxVisibleAmenities = 3;

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

  Widget _buildTile(Widget child) {
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

    final remaining = data.amenities.length - visibleAmenities.length;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        ...visibleAmenities.map(
          (amenity) => _buildTile(
            Icon(
              _iconForAmenity(amenity),
              size: 11,
              color: Colors.grey.shade600,
            ),
          ),
        ),

        if (remaining > 0)
          _buildTile(
            Text(
              '+$remaining',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
              ),
            ),
          ),
      ],
    );
  }
}
