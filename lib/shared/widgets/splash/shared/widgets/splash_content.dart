import 'package:flutter/material.dart';

import 'package:bh_finder/shared/widgets/splash/shared/widgets/splash_screen_loading.dart';
import 'package:bh_finder/shared/widgets/splash/shared/widgets/splash_screen_logo.dart';

class SplashContent extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SplashContent({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //==============================================================
          //! LOGO
          //==============================================================
          SplashScreenLogo(),

          //==============================================================
          //! LOADING
          //==============================================================
          SplashScreenLoading(),
        ],
      ),
    );
  }
}
