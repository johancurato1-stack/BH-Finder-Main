import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class AddPropertyCardIcon extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const AddPropertyCardIcon({super.key});

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .10),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.add_rounded, color: AppColors.primary, size: 42),
    );
  }
}
