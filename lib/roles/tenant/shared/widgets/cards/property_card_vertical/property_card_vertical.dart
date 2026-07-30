import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/repositories/property_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/repositories/room_repository.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_footer.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_image.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_info.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

import 'package:bh_finder/core/favorites/respositories/favorite_repository.dart';

//============================================================================
//! PROPERTY CARD VERTICAL
//============================================================================

class PropertyCardVertical extends StatelessWidget {
  const PropertyCardVertical({
    super.key,
    required this.property,
    required this.repository,
    required this.roomRepository,
    required this.favoriteRepository,
    this.showAmenities = true,
  });

  final TenantPropertyCardData property;

  final PropertyRepository repository;

  final RoomRepository roomRepository;

  final bool showAmenities;

  final FavoriteRepository favoriteRepository;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => PropertyDetailScreen(
              propertyId: property.id,
              repository: repository,
              roomRepository: roomRepository,
              favoriteRepository: favoriteRepository,
            ),
            transitionsBuilder: (_, animation, __, child) {
              final offset = Tween(begin: const Offset(0, 1), end: Offset.zero)
                  .animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  );

              return SlideTransition(position: offset, child: child);
            },
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: .08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        clipBehavior: Clip.antiAlias,

        child: SizedBox(
          height: 128,

          child: Row(
            children: [
              PropertyCardImage(data: property),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      PropertyCardInfo(data: property),

                      const Spacer(),

                      PropertyCardFooter(
                        data: property,
                        showAmenities: showAmenities,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
