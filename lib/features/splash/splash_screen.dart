import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              // Logo
              Icon(Icons.home_work_rounded, size: 80, color: AppColors.primary),

              SizedBox(height: 20),

              // Title
              Text(
                'BH Finder',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),

              // Subtitle
              Text(
                'Find your perfect boarding house',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontFamily: 'Roboto',
                ),
              ),

              SizedBox(height: 25),

              // Loading indicator
              CircularProgressIndicator(color: AppColors.secondary),
            ],
          ),
        ),
      ),
    );
  }
}
