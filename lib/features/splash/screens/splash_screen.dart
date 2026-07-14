import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/features/splash/services/splash_service.dart';
import 'package:bh_finder/features/splash/widgets/splash_loading.dart';
import 'package:bh_finder/features/splash/widgets/splash_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //============================================================================
  //! SERVICE
  //============================================================================

  final SplashService _splashService = const SplashService();

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _splashService.initialize(context);
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              //============================================================================
              //! LOGO
              //============================================================================
              SplashLogo(),

              //============================================================================
              //! LOADING
              //============================================================================
              SplashLoading(),
            ],
          ),
        ),
      ),
    );
  }
}
