import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/shared/widgets/buttons/primary_button.dart';
import 'package:bh_finder/shared/widgets/dropdown_fields/primary_dropdown_field.dart';
import 'package:bh_finder/shared/widgets/textfields/primary_text_field.dart';

import 'package:bh_finder/core/view_models/auth_view_model.dart';

class SignupScreenForm extends StatelessWidget {
  final AuthViewModel viewModel;

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;

  final VoidCallback onCreateAccount;

  const SignupScreenForm({
    super.key,
    required this.viewModel,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.selectedGender,
    required this.onGenderChanged,
    required this.onCreateAccount,
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
        //! NAME
        //============================================================================
        const Text('Name', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PrimaryTextField(
                controller: firstNameController,
                hintText: 'First name',
                prefixIcon: Icons.person_outline,
                validation: viewModel.firstNameValidation,
              ),
            ),

            const SizedBox(width: AppSpacing.md),

            Expanded(
              child: PrimaryTextField(
                controller: lastNameController,
                hintText: 'Last name',
                prefixIcon: Icons.person_outline,
                validation: viewModel.lastNameValidation,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! EMAIL
        //============================================================================
        const Text('Email', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        PrimaryTextField(
          controller: emailController,
          hintText: 'Enter your email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validation: viewModel.emailValidation,
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! PHONE NUMBER
        //============================================================================
        const Text('Phone Number', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        PrimaryTextField(
          controller: phoneController,
          hintText: 'Enter your phone number',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validation: viewModel.phoneValidation,
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! GENDER
        //============================================================================
        const Text('Gender', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        PrimaryDropdownField<String>(
          value: selectedGender,
          hintText: 'Select your gender',
          prefixIcon: Icons.wc_outlined,
          validation: viewModel.genderValidation,
          onChanged: onGenderChanged,
          items: const [
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! PASSWORD
        //============================================================================
        const Text('Password', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        PrimaryTextField(
          controller: passwordController,
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_outline,
          isPasswordField: true,
          validation: viewModel.passwordValidation,
          showValidationMessage: true,
        ),

        const SizedBox(height: AppSpacing.md),

        //============================================================================
        //! CONFIRM PASSWORD
        //============================================================================
        const Text('Confirm Password', style: AppTextStyles.label),

        const SizedBox(height: AppSpacing.md),

        PrimaryTextField(
          controller: confirmPasswordController,
          hintText: 'Confirm your password',
          prefixIcon: Icons.lock_reset_outlined,
          isPasswordField: true,
          validation: viewModel.confirmPasswordValidation,
          showValidationMessage: true,
        ),

        const SizedBox(height: AppSpacing.xxl),

        //============================================================================
        //! CREATE ACCOUNT BUTTON
        //============================================================================
        PrimaryButton(text: 'Create Account', onPressed: onCreateAccount),

        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}
