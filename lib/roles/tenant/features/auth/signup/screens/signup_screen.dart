import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/auth/auth_header.dart';

import 'package:bh_finder/roles/tenant/features/auth/signup/shared/widgets/signup_screen_form.dart';
import 'package:bh_finder/roles/tenant/features/auth/signup/shared/widgets/signup_screen_terms_section.dart';
import 'package:bh_finder/roles/tenant/features/auth/signup/shared/widgets/signup_screen_login_prompt.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //============================================================================
  //! STATE
  //============================================================================

  bool _agreedToTerms = false;

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

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
                  label: 'Create your account',
                  title: "Let's get started!",
                  subtitle:
                      'Join BH Finder today and experience\n'
                      'a better way to rent or manage.',
                ),

                //============================================================================
                //! SIGN UP FORM
                //============================================================================
                SignupScreenForm(
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                ),

                //============================================================================
                //! TERMS
                //============================================================================
                SignupScreenTermsSection(
                  agreedToTerms: _agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreedToTerms = value;
                    });
                  },
                ),

                const SizedBox(height: AppSpacing.xxl),

                //============================================================================
                //! LOGIN PROMPT
                //============================================================================
                const SignupScreenLoginPrompt(),

                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
