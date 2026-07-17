import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/widgets/property_stats_row.dart';

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
  //! HELPERS
  //==========================================================================

  Color _getStatusColor() {
    switch (boardingHouse.status.toLowerCase()) {
      case 'occupied':
        return const Color(0xFFEF5350);

      case 'pending':
        return const Color(0xFFFFB300);

      case 'available':
      default:
        return const Color(0xFF00E676);
    }
  }

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
                //==========================================================
                //! IMAGE
                //==========================================================
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        boardingHouse.imageUrl,
                        width: 120,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: _getStatusColor(),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: AppSpacing.md),

                //==========================================================
                //! INFORMATION
                //==========================================================
                Expanded(
                  child: SizedBox(
                    height: 110,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        //==================================================
                        //! TITLE
                        //==================================================
                        Text(
                          boardingHouse.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading3.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        //==================================================
                        //! DISTANCE
                        //==================================================
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.tertiary,
                            ),

                            const SizedBox(width: 3),

                            Expanded(
                              child: Text(
                                boardingHouse.distanceText,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.caption,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        //==================================================
                        //! GENDER
                        //==================================================
                        Row(
                          children: [
                            const Icon(
                              Icons.person_outline,
                              size: 12,
                              color: AppColors.secondary,
                            ),

                            const SizedBox(width: 2),

                            Text(
                              boardingHouse.genderRules,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
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
