import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/providers/boarding_house_provider.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

class PropertyListView extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyListView({super.key, required this.boardingHouses});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<BoardingHouseModel> boardingHouses;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardingHouseProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: boardingHouses.length,
          itemBuilder: (context, index) {
            final boardingHouse = boardingHouses[index];

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
