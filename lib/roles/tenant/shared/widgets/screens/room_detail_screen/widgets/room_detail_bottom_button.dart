import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

class RoomBottomCTA extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomBottomCTA({super.key, required this.onPressed});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onPressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        10,
        20,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      child: Column(
        children: [
          PrimaryButton(text: 'Inquire About This Room', onPressed: onPressed),

          const SizedBox(height: 8),

          const Text(
            "We'll connect you with the owner.",
            style: TextStyle(fontSize: 12, color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}
