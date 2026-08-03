import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/widgets/property_card_image.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/widgets/property_card_info.dart';
import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/widgets/property_card_stats_row.dart';

//============================================================================
//! PROPERTY CARD HORIZONTAL
//============================================================================

class PropertyCardHorizontal extends StatefulWidget {
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

  @override
  State<PropertyCardHorizontal> createState() => _PropertyCardHorizontalState();
}

//============================================================================
//! STATE
//============================================================================

class _PropertyCardHorizontalState extends State<PropertyCardHorizontal> {
  //==========================================================================
  //! STATE
  //==========================================================================

  bool _pressed = false;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOutCubic,
      scale: _pressed ? .97 : 1,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),

          splashColor: AppColors.primary.withValues(alpha: .08),

          highlightColor: Colors.transparent,

          onTapDown: (_) {
            setState(() {
              _pressed = true;
            });
          },

          onTapCancel: () {
            setState(() {
              _pressed = false;
            });
          },

          onTap: () {
            setState(() {
              _pressed = false;
            });

            widget.onTap();
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),

            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),

            decoration: BoxDecoration(
              color: AppColors.white,

              borderRadius: BorderRadius.circular(20),

              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: .08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //==========================================================
                //! IMAGE
                //==========================================================
                PropertyCardImage(data: widget.data),

                //==========================================================
                //! PROPERTY INFO
                //==========================================================
                PropertyCardInfo(data: widget.data),

                //==========================================================
                //! PROPERTY STATS
                //==========================================================
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.sm,
                    right: AppSpacing.sm,
                    bottom: AppSpacing.md,
                  ),
                  child: PropertyCardStatsRow(data: widget.data),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
