import 'package:flutter/material.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/widgets/property_stat.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

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
  //! HELPERS
  //==========================================================================

  String _getAvailableRooms() {
    final parts = boardingHouse.availabilityCount.split('/');
    return parts.first;
  }

  String _getOccupiedRooms() {
    final parts = boardingHouse.availabilityCount.split('/');

    if (parts.length != 2) return "0";

    final occupied = int.parse(parts.last) - int.parse(parts.first);

    return occupied.toString();
  }

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

        PropertyStat(value: _getAvailableRooms(), label: "Available"),

        const PropertyStat(value: "0", label: "Reserved"),

        PropertyStat(value: _getOccupiedRooms(), label: "Occupied"),
      ],
    );
  }
}
