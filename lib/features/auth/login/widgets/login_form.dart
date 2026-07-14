import 'package:flutter/material.dart';

import 'package:bh_finder/app.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/buttons/custom_button.dart';
import 'package:bh_finder/shared/widgets/textfields/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
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
      MaterialPageRoute(builder: (_) => const MainNavigationWrapper()),
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
        const Text(
          'Email or Phone Number',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 42,
          child: CustomTextField(
            controller: emailController,
            hintText: 'Enter your email or phone number',
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.emailAddress,
          ),
        ),

        const SizedBox(height: 13),

        //============================================================================
        //! PASSWORD
        //============================================================================
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 42,
          child: CustomTextField(
            controller: passwordController,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            isPasswordField: true,
          ),
        ),

        const SizedBox(height: 40),

        //============================================================================
        //! LOGIN BUTTON
        //============================================================================
        CustomButton(text: 'Login', onPressed: () => _login(context)),

        const SizedBox(height: 30),
      ],
    );
  }
}
