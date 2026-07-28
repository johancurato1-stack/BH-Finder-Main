import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/room_model.dart';

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
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      itemCount: rooms.length + 1,

      itemBuilder: (context, index) {
        //==============================================================
        //! ADD ROOM CARD
        //==============================================================

        if (index == rooms.length) {
          return AddRoomCard(onTap: onAddRoom);
        }

        //==============================================================
        //! ROOM CARD
        //==============================================================

        final room = rooms[index];

        return PropertyRoomCard(room: room, onTap: () => onRoomTap(room));
      },
    );
  }
}
