import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! PROPERTY ACTION BUTTONS
//============================================================================

class PropertyDetailActionButtons extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailActionButtons({super.key, required this.onEditPressed});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onEditPressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //======================================================================
        //! EDIT PROPERTY
        //======================================================================
        PrimaryButton(text: 'Edit Property', onPressed: onEditPressed),

        const SizedBox(height: 12),
      ],
    );
  }
}
