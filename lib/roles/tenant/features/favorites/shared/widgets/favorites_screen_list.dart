import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_empty_saved_state.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

//============================================================================
//! FAVORITES SCREEN LIST
//============================================================================

class FavoritesScreenList extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FavoritesScreenList({super.key});

  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  static final PropertyRepository _propertyRepository = PropertyRepository();

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final List<TenantPropertyCardData> savedProperties = _propertyRepository
        .getPropertyCards();

    //==========================================================================
    //! EMPTY STATE
    //==========================================================================

    if (savedProperties.isEmpty) {
      return const FavoritesScreenEmptySavedState();
    }

    //==========================================================================
    //! SAVED LIST
    //==========================================================================

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: savedProperties.length,
      itemBuilder: (context, index) {
        final property = savedProperties[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PropertyDetailScreen(propertyId: property.id),
              ),
            );
          },
          child: PropertyCardVertical(property: property),
        );
      },
    );
  }
}
