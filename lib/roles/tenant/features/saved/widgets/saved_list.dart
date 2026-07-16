import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/providers/boarding_house_provider.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/bh_card_vertical.dart';

import 'package:bh_finder/roles/tenant/features/saved/widgets/empty_saved_state.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/bh_detail_screen.dart';

class SavedList extends StatelessWidget {
  const SavedList({super.key});

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
                        BhDetailScreen(boardingHouse: boardingHouse),
                  ),
                );
              },

              child: BhCardVertical(boardingHouse: boardingHouse),
            );
          },
        );
      },
    );
  }
}
