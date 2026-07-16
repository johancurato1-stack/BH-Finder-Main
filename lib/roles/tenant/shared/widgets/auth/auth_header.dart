import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.label,
    required this.title,
    required this.subtitle,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SizedBox(height: 60),

        //============================================================================
        //! LABEL
        //============================================================================
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 10),

        //============================================================================
        //! TITLE
        //============================================================================
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 10),

        //============================================================================
        //! SUBTITLE
        //============================================================================
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            color: AppColors.tertiary,
          ),
        ),

        const SizedBox(height: 18),
      ],
    );
  }
}
