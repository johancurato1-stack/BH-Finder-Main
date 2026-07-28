import 'package:flutter/material.dart';

import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/property_card_stats_row.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/widgets/property_card_vertical_info.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/widgets/property_card_vertical_preview.dart';

import 'package:bh_finder/roles/landlord/shared/widgets/screens/property_detail_screen/property_detail_screen.dart';

//============================================================================
//! PROPERTY CARD VERTICAL
//============================================================================

class PropertyCardVertical extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardVertical({super.key, required this.data});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final LandlordPropertyCardData data;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                PropertyDetailScreen(propertyId: data.id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0, 1);
                  const end = Offset.zero;
                  const curve = Curves.easeOut;

                  final offsetAnimation = animation.drive(
                    Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve)),
                  );

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
          ),
        );
      },
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
              color: AppColors.black.withValues(alpha: .10),
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
                PropertyCardVerticalPreview(data: data),

                const SizedBox(width: AppSpacing.md),

                PropertyCardVerticalInfo(data: data),
              ],
            ),

            //==============================================================
            //! BOTTOM SECTION
            //==============================================================
            Row(
              children: [
                Expanded(child: PropertyCardStatsRow(data: data)),

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
