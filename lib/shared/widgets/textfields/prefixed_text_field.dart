import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

//============================================================================
//! PREFIXED TEXT FIELD
//============================================================================
//
//? A reusable form field with a fixed prefix and optional suffix.
//
//* Examples:
//* - ₱ | 2500
//* - 👥 | 4 Persons
//
//============================================================================

class PrefixedTextField extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PrefixedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixText,
    this.prefixIcon,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.readOnly = false,
  }) : assert(
         prefixText != null || prefixIcon != null,
         'Either prefixText or prefixIcon must be provided.',
       );

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TextEditingController controller;

  final String hintText;

  final String? prefixText;

  final IconData? prefixIcon;

  final String? suffix;

  final TextInputType keyboardType;

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
      style: AppTextStyles.body,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
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

      prefixIcon: Container(
        width: 52,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(color: AppColors.tertiary, width: 0.5),
          ),
        ),
        child: prefixIcon != null
            ? Icon(prefixIcon, color: AppColors.secondary, size: 22)
            : Text(
                prefixText!,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
      ),

      prefixIconConstraints: const BoxConstraints(minWidth: 52, maxWidth: 52),

      suffixText: suffix,
      suffixStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),

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
