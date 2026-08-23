import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/roles/landlord/features/dashboard/shared/widgets/cards/property_card_horizontal/widgets/property_card_stats_row.dart';

import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/widgets/property_card_vertical_info.dart';
import 'package:bh_finder/roles/landlord/features/properties/shared/widgets/cards/property_card_vertical/widgets/property_card_vertical_preview.dart';

//============================================================================
//! PROPERTY CARD VERTICAL
//============================================================================

class PropertyCardVertical extends StatefulWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardVertical({
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
  State<PropertyCardVertical> createState() => _PropertyCardVerticalState();
}

//============================================================================
//! STATE
//============================================================================

class _PropertyCardVerticalState extends State<PropertyCardVertical> {
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
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),

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

          //==================================================================
          //! TAP
          //==================================================================
          onTap: () {
            setState(() {
              _pressed = false;
            });

            widget.onTap();
          },

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),

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
                //==========================================================
                //! TOP SECTION
                //==========================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PropertyCardVerticalPreview(data: widget.data),

                    const SizedBox(width: AppSpacing.md),

                    PropertyCardVerticalInfo(data: widget.data),
                  ],
                ),

                //==========================================================
                //! BOTTOM SECTION
                //==========================================================
                Row(
                  children: [
                    Expanded(child: PropertyCardStatsRow(data: widget.data)),

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
        ),
      ),
    );
  }
}
