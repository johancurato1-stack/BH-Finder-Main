import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/roles/tenant/features/home/widgets/bh_card_horizontal.dart';

class BhHorizontalList extends StatelessWidget {
  final List<BoardingHouseModel> boardingHouses;

  const BhHorizontalList({super.key, required this.boardingHouses});

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
                  child: BhCardHorizontal(boardingHouse: boardingHouse),
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
