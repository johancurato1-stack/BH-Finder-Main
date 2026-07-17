import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class HomeScreenSectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const HomeScreenSectionHeader({
    super.key,
    required this.title,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //============================================================================
        //! SECTION TITLE
        //============================================================================
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: AppColors.secondary,
          ),
        ),

        //============================================================================
        //! SEE ALL BUTTON
        //============================================================================
        GestureDetector(
          onTap: onSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
