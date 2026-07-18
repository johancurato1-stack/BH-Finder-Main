import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card/widgets/property_card_info.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card/widgets/property_card_preview.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/property_stats_row.dart';

class PropertyCard extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCard({super.key, required this.boardingHouse, this.onTap});

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final BoardingHouseModel boardingHouse;
  final VoidCallback? onTap;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: AppSpacing.sm,
        ),
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.10),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            //==============================================================
            //! TOP SECTION
            //==============================================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PropertyCardPreview(boardingHouse: boardingHouse),

                const SizedBox(width: AppSpacing.md),

                PropertyCardInfo(boardingHouse: boardingHouse),
              ],
            ),

            //==============================================================
            //! BOTTOM SECTION
            //==============================================================
            Row(
              children: [
                Expanded(child: PropertyStatsRow(boardingHouse: boardingHouse)),

                const SizedBox(width: AppSpacing.sm),

                const Icon(
                  Icons.chevron_right_rounded,
                  size: 26,
                  color: AppColors.tertiary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
