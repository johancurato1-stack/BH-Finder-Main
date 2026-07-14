import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({super.key});

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
