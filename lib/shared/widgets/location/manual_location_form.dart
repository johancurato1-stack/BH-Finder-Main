import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_form_text_field.dart';

class ManualLocationForm extends StatelessWidget {
  const ManualLocationForm({
    super.key,
    required this.provinceController,
    required this.cityController,
    required this.barangayController,
    required this.streetController,
    required this.landmarkController,
    required this.isLocked,
    required this.buttonText,
    required this.buttonColor,
    required this.onButtonPressed,
  });

  final TextEditingController provinceController;
  final TextEditingController cityController;
  final TextEditingController barangayController;
  final TextEditingController streetController;
  final TextEditingController landmarkController;

  final bool isLocked;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                'Manual Address',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                ),
              ),

              const SizedBox(height: AppSpacing.xs),

              Text(
                'Enter your boarding house address.',
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.lg),

              Stack(
                children: [
                  IgnorePointer(
                    ignoring: isLocked,
                    child: Column(
                      children: [
                        PrimaryFormField(
                          controller: provinceController,
                          hintText: 'Province *',
                        ),

                        const SizedBox(height: AppSpacing.md),

                        PrimaryFormField(
                          controller: cityController,
                          hintText: 'City / Municipality *',
                        ),

                        const SizedBox(height: AppSpacing.md),

                        PrimaryFormField(
                          controller: barangayController,
                          hintText: 'Barangay *',
                        ),

                        const SizedBox(height: AppSpacing.md),

                        PrimaryFormField(
                          controller: streetController,
                          hintText: 'Street / Purok',
                        ),

                        const SizedBox(height: AppSpacing.md),

                        PrimaryFormField(
                          controller: landmarkController,
                          hintText: 'Landmark (Optional)',
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
              ),

              const SizedBox(height: AppSpacing.xxxl),

              PrimaryButton(
                text: buttonText,
                backgroundColor: buttonColor,
                onPressed: onButtonPressed,
              ),

              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ],
    );
  }
}
