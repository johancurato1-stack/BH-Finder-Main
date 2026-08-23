import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';
import 'package:bh_finder/core/repositories/repositories/repositories.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_room_screen/add_room_screen.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/widgets/manage_rooms_header.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/widgets/manage_rooms_list_view.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/room_detail_screen.dart';

//============================================================================
//! MANAGE ROOMS SCREEN
//============================================================================

class ManageRoomsScreen extends StatefulWidget {
  const ManageRoomsScreen({
    super.key,
    required this.propertyId,
    required this.propertyName,
    required this.rooms,
  });

  final String propertyName;

  final List<RoomModel> rooms;

  final String propertyId;

  @override
  State<ManageRoomsScreen> createState() => _ManageRoomsScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _ManageRoomsScreenState extends State<ManageRoomsScreen> {
  //============================================================================
  //! REPOSITORY
  //============================================================================

  final RoomRepository _roomRepository = Repositories.instance.roomRepository;

  //============================================================================
  //! STATE
  //============================================================================

  late List<RoomModel> _rooms;

  //============================================================================
  //! LOAD ROOMS
  //============================================================================

  Future<void> _loadRooms() async {
    final rooms = await _roomRepository.getByProperty(widget.propertyId);

    if (!mounted) {
      return;
    }

    setState(() {
      _rooms = rooms;
    });
  }

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _rooms = List<RoomModel>.from(widget.rooms);
  }

  //============================================================================
  //! OPEN ADD ROOM
  //============================================================================

  Future<void> _openAddRoom() async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AddRoomScreen(propertyId: widget.propertyId),
      ),
    );

    if (!mounted || created != true) {
      return;
    }

    await _loadRooms();
  }

  //============================================================================
  //! OPEN ROOM
  //============================================================================

  Future<void> _openRoom(RoomModel room) async {
    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            RoomDetailScreen(roomId: room.id, repository: _roomRepository),
      ),
    );

    if (!mounted || updated != true) {
      return;
    }

    await _loadRooms();

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            //==================================================================
            //! HEADER
            //==================================================================
            ManageRoomsHeader(
              title: widget.propertyName,
              onBack: () => Navigator.pop(context),
              onAddRoom: _openAddRoom,
            ),

            //==================================================================
            //! CONTENT
            //==================================================================
            Expanded(
              child: ManageRoomsListView(
                rooms: _rooms,
                onAddRoom: _openAddRoom,
                onRoomTap: _openRoom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
