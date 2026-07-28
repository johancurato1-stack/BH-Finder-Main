import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_header.dart';
import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_list.dart';

//============================================================================
//! FAVORITES SCREEN
//============================================================================

class FavoritesScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FavoritesScreen({
    super.key,
    required this.onBackPressed,
    required this.propertyRepository,
    required this.roomRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onBackPressed;

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //==============================================================
            //! HEADER
            //==============================================================
            FavoritesScreenHeader(onBackPressed: onBackPressed),

            //==============================================================
            //! SAVED LIST
            //==============================================================
            Expanded(
              child: FavoritesScreenList(
                propertyRepository: propertyRepository,

                roomRepository: roomRepository,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
