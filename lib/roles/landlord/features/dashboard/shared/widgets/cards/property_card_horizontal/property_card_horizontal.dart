import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/widgets/property_card_image.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/property_card_info.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/widgets/property_card_stats_row.dart';

//============================================================================
//! BOARDING HOUSE CARD
//============================================================================

class PropertyCardHorizontal extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardHorizontal({
    super.key,
    required this.data,
    required this.onTap,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final LandlordPropertyCardData data;

  final VoidCallback onTap;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //==================================================================
              //! IMAGE
              //==================================================================
              PropertyCardImage(data: data),

              //==================================================================
              //! PROPERTY INFO
              //==================================================================
              PropertyCardInfo(data: data),

              //==================================================================
              //! PROPERTY STATS
              //==================================================================
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.sm,
                  right: AppSpacing.sm,
                  bottom: AppSpacing.md,
                ),
                child: PropertyCardStatsRow(data: data),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
