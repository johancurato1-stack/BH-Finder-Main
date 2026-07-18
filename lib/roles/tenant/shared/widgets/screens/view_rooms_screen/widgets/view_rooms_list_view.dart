import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_room_card/property_room_card.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_room_detail_screen/room_detail_screen.dart';

class RoomListView extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomListView({super.key, required this.rooms});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<RoomModel> rooms;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return const Center(child: Text('No rooms available.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];

        return PropertyRoomCard(
          room: room,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RoomDetailScreen(room: room)),
            );
          },
        );
      },
    );
  }
}
