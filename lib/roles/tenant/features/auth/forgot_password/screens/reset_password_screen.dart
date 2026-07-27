import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/core/view_models/auth_view_model.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/dialogs/primary_dialog.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //============================================================================
  //! STATE
  //============================================================================

  bool _isLoading = false;

  //============================================================================
  //! VALIDATION TIMER
  //============================================================================

  Timer? _validationTimer;

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

    void validateFields() {
      _validationTimer?.cancel();

      _validationTimer = Timer(const Duration(milliseconds: 800), () {
        _viewModel.validatePassword(_passwordController.text);

        _viewModel.validateConfirmPassword(
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );

        if (mounted) {
          setState(() {});
        }
      });
    }

    _passwordController.addListener(validateFields);
    _confirmPasswordController.addListener(validateFields);
  }

  //============================================================================
  //! UPDATE PASSWORD
  //============================================================================

  Future<void> _updatePassword() async {
    _validationTimer?.cancel();

    _viewModel.validatePassword(_passwordController.text);

    _viewModel.validateConfirmPassword(
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    setState(() {});

    if (!_viewModel.passwordValidation.isValid ||
        !_viewModel.confirmPasswordValidation.isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _viewModel.updatePassword(password: _passwordController.text);

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (_) => PrimaryDialog(
          icon: Icons.lock_reset_rounded,
          iconColor: Colors.green,
          title: 'Password Updated',
          message: 'Your password has been updated successfully.',
          buttonText: 'OK',
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(this.context).popUntil((route) => route.isFirst);
          },
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to update your password. Please try again.'),
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
    _validationTimer?.cancel();

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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            AppSpacing.screenPadding,
            0,
            AppSpacing.screenPadding,
            MediaQuery.of(context).viewInsets.bottom + AppSpacing.xl,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xxxl),

                  //============================================================
                  //! TITLE
                  //============================================================
                  const Text('Reset Password', style: AppTextStyles.heading1),

                  const SizedBox(height: AppSpacing.md),

                  //============================================================
                  //! SUBTITLE
                  //============================================================
                  const Text(
                    'Create a new password for your\n'
                    'BH Finder account.',
                    style: AppTextStyles.subtitle,
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  //============================================================
                  //! NEW PASSWORD
                  //============================================================
                  const Text('New Password', style: AppTextStyles.label),

                  const SizedBox(height: AppSpacing.sm),

                  PrimaryTextField(
                    controller: _passwordController,
                    hintText: 'Enter your new password',
                    prefixIcon: Icons.lock_outline,
                    isPasswordField: true,
                    validation: _viewModel.passwordValidation,
                    showValidationMessage: true,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  //============================================================
                  //! CONFIRM PASSWORD
                  //============================================================
                  const Text('Confirm Password', style: AppTextStyles.label),

                  const SizedBox(height: AppSpacing.sm),

                  PrimaryTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm your new password',
                    prefixIcon: Icons.lock_outline,
                    isPasswordField: true,
                    validation: _viewModel.confirmPasswordValidation,
                    showValidationMessage: true,
                  ),

                  const Spacer(),

                  //============================================================
                  //! BUTTON
                  //============================================================
                  PrimaryButton(
                    text: 'Update Password',
                    isLoading: _isLoading,
                    onPressed: _updatePassword,
                  ),

                  const SizedBox(height: AppSpacing.massive),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
