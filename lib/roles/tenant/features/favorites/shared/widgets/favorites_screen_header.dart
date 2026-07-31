import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class FavoritesScreenHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const FavoritesScreenHeader({
    super.key,
    required this.onBackPressed,
    required this.onFilterPressed,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onBackPressed;
  final VoidCallback onFilterPressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //==========================================================================
          //! BACK BUTTON
          //==========================================================================
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.secondary,
              size: 24,
            ),
          ),

          //==========================================================================
          //! TITLE
          //==========================================================================
          const Text(
            'Favorites',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: AppColors.secondary,
            ),
          ),

          //==========================================================================
          //! FILTER BUTTON
          //==========================================================================
          IconButton(
            onPressed: onFilterPressed,
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColors.primary,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
