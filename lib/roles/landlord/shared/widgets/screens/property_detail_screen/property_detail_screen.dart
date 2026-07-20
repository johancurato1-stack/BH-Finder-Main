import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/property_detail_data.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/image_card.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/photo_thumbnails.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/manage_rooms_screen.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/back_button_header.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_action_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_description_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_amenities_grid.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_bottom_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_header.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_meta_row.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_performance_section.dart';

//============================================================================
//! PROPERTY DETAIL SCREEN
//============================================================================

class PropertyDetailScreen extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyDetailScreen({super.key, required this.propertyId});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final String propertyId;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  //==========================================================================
  //! STATE
  //==========================================================================

  late final PropertyDetailData _data;

  int _selectedImage = 0;

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    _data = PropertyRepository().getPropertyDetail(widget.propertyId);
  }

  //==========================================================================
  //! METHODS
  //==========================================================================

  void _viewRooms() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ManageRoomsScreen(PropertyName: _data.title, rooms: _data.rooms),
      ),
    );
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  //==========================================================
                  //! TOP BAR
                  //==========================================================
                  BackButtonHeader(
                    onBackPressed: () => Navigator.pop(context),
                    onSharePressed: () {
                      // TODO: Share Property
                    },
                  ),

                  const SizedBox(height: 4),

                  //==========================================================
                  //! PROPERTY IMAGE
                  //==========================================================
                  ImageCard(imageUrl: _data.imageUrls[_selectedImage]),

                  const SizedBox(height: 16),

                  //==========================================================
                  //! PHOTO THUMBNAILS
                  //==========================================================
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

                  //==========================================================
                  //! HEADER
                  //==========================================================
                  PropertyHeader(data: _data),

                  const SizedBox(height: 15),

                  PropertyMetaRow(data: _data),

                  const Divider(
                    height: 32,
                    thickness: .5,
                    color: AppColors.tertiary,
                  ),
                  //==========================================================
                  //! PERFORMANCE
                  //==========================================================
                  PropertyPerformanceSection(),

                  const Divider(
                    height: 32,
                    thickness: .5,
                    color: AppColors.tertiary,
                  ),

                  //==========================================================
                  //! DESCRIPTION
                  //==========================================================
                  PropertyDescriptionSection(description: _data.description),

                  const Divider(
                    height: 32,
                    thickness: .5,
                    color: AppColors.tertiary,
                  ),

                  //==========================================================
                  //! AMENITIES
                  //==========================================================
                  PropertyAmenitiesGrid(amenities: _data.amenities),

                  const SizedBox(height: 32),

                  const Divider(
                    height: 32,
                    thickness: .5,
                    color: AppColors.tertiary,
                  ),

                  //==============================================================
                  //! MANAGE ROOMS
                  //==============================================================
                  PropertyBottomButton(
                    roomCount: _data.roomCount,
                    onPressed: _viewRooms,
                  ),

                  const SizedBox(height: 8),

                  const Divider(
                    height: 32,
                    thickness: .5,
                    color: AppColors.tertiary,
                  ),

                  //==========================================================
                  //! ACTION BUTTONS
                  //==========================================================
                  PropertyActionButtons(
                    onEditPressed: () {
                      // TODO: Edit Property
                    },
                    onDeletePressed: () {
                      // TODO: Delete Property
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
