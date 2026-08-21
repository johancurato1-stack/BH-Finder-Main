import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/cards/add_room_card.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/cards/property_room_card/property_room_card.dart';

//============================================================================
//! MANAGE ROOMS LIST VIEW
//============================================================================

class ManageRoomsListView extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ManageRoomsListView({
    super.key,
    required this.rooms,
    required this.onAddRoom,
    required this.onRoomTap,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<RoomModel> rooms;

  final VoidCallback onAddRoom;

  final ValueChanged<RoomModel> onRoomTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        ...rooms.asMap().entries.map((entry) {
          final index = entry.key;
          final room = entry.value;

          return AnimatedEntrance(
            key: ValueKey(room.id),
            order: index,
            beginOffset: const Offset(-0.25, 0),
            child: PropertyRoomCard(room: room, onTap: () => onRoomTap(room)),
          );
        }),

        AnimatedEntrance(
          key: const ValueKey('add-room-card'),
          order: rooms.length,
          beginOffset: const Offset(-0.25, 0),
          child: AddRoomCard(onTap: onAddRoom),
        ),
      ],
    );
  }
}
