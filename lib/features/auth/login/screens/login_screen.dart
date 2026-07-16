import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/features/auth/login/widgets/login_form.dart';
import 'package:bh_finder/features/auth/login/widgets/register_prompt.dart';
import 'package:bh_finder/features/auth/login/widgets/social_login_section.dart';
import 'package:bh_finder/shared/widgets/auth/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //============================================================================
                //! HEADER
                //============================================================================
                const AuthHeader(
                  label: 'Welcome Back! 👋',
                  title: 'Login to your account',
                  subtitle:
                      'Continue to manage your properties\nor find your perfect room.',
                ),

                //============================================================================
                //! LOGIN FORM
                //============================================================================
                LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),

                //============================================================================
                //! SOCIAL LOGIN
                //============================================================================
                const SocialLoginSection(),

                //============================================================================
                //! REGISTER PROMPT
                //============================================================================
                const RegisterPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
