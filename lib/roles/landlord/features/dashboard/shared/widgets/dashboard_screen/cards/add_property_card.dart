import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class AddPropertyCard extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const AddPropertyCard({super.key, required this.onTap});

  //==========================================================================
  //! CALLBACK
  //==========================================================================

  final VoidCallback onTap;

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

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              //==============================================================
              //! ADD ICON
              //==============================================================
              Container(
                height: 72,
                width: 72,

                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .10),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.add_rounded,
                  color: AppColors.primary,
                  size: 42,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              //==============================================================
              //! TITLE
              //==============================================================
              Text(
                "Add Boarding House",
                style: AppTextStyles.heading3,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xs),

              //==============================================================
              //! SUBTITLE
              //==============================================================
              Text(
                "Start listing another\nboarding house.",
                textAlign: TextAlign.center,

                style: AppTextStyles.subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
