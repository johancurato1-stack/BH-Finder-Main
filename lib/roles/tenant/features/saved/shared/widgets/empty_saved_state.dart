import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class EmptySavedState extends StatelessWidget {
  const EmptySavedState({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          //============================================================================
          //! ICON
          //============================================================================
          Icon(
            Icons.favorite_border_rounded,
            size: 64,
            color: AppColors.tertiary,
          ),

          SizedBox(height: 16),

          //============================================================================
          //! TITLE
          //============================================================================
          Text(
            'No Saved Boarding Houses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
              color: AppColors.secondary,
            ),
          ),

          SizedBox(height: 8),

          //============================================================================
          //! SUBTITLE
          //============================================================================
          Text(
            'Save boarding houses to\nview them here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
