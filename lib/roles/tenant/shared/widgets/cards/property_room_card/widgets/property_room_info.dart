import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyRoomInfo extends StatelessWidget {
  //* Room data to display.
  final RoomModel room;

  const PropertyRoomInfo({super.key, required this.room});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //* Room title.
        Text(
          room.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        //* Monthly rental price.
        Text(
          '₱ ${room.price} / month',
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 13),

        //* Room details.
        Row(
          children: [
            //* Gender icon.
            const Icon(
              Icons.person_outline,
              size: 15,
              color: AppColors.tertiary,
            ),

            const SizedBox(width: 6),

            //* Gender rules.
            Text(
              room.genderRules,
              style: const TextStyle(fontSize: 12, color: AppColors.tertiary),
            ),

            const SizedBox(width: 10),

            //* Capacity icon.
            const Icon(
              Icons.group_outlined,
              size: 15,
              color: AppColors.tertiary,
            ),

            const SizedBox(width: 6),

            //* Room capacity.
            Text(
              room.capacity,
              style: const TextStyle(fontSize: 12, color: AppColors.tertiary),
            ),
          ],
        ),
      ],
    );
  }
}
