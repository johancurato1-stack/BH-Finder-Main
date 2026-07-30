import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/widgets/see_all_property_list_view.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/see_all_screen/widgets/see_all_header.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

//============================================================================
//! SEE ALL SCREEN
//============================================================================

class SeeAllScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SeeAllScreen({
    super.key,
    required this.title,
    required this.properties,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String title;

  final List<TenantPropertyCardData> properties;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

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
            SeeAllHeader(
              title: title,
              onBack: () => Navigator.pop(context),
              onFilter: () => FilterBottomSheet.show(context),
            ),

            //==================================================================
            //! PROPERTY LIST
            //==================================================================
            Expanded(
              child: PropertyListView(
                properties: properties,
                repository: repository,
                roomRepository: roomRepository,
                favoriteRepository: favoriteRepository,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
