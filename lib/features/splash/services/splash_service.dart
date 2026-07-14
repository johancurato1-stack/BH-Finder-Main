import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/features/auth/login/screens/login_screen.dart';

class SplashService {
  const SplashService();

  //============================================================================
  //! INITIALIZE APP
  //============================================================================

  Future<void> initialize(BuildContext context) async {
    // Simulate app initialization
    await Future.delayed(const Duration(seconds: 3));

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}
