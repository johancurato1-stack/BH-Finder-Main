import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/repositories/room_repository.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/cards/property_room_card/property_room_card.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/cards/add_room_card.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/room_detail_screen.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_room_screen/add_room_screen.dart';

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
    required this.roomRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<RoomModel> rooms;

  final RoomRepository roomRepository;

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

      itemCount: rooms.length + 1,

      itemBuilder: (context, index) {
        //==============================================================
        //! ADD ROOM CARD
        //==============================================================

        if (index == rooms.length) {
          return AddRoomCard(
            onTap: () {
              Navigator.push(
                context,

                PageRouteBuilder(
                  pageBuilder: (_, animation, __) => const AddRoomScreen(),

                  transitionsBuilder: (_, animation, __, child) {
                    final offsetAnimation =
                        Tween<Offset>(
                          begin: const Offset(0, 1),

                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,

                            curve: Curves.easeOut,
                          ),
                        );

                    return SlideTransition(
                      position: offsetAnimation,

                      child: child,
                    );
                  },
                ),
              );
            },
          );
        }

        //==============================================================
        //! ROOM CARD
        //==============================================================

        final room = rooms[index];

        return PropertyRoomCard(
          room: room,

          onTap: () {
            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (_) => RoomDetailScreen(
                  roomId: room.id,

                  repository: roomRepository,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
