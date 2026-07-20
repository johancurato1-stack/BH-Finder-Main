import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! PROPERTY ACTION BUTTONS
//============================================================================

class PropertyActionButtons extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyActionButtons({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

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

        //======================================================================
        //! DELETE PROPERTY
        //======================================================================
        OutlinedButton(
          onPressed: onDeletePressed,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Delete Property',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
