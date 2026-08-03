import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/core/view_models/auth_view_model.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_text_field.dart';

import 'package:bh_finder/shared/widgets/dialogs/primary_dialog.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //============================================================================
  //! CONTROLLER
  //============================================================================

  final TextEditingController _emailController = TextEditingController();

  //============================================================================
  //! STATE
  //============================================================================

  bool _isLoading = false;

  //============================================================================
  //! VALIDATION TIMER
  //============================================================================

  Timer? _emailValidationTimer;

  //============================================================================
  //! VIEW MODEL
  //============================================================================

  final AuthViewModel _viewModel = AuthViewModel(
    repository: SupabaseAuthRepository(),
  );

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      _emailValidationTimer?.cancel();

      _emailValidationTimer = Timer(const Duration(milliseconds: 800), () {
        _viewModel.validateEmail(_emailController.text);

        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  //============================================================================
  //! SEND RESET LINK
  //============================================================================

  Future<void> _sendResetLink() async {
    _emailValidationTimer?.cancel();

    _viewModel.validateEmail(_emailController.text.trim());

    setState(() {});

    if (!_viewModel.emailValidation.isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _viewModel.resetPassword(email: _emailController.text.trim());

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => PrimaryDialog(
          icon: Icons.mark_email_read_rounded,
          iconColor: Colors.green,
          title: 'Email Sent',
          message:
              'If an account exists for this email address, a password reset link has been sent.',
          buttonText: 'OK',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(this.context);
          },
        ),
      );
    } catch (error) {
      if (!mounted) return;

      _viewModel.validateEmail('');

      setState(() {});

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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  //============================================================================
  //! DISPOSE
  //============================================================================

  @override
  void dispose() {
    _emailValidationTimer?.cancel();

    _emailController.dispose();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),

              //==============================================================
              //! BACK BUTTON
              //==============================================================
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),

              const SizedBox(height: AppSpacing.lg),

              //==============================================================
              //! TITLE
              //==============================================================
              const Text('Find your account', style: AppTextStyles.heading1),

              const SizedBox(height: AppSpacing.md),

              //==============================================================
              //! SUBTITLE
              //==============================================================
              const Text(
                'Enter your email address to receive\n'
                'a password reset link.',
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.xxxl),

              //==============================================================
              //! EMAIL
              //==============================================================
              const Text('Email', style: AppTextStyles.label),

              const SizedBox(height: AppSpacing.sm),

              PrimaryTextField(
                controller: _emailController,
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validation: _viewModel.emailValidation,
                showValidationMessage: true,
              ),

              const Spacer(),

              //==============================================================
              //! BUTTON
              //==============================================================
              PrimaryButton(
                text: 'Send Reset Link',
                isLoading: _isLoading,
                onPressed: _sendResetLink,
              ),

              const SizedBox(height: AppSpacing.massive),
            ],
          ),
        ),
      ),
    );
  }
}
