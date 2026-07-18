import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/add_property_card.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

class PropertiesScreenListView extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertiesScreenListView({super.key});

  //==========================================================================
  //! REPOSITORIES
  //==========================================================================

  static final PropertyRepository _propertyRepository = PropertyRepository();

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    final List<LandlordPropertyCardData> properties = _propertyRepository
        .getLandlordPropertyCards();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: properties.length + 1,
      itemBuilder: (context, index) {
        //====================================================================
        //! ADD PROPERTY CARD
        //====================================================================

        if (index == properties.length) {
          return AddPropertyCard(
            onTap: () {
              // TODO:
              // Navigate to Add Property Screen.
            },
          );
        }

        //====================================================================
        //! PROPERTY CARD
        //====================================================================

        final property = properties[index];

        return PropertyCardVertical(
          data: property,
          onTap: () {
            // TODO:
            // Navigate to Property Detail Screen.
          },
        );
      },
    );
  }
}
