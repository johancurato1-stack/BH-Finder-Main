import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

//============================================================================
//! PROPERTY LIST VIEW
//============================================================================

class PropertyListView extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyListView({
    super.key,
    required this.properties,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final List<TenantPropertyCardData> properties;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        final property = properties[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PropertyDetailScreen(
                  propertyId: property.id,
                  repository: repository,
                  roomRepository: roomRepository,
                  favoriteRepository: favoriteRepository,
                ),
              ),
            );
          },
          child: PropertyCardVertical(
            property: property,
            repository: repository,
            roomRepository: roomRepository,
            favoriteRepository: favoriteRepository,
            showAmenities: false,
          ),
        );
      },
    );
  }
}
