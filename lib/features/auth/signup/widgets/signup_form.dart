import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/shared/widgets/buttons/custom_button.dart';
import 'package:bh_finder/shared/widgets/textfields/custom_text_field.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SignupForm({
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
        const Text(
          'Full Name',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 42,
          child: CustomTextField(
            controller: nameController,
            hintText: 'Enter your full name',
            prefixIcon: Icons.badge_outlined,
          ),
        ),

        const SizedBox(height: 13),

        //============================================================================
        //! EMAIL
        //============================================================================
        const Text(
          'Email or Phone Number',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
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
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
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

        const SizedBox(height: 13),

        //============================================================================
        //! CONFIRM PASSWORD
        //============================================================================
        const Text(
          'Confirm Password',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 42,
          child: CustomTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm your password',
            prefixIcon: Icons.lock_reset_outlined,
            isPasswordField: true,
          ),
        ),

        const SizedBox(height: 23),

        //============================================================================
        //! CREATE ACCOUNT BUTTON
        //============================================================================
        CustomButton(text: 'Create an account', onPressed: _createAccount),

        const SizedBox(height: 23),
      ],
    );
  }
}
