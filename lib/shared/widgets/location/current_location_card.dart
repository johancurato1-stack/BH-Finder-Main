import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class CurrentLocationCard extends StatelessWidget {
  const CurrentLocationCard({
    super.key,
    required this.address,
    required this.isLocked,
    required this.isSelected,
    required this.isLoading,
    required this.onDetectLocation,
    required this.onRemoveLocation,
    required this.onCancelDetection,
  });

  final String? address;
  final bool isLocked;
  final bool isSelected;
  final VoidCallback onDetectLocation;
  final VoidCallback onRemoveLocation;
  final bool isLoading;
  final VoidCallback onCancelDetection;

  @override
  Widget build(BuildContext context) {
    final bool hasLocation = address != null && address!.trim().isNotEmpty;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.tertiary, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Location',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              if (hasLocation) ...[
                Text('Detected Address', style: AppTextStyles.body),

                const SizedBox(height: AppSpacing.xs),

                Text(address!, style: AppTextStyles.body),

                const SizedBox(height: AppSpacing.lg),
              ] else ...[
                Text(
                  'No location detected yet.',
                  style: AppTextStyles.subtitle,
                ),

                const SizedBox(height: AppSpacing.lg),
              ],

              IgnorePointer(
                ignoring: isLocked,
                child: SizedBox(
                  width: double.infinity,
                  child: _buildActionTile(
                    icon: isSelected
                        ? Icons.delete_outline_rounded
                        : Icons.my_location_rounded,
                    title: isLoading
                        ? 'Detecting Location...'
                        : isSelected
                        ? 'Remove Location'
                        : 'Detect Current Location',
                    iconColor: isSelected ? Colors.red : AppColors.primary,
                    isLoading: isLoading,
                    onTap: isLoading
                        ? onCancelDetection
                        : isSelected
                        ? onRemoveLocation
                        : onDetectLocation,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (isLocked)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.65),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
    required bool isLoading,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.tertiary, width: 0.5),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    )
                  : Icon(icon, color: iconColor),

              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: isLoading
                    ? RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyMedium,
                          children: [
                            const TextSpan(text: 'Detecting Location...\n'),
                            TextSpan(
                              text: 'Tap to Cancel',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.tertiary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(title, style: AppTextStyles.bodyMedium),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.tertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
