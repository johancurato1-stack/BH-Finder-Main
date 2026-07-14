import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key});

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
          onTap: () => Navigator.pop(context),

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
