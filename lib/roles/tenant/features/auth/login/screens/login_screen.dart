import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/core/view_models/auth_view_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/auth/auth_header.dart';

import 'package:bh_finder/roles/tenant/features/auth/login/shared/widgets/login_screen_form.dart';
import 'package:bh_finder/roles/tenant/features/auth/login/shared/widgets/login_screen_register_prompt.dart';
import 'package:bh_finder/roles/tenant/features/auth/login/shared/widgets/social_login_section.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //============================================================================
  //! VIEW MODEL
  //============================================================================

  final AuthViewModel _viewModel = AuthViewModel(
    repository: SupabaseAuthRepository(),
  );

  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    //==========================================================================
    //! EMAIL VALIDATION
    //==========================================================================

    _emailController.addListener(() {
      _viewModel.validateEmail(_emailController.text);

      _viewModel.clearLoginError();

      setState(() {});
    });

    //==========================================================================
    //! PASSWORD VALIDATION
    //==========================================================================

    _passwordController.addListener(() {
      _viewModel.validatePassword(_passwordController.text);

      _viewModel.clearLoginError();

      setState(() {});
    });
  }

  //============================================================================
  //! LOGIN
  //============================================================================

  Future<void> _login() async {
    try {
      await _viewModel.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _viewModel.setLoginError('Invalid email or password.');
      });
    }
  }

  //============================================================================
  //! DISPOSE
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
                      'Continue to manage your properties\n'
                      'or find your perfect room.',
                ),

                //============================================================================
                //! LOGIN FORM
                //============================================================================
                LoginScreenForm(
                  viewModel: _viewModel,

                  emailController: _emailController,

                  passwordController: _passwordController,

                  onLogin: _login,
                ),

                //============================================================================
                //! SOCIAL LOGIN
                //============================================================================
                const SocialLoginSection(),

                //============================================================================
                //! REGISTER PROMPT
                //============================================================================
                const LoginScreenRegisterPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
