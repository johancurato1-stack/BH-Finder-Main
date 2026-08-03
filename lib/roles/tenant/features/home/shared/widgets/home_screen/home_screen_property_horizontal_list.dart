import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/repositories/property_repository.dart';
import 'package:bh_finder/core/repositories/repositories/room_repository.dart';
import 'package:bh_finder/core/repositories/repositories/favorite_repository.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/property_card_horizontal.dart';

//============================================================================
//! HOME SCREEN PROPERTY HORIZONTAL LIST
//============================================================================

class HomeScreenPropertyHorizontalList extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreenPropertyHorizontalList({
    super.key,
    required this.properties,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
  });

  //============================================================================
  //! REPOSITORIES
  //============================================================================

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final FavoriteRepository favoriteRepository;

  //============================================================================
  //! DATA
  //============================================================================

  final List<TenantPropertyCardData> properties;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,

      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.symmetric(horizontal: 16),

        itemCount: properties.length,

        separatorBuilder: (_, __) => const SizedBox(width: 16),

        itemBuilder: (context, index) {
          final property = properties[index];

          return AnimatedEntrance(
            order: index + 4,

            child: SizedBox(
              width: 160,

              child: PropertyCardHorizontal(
                data: property,
                repository: repository,
                roomRepository: roomRepository,
                favoriteRepository: favoriteRepository,
              ),
            ),
          );
        },
      ),
    );
  }
}
