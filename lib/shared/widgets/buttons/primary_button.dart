import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

//==============================================================================
//! PRIMARY BUTTON
//==============================================================================
//
//? A reusable button used throughout the application.
//
//* Supports:
//* - Primary button
//* - Secondary (outlined) button
//* - Optional leading icon
//* - Loading state
//
//==============================================================================

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final IconData? icon;
  final Color? iconColor;

  //----------------------------------------------------------------------------
  //! Loading
  //----------------------------------------------------------------------------

  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.icon,
    this.iconColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      //* Controls the overall button height.
      height: AppSpacing.buttonHeight,

      child: isSecondary
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: _secondaryButtonStyle(),
              child: _buildButtonContent(),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: _primaryButtonStyle(),
              child: _buildButtonContent(),
            ),
    );
  }

  //============================================================================
  //! BUTTON CONTENT
  //============================================================================

  /// Builds the content displayed inside the button.
  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //* Optional leading icon.
        if (icon != null) ...[
          Icon(icon, size: 28, color: iconColor ?? AppColors.secondary),
          const SizedBox(width: AppSpacing.sm),
        ],

        //* Button text.
        Text(
          text,
          style: isSecondary
              ? AppTextStyles.secondaryButton
              : AppTextStyles.button,
        ),
      ],
    );
  }

  //============================================================================
  //! BUTTON STYLES
  //============================================================================

  /// Style used by the primary button.
  ButtonStyle _primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColors.primary,
      disabledForegroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );
  }

  /// Style used by the secondary outlined button.
  ButtonStyle _secondaryButtonStyle() {
    return OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColors.tertiary, width: 0.5),
      disabledForegroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );
  }
}
