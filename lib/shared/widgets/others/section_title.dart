import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class SectionTitle extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SectionTitle({super.key, required this.title});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String title;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.secondary,
      ),
    );
  }
}
