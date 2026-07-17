import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class SplashScreenLogo extends StatelessWidget {
  const SplashScreenLogo({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        //============================================================================
        //! LOGO
        //============================================================================
        Icon(Icons.home_work_rounded, size: 80, color: AppColors.primary),

        SizedBox(height: 20),

        //============================================================================
        //! APP NAME
        //============================================================================
        Text(
          'BH Finder',
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        //============================================================================
        //! TAGLINE
        //============================================================================
        Text(
          'Find your perfect boarding house',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Roboto',
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
