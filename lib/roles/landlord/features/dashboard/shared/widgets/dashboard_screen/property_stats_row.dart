import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/dashboard/property_stat.dart';

class PropertyStatsRow extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyStatsRow({super.key, required this.boardingHouse});

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final BoardingHouseModel boardingHouse;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PropertyStat(
          value: boardingHouse.totalRooms.toString(),
          label: "Rooms",
        ),

        PropertyStat(
          value: boardingHouse.availableRooms.toString(),
          label: "Available",
        ),

        PropertyStat(
          value: boardingHouse.reservedRooms.toString(),
          label: "Reserved",
        ),

        PropertyStat(
          value: boardingHouse.occupiedRooms.toString(),
          label: "Occupied",
        ),
      ],
    );
  }
}
