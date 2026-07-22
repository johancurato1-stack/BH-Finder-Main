import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet_secondary/filter_bottom_sheet_secondary.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/view_rooms_availability_notice_card.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/view_rooms_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/view_rooms_list_view.dart';

class ViewRoomsScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ViewRoomsScreen({
    super.key,
    required this.PropertyName,
    required this.rooms,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String PropertyName;
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
              title: widget.PropertyName,
              onBack: () => Navigator.pop(context),
              onFilter: () => FilterBottomSheetSecondary.show(context),
            ),

            //==================================================================
            //! CONTENT
            //==================================================================
            Expanded(
              child: Column(
                children: [
                  Expanded(child: ViewRoomListView(rooms: widget.rooms)),

                  const ViewRoomsAvailabilityNoticeCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
