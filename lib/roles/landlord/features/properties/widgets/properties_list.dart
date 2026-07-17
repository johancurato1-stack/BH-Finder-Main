import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/providers/boarding_house_provider.dart';

import 'package:bh_finder/roles/landlord/features/properties/widgets/property_card.dart';
import 'package:bh_finder/roles/landlord/features/properties/widgets/add_property_card.dart';

class PropertiesList extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertiesList({super.key});

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    final boardingHouses = context
        .watch<BoardingHouseProvider>()
        .boardingHouses;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: boardingHouses.length + 1,
      itemBuilder: (context, index) {
        //====================================================================
        //! ADD BOARDING HOUSE CARD
        //====================================================================

        if (index == boardingHouses.length) {
          return AddPropertyCard(
            onTap: () {
              // TODO:
              // Navigate to Add Boarding House Screen.
            },
          );
        }

        //====================================================================
        //! PROPERTY CARD
        //====================================================================

        final boardingHouse = boardingHouses[index];

        return PropertyCard(
          boardingHouse: boardingHouse,
          onTap: () {
            // TODO:
            // Navigate to Property Detail Screen.
          },
        );
      },
    );
  }
}
