import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class TemporaryPropertiesScreen extends StatelessWidget {
  const TemporaryPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,

      body: Center(child: Text("Landlord Properties")),
    );
  }
}
