import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet_mini/filter_bottom_sheet_mini.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/widgets/view_rooms_availability_notice_card.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/widgets/view_rooms_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/view_rooms_screen/widgets/view_rooms_list_view.dart';

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
            //! CONTENT
            //==================================================================
            Expanded(
              child: Column(
                children: [
                  Expanded(child: RoomListView(rooms: widget.rooms)),

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
