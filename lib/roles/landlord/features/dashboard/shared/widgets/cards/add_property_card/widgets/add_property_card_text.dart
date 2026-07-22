import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class AddPropertyCardText extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const AddPropertyCardText({super.key});

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Add Boarding House",
          style: AppTextStyles.heading3,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppSpacing.xs),

        Text(
          "Start listing another\nboarding house.",
          textAlign: TextAlign.center,
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }
}
