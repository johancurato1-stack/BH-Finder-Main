import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/room_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/room_detail_data.dart';

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
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailScreen({super.key, required this.roomId});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String roomId;

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  //============================================================================
  //! DEPENDENCIES
  //============================================================================

  final RoomRepository _repository = RoomRepository();

  //============================================================================
  //! STATE
  //============================================================================

  late final RoomDetailData _data;

  int _selectedImage = 0;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _data = _repository.getRoomDetail(widget.roomId);
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
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
            ImageCard(imageUrl: _data.imageUrls[_selectedImage]),

            const SizedBox(height: 16),

            //==============================================================
            //! PHOTO THUMBNAILS
            //==============================================================
            PhotoThumbnails(
              images: _data.imageUrls,
              selectedIndex: _selectedImage,
              onImageSelected: (index) {
                setState(() {
                  _selectedImage = index;
                });
              },
              onAddPhoto: () {
                // TODO: Add Photo
              },
            ),

            const SizedBox(height: 24),

            //==============================================================
            //! HEADER
            //==============================================================
            RoomHeader(data: _data),

            const SizedBox(height: 16),

            //==============================================================
            //! META
            //==============================================================
            RoomMetaRow(data: _data),

            const Divider(height: 32, thickness: .5, color: AppColors.tertiary),

            //==============================================================
            //! DESCRIPTION
            //==============================================================
            RoomDescriptionSection(description: _data.description),

            const SizedBox(height: 32),

            //==============================================================
            //! ACTION BUTTONS
            //==============================================================
            RoomActionButtons(
              onEdit: () {
                // TODO: Edit Room
              },
              onDelete: () {
                // TODO: Delete Room
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
