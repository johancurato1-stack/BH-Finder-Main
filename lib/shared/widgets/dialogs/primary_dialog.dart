import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/buttons/secondary_button.dart';

//==============================================================================
//! PRIMARY DIALOG
//==============================================================================
//
//? A reusable dialog used throughout the application.
//
//* Supports:
//* - Success dialogs
//* - Error dialogs
//* - Confirmation dialogs
//* - Custom icons
//* - Custom button text
//
//==============================================================================

class PrimaryDialog extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  const PrimaryDialog({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //==============================================================
            //! ICON
            //==============================================================
            Icon(icon, size: 64, color: iconColor),

            const SizedBox(height: AppSpacing.lg),

            //==============================================================
            //! TITLE
            //==============================================================
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: AppSpacing.md),

            //==============================================================
            //! MESSAGE
            //==============================================================
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),

            const SizedBox(height: AppSpacing.xl),

            //==============================================================
            //! BUTTON
            //==============================================================
            if (secondaryButtonText != null && onSecondaryPressed != null)
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: secondaryButtonText!,
                      onPressed: onSecondaryPressed!,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.md),

                  Expanded(
                    child: PrimaryButton(
                      text: buttonText,
                      onPressed: onPressed,
                    ),
                  ),
                ],
              )
            else
              PrimaryButton(text: buttonText, onPressed: onPressed),
          ],
        ),
      ),
    );
  }
}
