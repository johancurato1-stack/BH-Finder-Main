import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/splash/services/splash_service.dart';
import 'package:bh_finder/shared/widgets/splash/shared/widgets/splash_content.dart';

class SplashScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SplashScreen({super.key, required this.destination});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final Widget destination;

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

    _splashService.initialize(context, destination: widget.destination);
  }

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
