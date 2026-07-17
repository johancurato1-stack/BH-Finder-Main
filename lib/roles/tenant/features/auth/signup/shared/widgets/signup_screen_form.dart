import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_text_field.dart';

class SignupScreenForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignupScreenForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  //============================================================================
  //! CREATE ACCOUNT
  //============================================================================

  void _createAccount() {
    print('Creating account...');
    print(nameController.text);
    print(emailController.text);
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
        //! FULL NAME
        //============================================================================
        const Text('Full Name', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        SizedBox(
          height: 42,
          child: PrimaryTextField(
            controller: nameController,
            hintText: 'Enter your full name',
            prefixIcon: Icons.badge_outlined,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! EMAIL
        //============================================================================
        const Text('Email or Phone Number', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        SizedBox(
          height: 42,
          child: PrimaryTextField(
            controller: emailController,
            hintText: 'Enter your email or phone number',
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.emailAddress,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! PASSWORD
        //============================================================================
        const Text('Password', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        SizedBox(
          height: 42,
          child: PrimaryTextField(
            controller: passwordController,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            isPasswordField: true,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! CONFIRM PASSWORD
        //============================================================================
        const Text('Confirm Password', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        SizedBox(
          height: 42,
          child: PrimaryTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm your password',
            prefixIcon: Icons.lock_reset_outlined,
            isPasswordField: true,
          ),
        ),

        const SizedBox(height: AppSpacing.xxl),

        //============================================================================
        //! CREATE ACCOUNT BUTTON
        //============================================================================
        PrimaryButton(text: 'Create an account', onPressed: _createAccount),

        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}
