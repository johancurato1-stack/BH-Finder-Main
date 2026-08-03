import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! SEARCH RESULTS SCREEN HEADER
//============================================================================

class SearchResultsScreenHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SearchResultsScreenHeader({super.key});

  //============================================================================
  //! TEXT STYLE
  //============================================================================

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontFamily: 'Roboto',
    color: AppColors.secondary,
  );

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
          //====================================================================
          //! BACK BUTTON
          //====================================================================
          IconButton(
            onPressed: () => Navigator.pop(context),

            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.secondary,
              size: 24,
            ),
          ),

          //====================================================================
          //! TITLE
          //====================================================================
          const Text('Results', style: _titleStyle),

          //====================================================================
          //! BALANCER
          //====================================================================
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
