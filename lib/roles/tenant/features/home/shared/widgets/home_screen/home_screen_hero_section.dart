import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! HOME SCREEN HERO SECTION
//============================================================================

class HomeScreenHeroSection extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreenHeroSection({super.key});

  //============================================================================
  //! TEXT STYLES
  //============================================================================

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 32,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  static const TextStyle _subtitleStyle = TextStyle(
    fontSize: 15,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: AppColors.secondary,
  );

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //======================================================================
        //! HERO TITLE
        //======================================================================
        _HeroTitle(),

        SizedBox(height: 12),

        //======================================================================
        //! HERO SUBTITLE
        //======================================================================
        Text('Simple. Trusted. Affordable.', style: _subtitleStyle),
      ],
    );
  }
}

//============================================================================
//! HERO TITLE
//============================================================================

class _HeroTitle extends StatelessWidget {
  const _HeroTitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        style: HomeScreenHeroSection._titleStyle,

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
    );
  }
}
