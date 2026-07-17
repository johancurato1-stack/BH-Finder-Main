import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class HomeScreenHeroSection extends StatelessWidget {
  const HomeScreenHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //============================================================================
        //! HERO TITLE
        //============================================================================
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
            children: [
              TextSpan(
                text: 'Find your\nnext home,\n',
                style: TextStyle(color: AppColors.secondary),
              ),
              TextSpan(
                text: 'near your school.',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),

        SizedBox(height: 12),

        //============================================================================
        //! HERO SUBTITLE
        //============================================================================
        Text(
          'Simple. Trusted. Affordable.',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
