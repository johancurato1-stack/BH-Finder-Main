import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/cards/property_room_card/widgets/property_room_arrow.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/cards/property_room_card/widgets/property_room_image.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/cards/property_room_card/widgets/property_room_info.dart';

//============================================================================
//! PROPERTY ROOM CARD
//============================================================================

class PropertyRoomCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyRoomCard({super.key, required this.room, required this.onTap});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  /// Room data to display.
  final RoomModel room;

  /// Called when the card is tapped.
  final VoidCallback onTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.tertiary.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //==============================================================
              //! ROOM IMAGE
              //==============================================================
              PropertyRoomImage(room: room),

              //==============================================================
              //! ROOM INFORMATION
              //==============================================================
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: PropertyRoomInfo(room: room),
                ),
              ),

              //==============================================================
              //! ARROW INDICATOR
              //==============================================================
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: PropertyRoomArrow(room: room),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
