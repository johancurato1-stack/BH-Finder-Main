import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/shared/widgets/others/section_title.dart';

//============================================================================
//! ADD PROPERTY AVAILABILITY SECTION
//============================================================================

class AddPropertyAvailabilitySection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const AddPropertyAvailabilitySection({
    super.key,
    required this.status,
    required this.onChanged,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final PropertyStatus status;

  final ValueChanged<PropertyStatus> onChanged;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //======================================================================
        //! TITLE
        //======================================================================
        const SectionTitle(title: 'Availability'),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'Choose whether your property is currently accepting new tenants.',
          style: AppTextStyles.subtitle,
        ),

        const SizedBox(height: AppSpacing.lg),

        //======================================================================
        //! AVAILABLE
        //======================================================================
        _AvailabilityCard(
          icon: Icons.check_circle_rounded,
          title: 'Available',
          subtitle:
              'Students can view this property and send inquiries to the landlord.',
          value: PropertyStatus.available,
          groupValue: status,
          onTap: () => onChanged(PropertyStatus.available),
        ),

        const SizedBox(height: AppSpacing.md),

        //======================================================================
        //! OCCUPIED
        //======================================================================
        _AvailabilityCard(
          icon: Icons.block_rounded,
          title: 'Occupied',
          subtitle:
              'Students can view this property, but it is not currently accepting new tenants.',
          value: PropertyStatus.occupied,
          groupValue: status,
          onTap: () => onChanged(PropertyStatus.occupied),
        ),
      ],
    );
  }
}

//============================================================================
//! AVAILABILITY CARD
//============================================================================

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  final IconData icon;

  final String title;

  final String subtitle;

  final PropertyStatus value;

  final PropertyStatus groupValue;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.lg),
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
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: selected
                  ? (value == PropertyStatus.available
                        ? Colors.green
                        : Colors.red)
                  : AppColors.tertiary,
            ),

            const SizedBox(width: AppSpacing.lg),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyBold),

                  const SizedBox(height: AppSpacing.xs),

                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),

            Radio<PropertyStatus>(
              value: value,
              groupValue: groupValue,
              activeColor: AppColors.primary,
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
