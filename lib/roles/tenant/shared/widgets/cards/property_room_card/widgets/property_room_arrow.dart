import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyRoomArrow extends StatelessWidget {
  //* Room data to display.
  final RoomModel room;

  const PropertyRoomArrow({super.key, required this.room});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* Indicates the card is tappable.
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.tertiary,
        ),
      ],
    );
  }
}
