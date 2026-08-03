import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/roles/tenant/features/auth/validators/field_validation.dart';

//==============================================================================
//! PRIMARY TEXT FIELD
//==============================================================================
//
//? A reusable text field used throughout the application.
//
//* Supports:
//* - Normal text input
//* - Password input
//* - Validation states
//* - Optional validation messages
//* - Success / Error icons
//* - Future expansion
//
//==============================================================================

class PrimaryTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;

  final bool isPasswordField;
  final TextInputType keyboardType;

  //----------------------------------------------------------------------------
  //! Validation
  //----------------------------------------------------------------------------

  final FieldValidation validation;

  final bool showValidationMessage;

  final String? errorMessage;

  //----------------------------------------------------------------------------
  //! Future-ready
  //----------------------------------------------------------------------------

  final bool enabled;
  final bool readOnly;
  final int maxLines;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.validation = const FieldValidation(),
    this.showValidationMessage = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.errorMessage,
  });

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.isPasswordField;
  }

  Color get _borderColor {
    if (widget.errorMessage != null) {
      return Colors.red;
    }

    switch (widget.validation.state) {
      case ValidationState.valid:
        return Colors.green;

      case ValidationState.invalid:
        return Colors.red;

      case ValidationState.neutral:
        return AppColors.tertiary;
    }
  }

  Widget? get _validationIcon {
    if (widget.errorMessage != null) {
      return const Icon(Icons.cancel, color: Colors.red, size: 20);
    }

    switch (widget.validation.state) {
      case ValidationState.valid:
        return const Icon(Icons.check_circle, color: Colors.green, size: 20);

      case ValidationState.invalid:
        return const Icon(Icons.cancel, color: Colors.red, size: 20);

      case ValidationState.neutral:
        return null;
    }
  }

  Widget? get _suffixIcon {
    if (!widget.isPasswordField) {
      return _validationIcon;
    }

    return SizedBox(
      width:
          widget.validation.state == ValidationState.neutral &&
              widget.errorMessage == null
          ? 48
          : 84,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_validationIcon != null) _validationIcon!,

          IconButton(
            splashRadius: 20,
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.isPasswordField ? 1 : widget.maxLines,
          obscureText: _obscureText,
          style: AppTextStyles.body,
          decoration: _buildInputDecoration(),
        ),

        if (widget.errorMessage != null ||
            (widget.showValidationMessage &&
                widget.validation.state == ValidationState.invalid))
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              widget.errorMessage ?? widget.validation.message ?? '',
              style: AppTextStyles.body.copyWith(
                color: Colors.red,
                fontSize: 10,
              ),
            ),
          ),
      ],
    );
  }

  //============================================================================
  //! INPUT DECORATION
  //============================================================================

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: widget.hintText,

      floatingLabelBehavior: FloatingLabelBehavior.never,

      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.sm,
      ),

      prefixIcon: Icon(widget.prefixIcon, color: AppColors.secondary),

      suffixIcon: _suffixIcon,

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

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),

      hintStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),

      labelStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),
    );
  }
}
