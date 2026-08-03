import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/room_model.dart';
import 'package:bh_finder/core/models/room_search_filter_model.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet_secondary/filter_bottom_sheet_secondary.dart';

import 'package:bh_finder/shared/widgets/cards/information_notice_card.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/empty_rooms_screen.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/view_rooms_header.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/screens/view_rooms_screen/widgets/view_rooms_list_view.dart';

//============================================================================
//! VIEW ROOMS SCREEN
//============================================================================

class ViewRoomsScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ViewRoomsScreen({
    super.key,
    required this.propertyId,
    required this.propertyName,
    required this.repository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String propertyId;

  final String propertyName;

  final RoomRepository repository;

  @override
  State<ViewRoomsScreen> createState() => _ViewRoomsScreenState();
}

class _ViewRoomsScreenState extends State<ViewRoomsScreen> {
  //============================================================================
  //! STATE
  //============================================================================

  late RoomSearchFilterModel _filter;

  bool _isLoading = true;

  List<RoomModel> _rooms = [];

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _filter = const RoomSearchFilterModel();

    _refreshRooms();
  }

  //============================================================================
  //! REFRESH ROOMS
  //============================================================================

  Future<void> _refreshRooms() async {
    final rooms = await widget.repository.searchRooms(
      propertyId: widget.propertyId,
      filter: _filter,
    );

    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      setState(() {
        _rooms = rooms;
        _isLoading = false;
      });
    });
  }

  //============================================================================
  //! FILTER ROOMS
  //============================================================================

  Future<void> _filterRooms() async {
    final filter = await FilterBottomSheetSecondary.show(
      context,
      initialFilter: _filter,
    );

    if (filter == null) return;

    setState(() {
      _filter = filter;
      _isLoading = true;
    });

    await _refreshRooms();
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
            //==============================================================
            //! HEADER
            //==============================================================
            ViewRoomsHeader(
              title: widget.propertyName,
              onBack: () => Navigator.pop(context),
              onFilter: _filterRooms,
            ),

            //==============================================================
            //! CONTENT
            //==============================================================
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _rooms.isEmpty
                        ? const EmptyRoomsScreen()
                        : ViewRoomListView(
                            rooms: _rooms,
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
