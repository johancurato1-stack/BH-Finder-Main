import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//==============================================================================
//! SECONDARY BUTTON
//==============================================================================
//
//? A reusable outlined button.
//
//==============================================================================

class SecondaryButton extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconColor,
    this.isLoading = false,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String text;

  final VoidCallback onPressed;

  final IconData? icon;

  final Color? iconColor;

  final bool isLoading;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      isSecondary: true,
      icon: icon,
      iconColor: iconColor,
      isLoading: isLoading,
    );
  }
}
