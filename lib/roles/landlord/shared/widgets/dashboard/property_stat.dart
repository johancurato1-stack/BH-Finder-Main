import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class PropertyStat extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyStat({super.key, required this.value, required this.label});

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final String value;
  final String label;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),

        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),

        child: Column(
          children: [
            Text(
              value,
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.xs),

            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
