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
import 'package:bh_finder/core/repositories/room_repository.dart';

//============================================================================
//! PROPERTY DETAIL SCREEN
//============================================================================

class PropertyDetailScreen extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyDetailScreen({
    super.key,
    required this.propertyId,
    required this.repository,
    required this.roomRepository,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final String propertyId;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  //==========================================================================
  //! STATE
  //==========================================================================

  PropertyDetailData? _data;

  bool _loading = true;

  int _selectedImage = 0;

  //==========================================================================
  //! LIFECYCLE
  //==========================================================================

  @override
  void initState() {
    super.initState();

    _loadProperty();
  }

  //==========================================================================
  //! LOAD PROPERTY
  //==========================================================================

  Future<void> _loadProperty() async {
    final data = await widget.repository.getPropertyDetail(widget.propertyId);

    if (!mounted) return;

    setState(() {
      _data = data;

      _loading = false;
    });
  }

  //==========================================================================
  //! METHODS
  //==========================================================================

  void _viewRooms() {
    if (_data == null) return;

    Navigator.push(
      context,

      MaterialPageRoute(
        builder: (_) => ManageRoomsScreen(
          PropertyName: _data!.title,
          rooms: _data!.rooms,
          roomRepository: widget.roomRepository,
        ),
      ),
    );
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
                  ImageCard(imageUrl: data.imageUrls[_selectedImage]),

                  const SizedBox(height: 16),

                  //==========================================================
                  //! PHOTO THUMBNAILS
                  //==========================================================
                  PhotoThumbnails(
                    images: data.imageUrls,

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
                  PropertyDetailHeader(data: data),

                  const SizedBox(height: 15),

                  PropertyDetailMetaRow(data: data),

                  const Divider(
                    height: 32,

                    thickness: .5,

                    color: AppColors.tertiary,
                  ),

                  //==========================================================
                  //! PERFORMANCE
                  //==========================================================
                  PropertyDetailPerformanceSection(),

                  const Divider(
                    height: 32,

                    thickness: .5,

                    color: AppColors.tertiary,
                  ),

                  //==========================================================
                  //! DESCRIPTION
                  //==========================================================
                  PropertyDescriptionSection(description: data.description),

                  const Divider(
                    height: 32,

                    thickness: .5,

                    color: AppColors.tertiary,
                  ),

                  //==========================================================
                  //! AMENITIES
                  //==========================================================
                  PropertyDetailAmenitiesGrid(amenities: data.amenities),

                  const SizedBox(height: 32),

                  const Divider(
                    height: 32,

                    thickness: .5,

                    color: AppColors.tertiary,
                  ),

                  //==========================================================
                  //! MANAGE ROOMS
                  //==========================================================
                  PropertyDetailBottomButton(
                    roomCount: data.roomCount,

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
                  PropertyDetailActionButtons(
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
