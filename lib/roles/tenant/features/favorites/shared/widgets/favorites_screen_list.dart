import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/providers/boarding_house_provider.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/empty_saved_state.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

class FavoritesScreenList extends StatelessWidget {
  const FavoritesScreenList({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardingHouseProvider>(
      builder: (context, provider, child) {
        final savedRooms = provider.savedRooms;

        //============================================================================
        //! EMPTY STATE
        //============================================================================

        if (savedRooms.isEmpty) {
          return const EmptySavedState();
        }

        //============================================================================
        //! SAVED LIST
        //============================================================================

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),

          itemCount: savedRooms.length,

          itemBuilder: (context, index) {
            final boardingHouse = savedRooms[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        PropertyDetailScreen(boardingHouse: boardingHouse),
                  ),
                );
              },

              child: PropertyCardVertical(boardingHouse: boardingHouse),
            );
          },
        );
      },
    );
  }
}
