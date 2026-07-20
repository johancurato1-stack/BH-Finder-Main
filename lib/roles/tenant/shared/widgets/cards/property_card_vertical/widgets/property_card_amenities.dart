import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY AMENITIES
//============================================================================

class PropertyAmenities extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyAmenities({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData data;

  //============================================================================
  //! AMENITY ICON
  //============================================================================

  /// Returns the appropriate icon for each property amenity.
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
      children: data.amenities.map((amenity) {
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
          ),
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
