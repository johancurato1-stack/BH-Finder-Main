import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';
import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/property_card_vertical.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

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
  //! VARIABLES
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
        return AnimatedEntrance(
          order: index,

          beginOffset: const Offset(-0.25, 0),

          child: PropertyCardVertical(
            property: properties[index],
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
