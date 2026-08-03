import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! PROPERTY DETAIL BOTTOM BUTTON
//============================================================================

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
  //! VARIABLES
  //============================================================================

  final int roomCount;

  final VoidCallback onPressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, bottomPadding + 12),

      child: PrimaryButton(
        text: 'View Rooms ($roomCount)',
        onPressed: onPressed,
      ),
    );
  }
}
