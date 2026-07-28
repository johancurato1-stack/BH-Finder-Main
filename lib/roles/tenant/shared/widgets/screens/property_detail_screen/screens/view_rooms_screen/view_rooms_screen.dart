import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet_secondary/filter_bottom_sheet_secondary.dart';

import 'package:bh_finder/shared/widgets/cards/information_notice_card.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/view_rooms_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/view_rooms_list_view.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

class ViewRoomsScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ViewRoomsScreen({
    super.key,
    required this.PropertyName,
    required this.rooms,
    required this.repository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String PropertyName;
  final List<RoomModel> rooms;
  final RoomRepository repository;

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
                  Expanded(
                    child: ViewRoomListView(
                      rooms: widget.rooms,
                      repository: widget.repository,
                    ),
                  ),

                  InformationNoticeCard(
                    icon: Icons.info_rounded,
                    message:
                        'Availability changes fast.\n'
                        'Inquire now to get the latest update from the owner.',
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
