import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/core/view_models/auth_view_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/auth/auth_header.dart';

import 'package:bh_finder/roles/tenant/features/auth/login/shared/widgets/login_screen_form.dart';
import 'package:bh_finder/roles/tenant/features/auth/login/shared/widgets/login_screen_register_prompt.dart';
import 'package:bh_finder/roles/tenant/features/auth/login/shared/widgets/social_login_section.dart';
import 'package:bh_finder/roles/tenant/features/auth/forgot_password/screens/forgot_password_screen.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';
import 'package:bh_finder/shared/widgets/dialogs/primary_dialog.dart';

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
      final message = error.toString();

      if (message.contains('Email not confirmed')) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => PrimaryDialog(
            icon: Icons.mark_email_unread_rounded,
            iconColor: Colors.orange,
            title: 'Email Not Verified',
            message:
                'Please verify your email before logging in.\n\n'
                'Check your inbox and click the verification link.',
            buttonText: 'Resend Email',
            onPressed: () async {
              Navigator.of(context).pop();

              try {
                await _viewModel.resendEmailVerification(
                  email: _emailController.text.trim(),
                );

                if (!mounted) return;

                await showDialog(
                  context: context,
                  builder: (_) => PrimaryDialog(
                    icon: Icons.mark_email_read_rounded,
                    iconColor: Colors.green,
                    title: 'Verification Email Sent',
                    message:
                        'We have sent another verification email.\n\n'
                        'Please check your inbox and click the verification link before logging in.',
                    buttonText: 'OK',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              } catch (error) {
                if (!mounted) return;

                await showDialog(
                  context: context,
                  builder: (_) => PrimaryDialog(
                    icon: Icons.error_outline_rounded,
                    iconColor: Colors.red,
                    title: 'Unable to Send Email',
                    message: _viewModel.getFriendlyAuthError(error),
                    buttonText: 'OK',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              }
            },
          ),
        );

        return;
      }

      setState(() {
        _viewModel.setLoginError(_viewModel.getFriendlyAuthError(error));
      });
    }
  }

  //============================================================================
  //! FORGOT PASSWORD
  //============================================================================

  Future<void> _forgotPassword() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
    );

    _emailController.clear();
    _passwordController.clear();

    _viewModel.resetValidation();

    if (mounted) {
      setState(() {});
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
                  onForgotPassword: _forgotPassword,
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
