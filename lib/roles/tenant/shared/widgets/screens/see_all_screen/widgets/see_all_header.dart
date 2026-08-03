import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! SEE ALL HEADER
//============================================================================

class SeeAllHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SeeAllHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onFilter,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final String title;

  final VoidCallback onBack;

  final VoidCallback onFilter;

  //============================================================================
  //! TEXT STYLES
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
          //==============================================================
          //! BACK BUTTON
          //==============================================================
          IconButton(
            onPressed: onBack,

            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.secondary,
              size: 24,
            ),
          ),

          //==============================================================
          //! TITLE
          //==============================================================
          Text(title, style: _titleStyle),

          //==============================================================
          //! FILTER BUTTON
          //==============================================================
          IconButton(
            onPressed: onFilter,

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
