import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/splash/screens/splash_screen.dart';

import 'package:bh_finder/shared/widgets/auth/auth_coordinator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),

      home: const SplashScreen(destination: AuthCoordinator()),
    );
  }
}
