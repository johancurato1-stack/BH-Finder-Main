import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet_mini/filter_bottom_sheet_mini.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/widgets/view_rooms_availability_notice_card.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/widgets/view_rooms_list_view.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/widgets/view_rooms_status_filter_bar.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/widgets/view_rooms_header.dart';

class ViewRoomsScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ViewRoomsScreen({super.key, required this.bhName, required this.rooms});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String bhName;
  final List<RoomModel> rooms;

  @override
  State<ViewRoomsScreen> createState() => _ViewRoomsScreenState();
}

class _ViewRoomsScreenState extends State<ViewRoomsScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Available', 'Reserved', 'Occupied'];

  //============================================================================
  //! GETTERS
  //============================================================================

  List<RoomModel> get _filteredRooms {
    if (_selectedFilter == 'All') {
      return widget.rooms;
    }

    return widget.rooms
        .where(
          (room) => room.status.toLowerCase() == _selectedFilter.toLowerCase(),
        )
        .toList();
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
            ViewRoomsHeader(
              title: widget.bhName,
              onBack: () => Navigator.pop(context),
              onFilter: () => FilterBottomSheetMini.show(context),
            ),

            //==================================================================
            //! FILTER BAR
            //==================================================================
            RoomStatusFilterBar(
              filters: _filters,
              selectedFilter: _selectedFilter,
              onSelected: (filter) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
            ),

            //==================================================================
            //! CONTENT
            //==================================================================
            Expanded(
              child: Column(
                children: [
                  Expanded(child: RoomListView(rooms: _filteredRooms)),

                  const AvailabilityNoticeCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
