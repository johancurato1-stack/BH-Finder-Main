import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class TermsSection extends StatelessWidget {
  final bool agreedToTerms;
  final ValueChanged<bool> onChanged;

  const TermsSection({
    super.key,
    required this.agreedToTerms,
    required this.onChanged,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: agreedToTerms,
            activeColor: AppColors.primary,
            onChanged: (value) => onChanged(value ?? false),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Roboto',
                color: AppColors.tertiary,
              ),

              children: [
                const TextSpan(text: 'I agree '),

                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 12,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('Terms tapped');
                    },
                ),

                const TextSpan(text: ' and '),

                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    fontSize: 12,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('Privacy tapped');
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
