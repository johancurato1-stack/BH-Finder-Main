import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class FavoritesScreenEmptySavedState extends StatelessWidget {
  const FavoritesScreenEmptySavedState({super.key});

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
            size: 42,
            color: AppColors.tertiary,
          ),

          SizedBox(height: 16),

          //============================================================================
          //! TITLE
          //============================================================================
          Text(
            'No Favorite Boarding Houses',
            style: TextStyle(
              fontSize: 16,
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
            'Heart boarding houses to\nview them here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Roboto',
              color: AppColors.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
