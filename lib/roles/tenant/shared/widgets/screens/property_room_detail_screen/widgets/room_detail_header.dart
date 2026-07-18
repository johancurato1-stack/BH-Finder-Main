import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class RoomHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomHeader({super.key, required this.room});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomModel room;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==========================================================================
        //! TITLE
        //==========================================================================
        Text(
          room.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
          ),
        ),

        //==========================================================================
        //! PRICE
        //==========================================================================
        Text(
          '₱ ${room.price} / month',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
