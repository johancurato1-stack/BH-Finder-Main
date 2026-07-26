import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/core/view_models/auth_view_model.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/auth/auth_header.dart';

import 'package:bh_finder/roles/tenant/features/auth/signup/shared/widgets/signup_screen_form.dart';
import 'package:bh_finder/roles/tenant/features/auth/signup/shared/widgets/signup_screen_login_prompt.dart';
import 'package:bh_finder/roles/tenant/features/auth/signup/shared/widgets/signup_screen_terms_section.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //============================================================================
  //! VIEW MODEL
  //============================================================================

  final AuthViewModel _viewModel = AuthViewModel(
    repository: SupabaseAuthRepository(),
  );

  //============================================================================
  //! CONTROLLERS
  //============================================================================

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //============================================================================
  //! DEBOUNCE TIMERS
  //============================================================================

  Timer? _firstNameTimer;

  Timer? _lastNameTimer;

  Timer? _emailTimer;

  Timer? _phoneTimer;

  Timer? _passwordTimer;

  Timer? _confirmPasswordTimer;

  static const Duration _validationDelay = Duration(milliseconds: 500);

  //============================================================================
  //! STATE
  //============================================================================

  String? _selectedGender;

  bool _agreedToTerms = false;

  //============================================================================
  //! VALIDATION HELPERS
  //============================================================================

  void _debounce(
    Timer? timer,
    VoidCallback callback,
    Function(Timer) assignTimer,
  ) {
    timer?.cancel();

    assignTimer(Timer(_validationDelay, callback));
  }

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _firstNameController.addListener(() {
      _debounce(_firstNameTimer, () {
        _viewModel.validateFirstName(_firstNameController.text);
        setState(() {});
      }, (timer) => _firstNameTimer = timer);
    });

    _lastNameController.addListener(() {
      _debounce(_lastNameTimer, () {
        _viewModel.validateLastName(_lastNameController.text);
        setState(() {});
      }, (timer) => _lastNameTimer = timer);
    });

    _emailController.addListener(() {
      _debounce(_emailTimer, () {
        _viewModel.validateEmail(_emailController.text);
        setState(() {});
      }, (timer) => _emailTimer = timer);
    });
    _phoneController.addListener(() {
      _debounce(_phoneTimer, () {
        _viewModel.validatePhone(_phoneController.text);
        setState(() {});
      }, (timer) => _phoneTimer = timer);
    });

    _passwordController.addListener(() {
      _debounce(_passwordTimer, () {
        _viewModel.validatePassword(_passwordController.text);

        _viewModel.validateConfirmPassword(
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );

        setState(() {});
      }, (timer) => _passwordTimer = timer);
    });

    _confirmPasswordController.addListener(() {
      _debounce(_confirmPasswordTimer, () {
        _viewModel.validateConfirmPassword(
          password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text,
        );

        setState(() {});
      }, (timer) => _confirmPasswordTimer = timer);
    });
  }

  //============================================================================
  //! CREATE ACCOUNT
  //============================================================================

  Future<void> _createAccount() async {
    if (!_viewModel.canCreateAccount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields correctly.'),
        ),
      );

      return;
    }

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the Terms & Conditions before continuing.',
          ),
        ),
      );

      return;
    }

    try {
      await _viewModel.signUp(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        gender: _selectedGender!,
        password: _passwordController.text,
      );

      print('========== ACCOUNT CREATED ==========');

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));

      print('SIGN UP ERROR: $e');
    }
  }

  //============================================================================
  //! DISPOSE
  //============================================================================

  @override
  void dispose() {
    _firstNameTimer?.cancel();
    _lastNameTimer?.cancel();
    _emailTimer?.cancel();
    _phoneTimer?.cancel();
    _passwordTimer?.cancel();
    _confirmPasswordTimer?.cancel();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                  viewModel: _viewModel,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  selectedGender: _selectedGender,
                  onGenderChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      _viewModel.validateGender(value);
                    });
                  },
                  onCreateAccount: _createAccount,
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
