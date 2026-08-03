import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

//============================================================================
//! PROPERTY STAT
//============================================================================

class PropertyStat extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyStat({
    super.key,
    required this.value,
    required this.label,
    this.valueColor = AppColors.primary,
    this.animationOrder = 0,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final String value;

  final String label;

  final Color valueColor;

  final int animationOrder;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedEntrance(
        order: animationOrder,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            children: [
              //==============================================================
              //! VALUE
              //==============================================================
              Text(
                value,
                style: AppTextStyles.heading2.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: AppSpacing.xs),

              //==============================================================
              //! LABEL
              //==============================================================
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
