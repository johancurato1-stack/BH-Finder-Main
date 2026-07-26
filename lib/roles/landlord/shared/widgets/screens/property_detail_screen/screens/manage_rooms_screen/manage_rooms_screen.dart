import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/repositories/room_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/widgets/manage_rooms_header.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/widgets/manage_rooms_list_view.dart';

//============================================================================
//! MANAGE ROOMS SCREEN
//============================================================================

class ManageRoomsScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ManageRoomsScreen({
    super.key,
    required this.PropertyName,
    required this.rooms,
    required this.roomRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String PropertyName;

  final List<RoomModel> rooms;

  final RoomRepository roomRepository;

  @override
  State<ManageRoomsScreen> createState() => _ManageRoomsScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _ManageRoomsScreenState extends State<ManageRoomsScreen> {
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
              title: widget.PropertyName,

              onBack: () => Navigator.pop(context),
            ),

            //==================================================================
            //! CONTENT
            //==================================================================
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ManageRoomsListView(
                      rooms: widget.rooms,

                      roomRepository: widget.roomRepository,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
