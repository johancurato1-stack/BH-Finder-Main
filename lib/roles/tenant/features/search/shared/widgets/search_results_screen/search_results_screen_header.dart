import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class SearchResultsScreenHeader extends StatelessWidget {
  const SearchResultsScreenHeader({super.key});

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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.secondary,
              size: 24,
            ),
          ),

          //============================================================================
          //! TITLE
          //============================================================================
          const Text(
            'Results',
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
