import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  //============================================================================
  //! GOOGLE LOGIN
  //============================================================================

  void _googleLogin() {
    print('Google Login Tapped');
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //============================================================================
        //! DIVIDER
        //============================================================================
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColors.tertiary.withValues(alpha: 0.3),
                thickness: 1,
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text(
                'or continue with',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  color: AppColors.tertiary,
                ),
              ),
            ),

            Expanded(
              child: Divider(
                color: AppColors.tertiary.withValues(alpha: 0.3),
                thickness: 1,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! GOOGLE BUTTON
        //============================================================================
        PrimaryButton(
          text: 'Sign in with Google',
          isSecondary: true,
          onPressed: _googleLogin,
        ),

        const SizedBox(height: AppSpacing.massive),
      ],
    );
  }
}
