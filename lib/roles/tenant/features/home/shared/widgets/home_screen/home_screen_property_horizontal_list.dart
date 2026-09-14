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

class HomeScreenPropertyHorizontalList extends StatefulWidget {
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

  @override
  State<HomeScreenPropertyHorizontalList> createState() =>
      _HomeScreenPropertyHorizontalListState();
}

//============================================================================
//! STATE
//============================================================================

class _HomeScreenPropertyHorizontalListState
    extends State<HomeScreenPropertyHorizontalList> {
  //============================================================================
  //! ANIMATED PROPERTIES
  //============================================================================

  final Set<String> _animatedPropertyIds = {};

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

        itemCount: widget.properties.length,

        separatorBuilder: (_, __) => const SizedBox(width: 16),

        itemBuilder: (context, index) {
          final property = widget.properties[index];

          final shouldAnimate = !_animatedPropertyIds.contains(property.id);

          if (shouldAnimate) {
            _animatedPropertyIds.add(property.id);
          }

          final card = SizedBox(
            width: 160,

            child: PropertyCardHorizontal(
              key: ValueKey(property.id),
              data: property,
              repository: widget.repository,
              roomRepository: widget.roomRepository,
              favoriteRepository: widget.favoriteRepository,
            ),
          );

          if (!shouldAnimate) {
            return card;
          }

          return AnimatedEntrance(
            key: ValueKey('animation_${property.id}'),
            order: index + 4,
            child: card,
          );
        },
      ),
    );
  }
}
