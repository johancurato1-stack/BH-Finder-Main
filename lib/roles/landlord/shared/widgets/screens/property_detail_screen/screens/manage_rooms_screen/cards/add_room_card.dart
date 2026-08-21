import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

class AddRoomCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddRoomCard({super.key, required this.onTap});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),

        height: 104,

        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.tertiary.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 32,
              width: 32,

              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .10),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.add_rounded,
                color: AppColors.primary,
                size: 16,
              ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              "Add Property",
              style: AppTextStyles.heading3.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
