import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/property_card_horizontal.dart';

class HomeScreenPropertyHorizontalList extends StatelessWidget {
  final List<BoardingHouseModel> boardingHouses;

  const HomeScreenPropertyHorizontalList({
    super.key,
    required this.boardingHouses,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: boardingHouses.length,
        itemBuilder: (context, index) {
          final boardingHouse = boardingHouses[index];

          return Row(
            children: [
              SizedBox(
                width: 160,
                height: 255,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: PropertyCardHorizontal(boardingHouse: boardingHouse),
                ),
              ),
              const SizedBox(width: 16),
            ],
          );
        },
      ),
    );
  }
}
