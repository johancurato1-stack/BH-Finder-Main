import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/property_info.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/dashboard_screen/property_stats_row.dart';

//============================================================================
//! BOARDING HOUSE CARD
//============================================================================

class PropertyCardHorizontal extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardHorizontal({super.key, required this.data, this.onTap});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final LandlordPropertyCardData data;

  final VoidCallback? onTap;

  //==========================================================================
  //! STATUS COLOR
  //==========================================================================

  Color _statusColor() {
    switch (data.status) {
      case PropertyStatus.available:
        return Colors.green;

      case PropertyStatus.occupied:
        return Colors.red;
    }
  }

  //==========================================================================
  //! STATUS LABEL
  //==========================================================================

  String _statusLabel() {
    switch (data.status) {
      case PropertyStatus.available:
        return 'Available';

      case PropertyStatus.occupied:
        return 'Occupied';
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
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.network(
                    data.coverImageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                //==============================================================
                //! STATUS CHIP
                //==============================================================
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //==================================================================
            //! PROPERTY INFO
            //==================================================================
            PropertyInfo(data: data),

            //==================================================================
            //! PROPERTY STATS
            //==================================================================
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpacing.sm,
                right: AppSpacing.sm,
                bottom: AppSpacing.md,
              ),
              child: PropertyStatsRow(data: data),
            ),
          ],
        ),
      ),
    );
  }
}
