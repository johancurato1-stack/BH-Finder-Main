import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class SearchHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const SearchHeader({super.key, required this.onBackPressed});

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
          //============================================================================
          //! BACK BUTTON
          //============================================================================
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.secondary,
              size: 24,
            ),
          ),

          //============================================================================
          //! SCREEN TITLE
          //============================================================================
          const Text(
            'Search',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: AppColors.secondary,
            ),
          ),

          //============================================================================
          //! BALANCER
          //============================================================================
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
