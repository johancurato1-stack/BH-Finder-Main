import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/property_repository.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/screens/properties_screen_header.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/screens/properties_screen_list_view.dart';

import 'package:bh_finder/core/repositories/room_repository.dart';

//============================================================================
//! PROPERTIES SCREEN
//============================================================================

class PropertiesScreen extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertiesScreen({
    super.key,
    required this.onBackPressed,
    required this.propertyRepository,
    required this.roomRepository,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final VoidCallback onBackPressed;

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

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
            //==============================================================
            //! HEADER
            //==============================================================
            PropertiesScreenHeader(onBackPressed: onBackPressed),

            //==============================================================
            //! LIST
            //==============================================================
            Expanded(
              child: PropertiesScreenListView(
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
