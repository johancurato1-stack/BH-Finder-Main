import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/roles/tenant/features/auth/signup/screens/signup_screen.dart';

class LoginScreenRegisterPrompt extends StatelessWidget {
  const LoginScreenRegisterPrompt({super.key});

  //============================================================================
  //! NAVIGATE TO SIGN UP
  //============================================================================

  void _navigateToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SignupScreen()),
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
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Roboto',
            color: AppColors.tertiary,
          ),
        ),

        GestureDetector(
          onTap: () => _navigateToSignup(context),

          child: const Text(
            'Register',
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
