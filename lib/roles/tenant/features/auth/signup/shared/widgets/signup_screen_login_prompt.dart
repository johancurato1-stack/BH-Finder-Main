import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/auth/login/screens/login_screen.dart';

class SignupScreenLoginPrompt extends StatelessWidget {
  const SignupScreenLoginPrompt({super.key});

  //============================================================================
  //! NAVIGATE TO LOGIN
  //============================================================================

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Roboto',
            color: AppColors.tertiary,
          ),
        ),
        GestureDetector(
          onTap: () => _navigateToLogin(context),
          child: const Text(
            'Login',
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
