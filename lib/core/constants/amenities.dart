import 'package:flutter/material.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_amenity_option.dart';

//============================================================================
//! AMENITIES
//============================================================================

class Amenities {
  static const List<AddPropertyAmenityOption> values = [
    AddPropertyAmenityOption(label: 'Wi-Fi', icon: Icons.wifi),

    AddPropertyAmenityOption(label: 'Aircon', icon: Icons.ac_unit),

    AddPropertyAmenityOption(label: 'Own CR', icon: Icons.bathroom),

    AddPropertyAmenityOption(label: 'Kitchen', icon: Icons.countertops),

    AddPropertyAmenityOption(
      label: 'Laundry',
      icon: Icons.local_laundry_service,
    ),

    AddPropertyAmenityOption(label: 'Study', icon: Icons.menu_book),

    AddPropertyAmenityOption(label: 'Desk', icon: Icons.desk),

    AddPropertyAmenityOption(label: 'Cabinet', icon: Icons.shelves),

    AddPropertyAmenityOption(label: 'CCTV', icon: Icons.videocam),

    AddPropertyAmenityOption(label: 'Security', icon: Icons.security),

    AddPropertyAmenityOption(label: 'Parking', icon: Icons.directions_car),
  ];
}
