import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

//==============================================================================
//! CUSTOM TEXT FIELD
//==============================================================================
//
//? A reusable text field used throughout the application.
//
//* Supports:
//* - Normal text input
//* - Password input
//* - Custom keyboard types
//* - Prefix icon
//
//==============================================================================
class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPasswordField;
  final TextInputType keyboardType;

  //--------------------------------------------------------------------------
  //! Future-ready properties
  //--------------------------------------------------------------------------

  final bool enabled;
  final bool readOnly;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();

    //* Password fields start hidden.
    _obscureText = widget.isPasswordField;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //* Controller for reading and modifying text.
      controller: widget.controller,

      //* Keyboard type (email, phone, number, etc.).
      keyboardType: widget.keyboardType,

      //* Enables or disables user interaction.
      enabled: widget.enabled,

      //* Makes the field read-only when needed.
      readOnly: widget.readOnly,

      //* Maximum number of visible lines.
      maxLines: widget.isPasswordField ? 1 : widget.maxLines,

      //* Hides password characters.
      obscureText: _obscureText,

      //* Main text appearance.
      style: AppTextStyles.body,

      //* Input decoration.
      decoration: _buildInputDecoration(),
    );
  }

  //============================================================================
  //! INPUT DECORATION
  //============================================================================

  /// Builds the decoration used by every text field.
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      //* Placeholder text.
      hintText: widget.hintText,

      //* Prevents the label animation.
      floatingLabelBehavior: FloatingLabelBehavior.never,

      //* Internal spacing of the text field.
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.sm,
      ),

      //* Leading icon.
      prefixIcon: Icon(widget.prefixIcon, color: AppColors.secondary),

      //* Password visibility toggle.
      suffixIcon: widget.isPasswordField
          ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.tertiary,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
          : null,

      //* Border shown while inactive.
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.tertiary, width: 0.5),
      ),

      //* Border shown while focused.
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(color: AppColors.secondary, width: 0.5),
      ),

      //* Hint text style.
      hintStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),

      //* Label text style.
      labelStyle: AppTextStyles.body.copyWith(color: AppColors.tertiary),
    );
  }
}
