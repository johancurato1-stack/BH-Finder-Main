import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class SplashScreenLoading extends StatelessWidget {
  const SplashScreenLoading({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 25),

      child: CircularProgressIndicator(color: AppColors.secondary),
    );
  }
}
