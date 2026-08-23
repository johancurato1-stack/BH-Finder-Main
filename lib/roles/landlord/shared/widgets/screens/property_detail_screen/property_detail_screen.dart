import 'package:flutter/material.dart';

import 'package:bh_finder/core/ui_models/property_detail_data.dart';
import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/repositories.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/shared/models/landlord_property_origin.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/add_property_screen/add_property_screen.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/screens/manage_rooms_screen/manage_rooms_screen.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/back_button_header.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/image_card.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/shared/widgets/photo_thumbnails.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_action_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_amenities_grid.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_bottom_button.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_description_section.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_header.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_meta_row.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/widgets/property_detail_performance_section.dart';

//============================================================================
//! PROPERTY DETAIL SCREEN
//============================================================================

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({
    super.key,
    required this.propertyId,
    required this.origin,
  });

  final String propertyId;

  final LandlordPropertyOrigin origin;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

//============================================================================
//! STATE
//============================================================================

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  //==========================================================================
  //! REPOSITORY
  //==========================================================================

  final PropertyRepository _propertyRepository =
      Repositories.instance.propertyRepository;

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
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    final data = await _propertyRepository.getPropertyDetail(widget.propertyId);

    if (!mounted) return;

    setState(() {
      _data = data;

      if (_selectedImage >= data.images.length) {
        _selectedImage = 0;
      }

      _loading = false;
    });
  }

  //==========================================================================
  //! VIEW ROOMS
  //==========================================================================

  Future<void> _viewRooms() async {
    if (_data == null) return;

    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ManageRoomsScreen(
          propertyId: _data!.id,
          propertyName: _data!.title,
          rooms: _data!.rooms,
        ),
      ),
    );

    if (!mounted || updated != true) {
      return;
    }

    await _loadProperty();

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  //==========================================================================
  //! EDIT PROPERTY
  //==========================================================================

  Future<void> _editProperty() async {
    if (_data == null) return;

    final updated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => AddPropertyScreen(property: _data)),
    );

    if (!mounted || updated != true) {
      return;
    }

    //========================================================================
    //! RETURN TO THE PREVIOUS SCREEN
    //!
    //! The AddPropertyScreen can return true after either updating OR
    //! deleting the property. Reloading here is unsafe because the property
    //! may have just been deleted.
    //========================================================================

    Navigator.pop(context, true);
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

    if (data.images.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: Text('No property images available.')),
      );
    }

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
                  ImageCard(imageUrl: data.images[_selectedImage].path),

                  const SizedBox(height: 16),

                  //==========================================================
                  //! PHOTO THUMBNAILS
                  //==========================================================
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
                  PropertyDetailPerformanceSection(data: data),

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
                  PropertyDetailActionButtons(onEditPressed: _editProperty),

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
