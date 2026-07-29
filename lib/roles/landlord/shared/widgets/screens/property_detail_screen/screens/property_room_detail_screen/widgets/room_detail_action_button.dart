import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! ROOM ACTION BUTTONS
//============================================================================

class RoomDetailActionButtons extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailActionButtons({super.key, required this.onEdit});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onEdit;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //==========================================================================
        //! EDIT BUTTON
        //==========================================================================
        PrimaryButton(text: 'Edit Room', onPressed: onEdit),

        const SizedBox(height: 12),
      ],
    );
  }
}
