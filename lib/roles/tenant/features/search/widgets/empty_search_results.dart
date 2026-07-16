import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class EmptySearchResults extends StatelessWidget {
  const EmptySearchResults({super.key});

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
          Icon(Icons.search_off_rounded, size: 64, color: AppColors.tertiary),

          SizedBox(height: 16),

          //============================================================================
          //! TITLE
          //============================================================================
          Text(
            'No Boarding Houses Found',
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
            'Try adjusting your filters\nor search another location.',
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
