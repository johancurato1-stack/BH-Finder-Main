import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_amenity_option.dart';

//============================================================================
//! AMENITIES
//============================================================================

class Amenities {
  Amenities._();

  static const List<AddPropertyAmenityOption> values = [
    AddPropertyAmenityOption(
      type: Amenity.wifi,
      label: 'Wi-Fi',
      icon: Icons.wifi,
    ),

    AddPropertyAmenityOption(
      type: Amenity.airConditioning,
      label: 'Aircon',
      icon: Icons.ac_unit,
    ),

    AddPropertyAmenityOption(
      type: Amenity.privateBathroom,
      label: 'Own CR',
      icon: Icons.bathroom,
    ),

    AddPropertyAmenityOption(
      type: Amenity.kitchen,
      label: 'Kitchen',
      icon: Icons.countertops,
    ),

    AddPropertyAmenityOption(
      type: Amenity.laundry,
      label: 'Laundry',
      icon: Icons.local_laundry_service,
    ),

    AddPropertyAmenityOption(
      type: Amenity.studyArea,
      label: 'Study',
      icon: Icons.menu_book,
    ),

    AddPropertyAmenityOption(
      type: Amenity.desk,
      label: 'Desk',
      icon: Icons.desk,
    ),

    AddPropertyAmenityOption(
      type: Amenity.cabinet,
      label: 'Cabinet',
      icon: Icons.shelves,
    ),

    AddPropertyAmenityOption(
      type: Amenity.cctv,
      label: 'CCTV',
      icon: Icons.videocam,
    ),

    AddPropertyAmenityOption(
      type: Amenity.security,
      label: 'Security',
      icon: Icons.security,
    ),

    AddPropertyAmenityOption(
      type: Amenity.parking,
      label: 'Parking',
      icon: Icons.directions_car,
    ),
  ];
}
