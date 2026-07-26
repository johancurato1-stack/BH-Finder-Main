import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/cards/property_room_card/property_room_card.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/room_detail_screen.dart';

import 'package:bh_finder/core/repositories/room_repository.dart';

class ViewRoomListView extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ViewRoomListView({
    super.key,
    required this.rooms,
    required this.repository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<RoomModel> rooms;

  final RoomRepository repository;

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
              MaterialPageRoute(
                builder: (_) =>
                    RoomDetailScreen(roomId: room.id, repository: repository),
              ),
            );
          },
        );
      },
    );
  }
}
