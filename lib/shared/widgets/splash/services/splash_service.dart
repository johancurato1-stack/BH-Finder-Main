import 'dart:async';

import 'package:flutter/material.dart';

class SplashService {
  const SplashService();

  //============================================================================
  //! INITIALIZE APP
  //============================================================================

  Future<void> initialize(
    BuildContext context, {
    required Widget destination,
    Duration duration = const Duration(seconds: 3),
  }) async {
    await Future.delayed(duration);

    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => destination),
      (route) => false,
    );
  }
}
