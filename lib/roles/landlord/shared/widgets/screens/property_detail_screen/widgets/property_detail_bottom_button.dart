import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

class PropertyDetailBottomButton extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailBottomButton({
    super.key,
    required this.roomCount,
    required this.onPressed,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final int roomCount;
  final VoidCallback onPressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: 'Manage Rooms ($roomCount)',
      onPressed: onPressed,
    );
  }
}
