import 'package:flutter/material.dart';

import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/favorites/shared/widgets/favorites_screen_empty_saved_state.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

//============================================================================
//! FAVORITES SCREEN LIST
//============================================================================

class FavoritesScreenList extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FavoritesScreenList({
    super.key,
    required this.properties,
    required this.propertyRepository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<TenantPropertyCardData> properties;

  final PropertyRepository propertyRepository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return const FavoritesScreenEmptySavedState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: properties.length,
      itemBuilder: (context, index) => PropertyCardVertical(
        property: properties[index],
        repository: propertyRepository,
        roomRepository: roomRepository,
        favoriteRepository: favoriteRepository,
        showAmenities: false,
      ),
    );
  }
}
