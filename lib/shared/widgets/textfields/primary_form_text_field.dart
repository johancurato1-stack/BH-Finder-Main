import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

//============================================================================
//! PRIMARY FORM FIELD
//============================================================================
//
//? A reusable text field designed for forms throughout the application.
//
//* Supports:
//* - Single-line and multi-line input
//* - Optional prefix icon
//* - Read-only mode
//* - Disabled state
//* - Custom keyboard types
//
//============================================================================

class PrimaryFormField extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PrimaryFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TextEditingController controller;

  final String hintText;

  final IconData? prefixIcon;

  final TextInputType keyboardType;

  final int maxLines;

  final bool enabled;

  final bool readOnly;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      style: AppTextStyles.body,
      decoration: _buildInputDecoration(),
    );
  }

  //============================================================================
  //! INPUT DECORATION
  //============================================================================

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: hintText,

      floatingLabelBehavior: FloatingLabelBehavior.never,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),

      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: AppColors.secondary)
          : null,

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.tertiary, width: 0.5),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.secondary, width: 0.5),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.tertiary, width: 0.5),
      ),

      hintStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),
    );
  }
}
