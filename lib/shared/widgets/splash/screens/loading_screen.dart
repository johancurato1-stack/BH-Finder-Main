import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/splash/shared/widgets/splash_content.dart';

class LoadingScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const LoadingScreen({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const SafeArea(child: SplashContent()),
    );
  }
}
