import 'package:bh_finder/shared/widgets/others/section_title.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

enum LocationOption { gps, manual }

class LocationSelector extends StatelessWidget {
  const LocationSelector({
    super.key,
    required this.selectedOption,
    required this.onChanged,
    required this.lockedOption,
  });

  final LocationOption? selectedOption;
  final LocationOption? lockedOption;

  final ValueChanged<LocationOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Location'),

        const SizedBox(height: AppSpacing.sm),

        Text(
          'Choose how you would like to set the location of your boarding house.',
          style: AppTextStyles.subtitle,
        ),

        const SizedBox(height: AppSpacing.lg),

        _LocationOptionCard(
          icon: Icons.my_location_rounded,
          title: 'Use Current Location',
          subtitle: 'Automatically detect your current location.',
          value: LocationOption.gps,
          groupValue: selectedOption,
          isLocked: lockedOption == LocationOption.gps,
          onTap: () => onChanged(LocationOption.gps),
        ),

        const SizedBox(height: AppSpacing.md),

        _LocationOptionCard(
          icon: Icons.edit_location_alt_rounded,
          title: 'Enter Address Manually',
          subtitle: 'Enter the property address manually.',
          value: LocationOption.manual,
          groupValue: selectedOption,
          isLocked: lockedOption == LocationOption.manual,
          onTap: () => onChanged(LocationOption.manual),
        ),
      ],
    );
  }
}

class _LocationOptionCard extends StatelessWidget {
  const _LocationOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.isLocked,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  final LocationOption value;
  final LocationOption? groupValue;

  final bool isLocked;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bool selected = value == groupValue;

    return Stack(
      children: [
        IgnorePointer(
          ignoring: isLocked,
          child: InkWell(
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
                    color: selected ? AppColors.primary : AppColors.tertiary,
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

                  Radio<LocationOption>(
                    value: value,
                    groupValue: groupValue,
                    activeColor: AppColors.primary,
                    onChanged: isLocked ? null : (_) => onTap(),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (isLocked)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
          ),
      ],
    );
  }
}
