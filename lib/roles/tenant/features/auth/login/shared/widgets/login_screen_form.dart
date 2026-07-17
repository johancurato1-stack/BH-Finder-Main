import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/navigation/screens/tenant_navigation_screen.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_text_field.dart';

class LoginScreenForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginScreenForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  //============================================================================
  //! LOGIN
  //============================================================================

  void _login(BuildContext context) {
    print('Email: ${emailController.text}');
    print('Password: ${passwordController.text}');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TenantNavigationScreen()),
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //============================================================================
        //! EMAIL
        //============================================================================
        const Text('Email or Phone Number', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.sm),

        SizedBox(
          height: 42,
          child: PrimaryTextField(
            controller: emailController,
            hintText: 'Enter your email or phone number',
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.emailAddress,
          ),
        ),

        const SizedBox(height: AppSpacing.sm),

        //============================================================================
        //! PASSWORD
        //============================================================================
        const Text('Password', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.sm),

        SizedBox(
          height: 42,
          child: PrimaryTextField(
            controller: passwordController,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            isPasswordField: true,
          ),
        ),

        const SizedBox(height: AppSpacing.huge),

        //============================================================================
        //! LOGIN BUTTON
        //============================================================================
        PrimaryButton(text: 'Login', onPressed: () => _login(context)),

        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
