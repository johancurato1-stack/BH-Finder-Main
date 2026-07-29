import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/view_models/room_detail_data.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_room_screen/add_room_screen.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/image_card.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/photo_thumbnails.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_action_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_description_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_header.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/property_room_detail_screen/widgets/room_detail_meta_row.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/back_button_header.dart';

//============================================================================
//! ROOM DETAIL SCREEN
//============================================================================

class RoomDetailScreen extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const RoomDetailScreen({
    super.key,
    required this.roomId,
    required this.repository,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final String roomId;

  final RoomRepository repository;

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  //==========================================================================
  //! STATE
  //==========================================================================

  RoomDetailData? _data;

  bool _loading = true;

  int _selectedImage = 0;

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    _loadRoom();
  }

  //==========================================================================
  //! LOAD ROOM
  //==========================================================================

  Future<void> _loadRoom() async {
    final data = await widget.repository.getRoomDetail(widget.roomId);

    if (!mounted) return;

    setState(() {
      _data = data;
      _loading = false;
    });
  }

  //==========================================================================
  //! EDIT ROOM
  //==========================================================================

  Future<void> _editRoom() async {
    if (_data == null) return;

    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddRoomScreen(propertyId: _data!.propertyId, room: _data),
      ),
    );

    if (updated == true) {
      await _loadRoom();

      if (!mounted) return;

      Navigator.pop(context, true);
    }
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    if (_loading || _data == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final data = _data!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            //==============================================================
            //! BACK BUTTON
            //==============================================================
            BackButtonHeader(onBackPressed: () => Navigator.pop(context)),

            const SizedBox(height: 4),

            //==============================================================
            //! ROOM IMAGE
            //==============================================================
            ImageCard(imageUrl: data.images[_selectedImage].path),

            const SizedBox(height: 16),

            //==============================================================
            //! PHOTO THUMBNAILS
            //==============================================================
            PhotoThumbnails(
              images: data.images,
              selectedIndex: _selectedImage,
              onImageSelected: (index) {
                setState(() {
                  _selectedImage = index;
                });
              },
            ),

            const SizedBox(height: 24),

            //==============================================================
            //! HEADER
            //==============================================================
            RoomDetailHeader(data: data),

            const SizedBox(height: 16),

            //==============================================================
            //! META
            //==============================================================
            RoomDetailMetaRow(data: data),

            const Divider(height: 32, thickness: .5, color: AppColors.tertiary),

            //==============================================================
            //! DESCRIPTION
            //==============================================================
            RoomDetailDescriptionSection(description: data.description),

            const SizedBox(height: 32),

            //==============================================================
            //! ACTION BUTTONS
            //==============================================================
            RoomDetailActionButtons(onEdit: _editRoom),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
