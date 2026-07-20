import 'package:flutter/material.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/widgets/add_property_amenity_option.dart';

//============================================================================
//! AMENITIES
//============================================================================

class Amenities {
  static const List<AmenityOption> values = [
    AmenityOption(label: 'Wi-Fi', icon: Icons.wifi),

    AmenityOption(label: 'Aircon', icon: Icons.ac_unit),

    AmenityOption(label: 'Own CR', icon: Icons.bathroom),

    AmenityOption(label: 'Kitchen', icon: Icons.countertops),

    AmenityOption(label: 'Laundry', icon: Icons.local_laundry_service),

    AmenityOption(label: 'Study', icon: Icons.menu_book),

    AmenityOption(label: 'Desk', icon: Icons.desk),

    AmenityOption(label: 'Cabinet', icon: Icons.shelves),

    AmenityOption(label: 'CCTV', icon: Icons.videocam),

    AmenityOption(label: 'Security', icon: Icons.security),

    AmenityOption(label: 'Parking', icon: Icons.directions_car),
  ];
}
