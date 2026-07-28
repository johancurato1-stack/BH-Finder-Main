import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/core/authentication/view_models/auth_view_model.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_text_field.dart';

class LoginScreenForm extends StatelessWidget {
  final AuthViewModel viewModel;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final VoidCallback onLogin;
  final VoidCallback onForgotPassword;

  const LoginScreenForm({
    super.key,

    required this.viewModel,

    required this.emailController,

    required this.passwordController,

    required this.onLogin,

    required this.onForgotPassword,
  });

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
        const Text('Email', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.sm),

        PrimaryTextField(
          controller: emailController,
          hintText: 'Enter your email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validation: viewModel.emailValidation,
          errorMessage: viewModel.loginError,
        ),

        const SizedBox(height: AppSpacing.sm),

        //============================================================================
        //! PASSWORD
        //============================================================================
        const Text('Password', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.sm),

        PrimaryTextField(
          controller: passwordController,
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_outline,
          isPasswordField: true,
          validation: viewModel.passwordValidation,
          errorMessage: viewModel.loginError,
        ),

        //============================================================================
        //! FORGET PASSWORD
        //============================================================================
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onForgotPassword,
            child: Text(
              'Forgot Password?',
              style: TextStyle(fontSize: 12, color: AppColors.primary),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! LOGIN BUTTON
        //============================================================================
        PrimaryButton(text: 'Login', onPressed: onLogin),

        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
