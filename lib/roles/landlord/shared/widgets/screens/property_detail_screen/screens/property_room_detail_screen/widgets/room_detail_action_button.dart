import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

//============================================================================
//! ROOM ACTION BUTTONS
//============================================================================

class RoomActionButtons extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomActionButtons({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onEdit;

  final VoidCallback onDelete;

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

        //==========================================================================
        //! DELETE BUTTON
        //==========================================================================
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
            label: const Text(
              'Delete Room',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
