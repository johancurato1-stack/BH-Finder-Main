import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

//==============================================================================
//! PRIMARY DROPDOWN FIELD
//==============================================================================
//
//? A reusable dropdown field used throughout the application.
//
//* Supports:
//* - Generic dropdown items
//* - Prefix icon
//* - Validation states
//* - Consistent styling with PrimaryTextField
//
//==============================================================================

class PrimaryDropdownField<T> extends StatelessWidget {
  final T? value;

  final String hintText;

  final IconData prefixIcon;

  final List<DropdownMenuItem<T>> items;

  final ValueChanged<T?> onChanged;

  //----------------------------------------------------------------------------
  //! Validation
  //----------------------------------------------------------------------------

  final FieldValidation validation;

  //----------------------------------------------------------------------------
  //! Future-ready
  //----------------------------------------------------------------------------

  final bool enabled;

  const PrimaryDropdownField({
    super.key,
    required this.value,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.onChanged,
    this.validation = const FieldValidation(),
    this.enabled = true,
  });

  //============================================================================
  //! BORDER COLOR
  //============================================================================

  Color get _borderColor {
    switch (validation.state) {
      case ValidationState.valid:
        return Colors.green;

      case ValidationState.invalid:
        return Colors.red;

      case ValidationState.neutral:
        return AppColors.tertiary;
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,

      items: items,

      onChanged: enabled ? onChanged : null,

      isExpanded: true,

      style: AppTextStyles.body,

      dropdownColor: AppColors.background,

      borderRadius: BorderRadius.circular(AppRadius.sm),

      menuMaxHeight: 220,

      decoration: InputDecoration(
        hintText: hintText,

        floatingLabelBehavior: FloatingLabelBehavior.never,

        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.sm,
        ),

        prefixIcon: Icon(prefixIcon, color: AppColors.secondary),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: _borderColor, width: 1),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: BorderSide(color: _borderColor, width: 1),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.tertiary, width: 1),
        ),

        hintStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),

        labelStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),
      ),

      // Keep original dropdown arrow.
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: AppColors.tertiary,
      ),
    );
  }
}
