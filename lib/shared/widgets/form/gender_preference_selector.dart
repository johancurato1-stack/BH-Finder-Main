import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

//============================================================================
//! GENDER PREFERENCE SELECTOR
//============================================================================
//
//? A reusable selector for choosing the preferred tenant gender.
//
//============================================================================

class GenderPreferenceSelector extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const GenderPreferenceSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final GenderPreference? value;

  final ValueChanged<GenderPreference> onChanged;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _GenderOptionCard(
            title: 'Male',
            icon: Icons.male,
            selected: value == GenderPreference.male,
            onTap: () => onChanged(GenderPreference.male),
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        Expanded(
          child: _GenderOptionCard(
            title: 'Female',
            icon: Icons.female,
            selected: value == GenderPreference.female,
            onTap: () => onChanged(GenderPreference.female),
          ),
        ),
      ],
    );
  }
}

//============================================================================
//! GENDER OPTION CARD
//============================================================================

class _GenderOptionCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const _GenderOptionCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String title;

  final IconData icon;

  final bool selected;

  final VoidCallback onTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.tertiary,
            width: 0.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 42,
              color: selected ? AppColors.primary : AppColors.tertiary,
            ),

            const SizedBox(height: AppSpacing.md),

            Text(
              title,
              style: AppTextStyles.bodyBold.copyWith(
                color: selected ? AppColors.primary : AppColors.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
