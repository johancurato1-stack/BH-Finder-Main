import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/shared/widgets/cards/property_room_card/widgets/property_room_image.dart';
import 'package:bh_finder/shared/widgets/cards/property_room_card/widgets/property_room_info.dart';
import 'package:bh_finder/shared/widgets/cards/property_room_card/widgets/property_room_arrow.dart';

class PropertyRoomCard extends StatelessWidget {
  //* Room data to display.
  final RoomModel room;

  //* Called when the card is tapped.
  final VoidCallback onTap;

  const PropertyRoomCard({super.key, required this.room, required this.onTap});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //* Called when the user taps the room card.
      onTap: onTap,

      child: Container(
        //* Space between room cards.
        margin: const EdgeInsets.only(bottom: 12),

        //* Internal spacing.
        padding: const EdgeInsets.all(12),

        //* Card appearance.
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.tertiary.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),

        child: Row(
          children: [
            //============================================================================
            //! ROOM IMAGE
            //============================================================================
            PropertyRoomImage(room: room),

            const SizedBox(width: 12),

            //============================================================================
            //! ROOM INFORMATION
            //============================================================================
            Expanded(child: PropertyRoomInfo(room: room)),

            //============================================================================
            //! ARROW INDICATOR
            //============================================================================
            PropertyRoomArrow(room: room),
          ],
        ),
      ),
    );
  }
}
