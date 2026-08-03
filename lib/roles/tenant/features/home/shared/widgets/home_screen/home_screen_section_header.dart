import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! HOME SCREEN SECTION HEADER
//============================================================================

class HomeScreenSectionHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreenSectionHeader({
    super.key,
    required this.title,
    required this.onSeeAll,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final String title;

  final VoidCallback onSeeAll;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        //======================================================================
        //! SECTION TITLE
        //======================================================================
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: AppColors.secondary,
          ),
        ),

        //======================================================================
        //! SEE ALL BUTTON
        //======================================================================
        _SeeAllButton(onTap: onSeeAll),
      ],
    );
  }
}

//============================================================================
//! SEE ALL BUTTON
//============================================================================

class _SeeAllButton extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const _SeeAllButton({required this.onTap});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final VoidCallback onTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),

      onTap: onTap,

      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),

        child: Text(
          'See all',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Roboto',
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
