import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/widgets/custom_text_field.dart';
import 'package:bh_finder/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                //*----------------------------------------------------------------------------------------------------------------- T O P  T E X T

                //* Create Account Text
                const Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 10),

                //* Lets Get Started Text
                const Text(
                  "Let's get started!",
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 10),

                //* Subtitle Text
                const Text(
                  'Join BH Finder today and experience \na better way to rent or manage.',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: AppColors.tertiary,
                  ),
                ),

                const SizedBox(height: 18),

                //*----------------------------------------------------------------------------------------------------------------- F U L L  N A M E

                //* Full Name Input Label
                const Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 10),

                //* Full Name Text Field
                SizedBox(
                  height: 42,
                  child: CustomTextField(
                    controller: _nameController,
                    hintText: 'Enter your full name',
                    prefixIcon: Icons.badge_outlined,
                  ),
                ),

                const SizedBox(height: 13),

                //*----------------------------------------------------------------------------------------------------------------- E M A I L  &  P H O N E

                //* Email or Phone Number Label
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

                //* Email or Phone Number Text Field
                SizedBox(
                  height: 42,
                  child: CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email or phone number',
                    prefixIcon: Icons.person_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                const SizedBox(height: 13),

                //*----------------------------------------------------------------------------------------------------------------- P A S S W O R D

                //* Password Label
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

                //* Password Text Field
                SizedBox(
                  height: 42,
                  child: CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    prefixIcon: Icons.lock_outline,
                    isPasswordField: true,
                  ),
                ),

                const SizedBox(height: 13),

                //*----------------------------------------------------------------------------------------------------------------- C O N F I R M  P A S S W O R D

                //* Confirm Password Label
                const Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 10),

                //* Confirm Password Text field
                SizedBox(
                  height: 42,
                  child: CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm your password',
                    prefixIcon: Icons.lock_reset_outlined,
                    isPasswordField: true,
                  ),
                ),

                const SizedBox(height: 18),

                //*----------------------------------------------------------------------------------------------------------------- T E R M S  &  P O L I C Y

                //* Terms of Service Checkbox Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        activeColor: AppColors.primary,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _agreedToTerms = newValue ?? false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            color: AppColors.tertiary,
                          ),
                          children: [
                            const TextSpan(text: 'I agree '),

                            //* Clickable Terms of Services Text
                            TextSpan(
                              text: 'Terms of Services',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // TODO: Navigate to Terms Screen in the future
                                  print("Terms of Services Tapped");
                                },
                            ),

                            const TextSpan(text: ' and '),

                            //* Clickable Privacy Policy Text
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // TODO: Navigate to Privacy Policy Screen in the future
                                  print("Privacy Policy Tapped");
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 23),

                //*-----------------------------------------------------------------------------------------------------------------

                //* Create an Account Button
                CustomButton(
                  text: 'Create an account',
                  onPressed: () {
                    print("Creating account for: ${_nameController.text}");
                    print("Agreed to terms status: $_agreedToTerms");
                  },
                ),

                const SizedBox(height: 23),

                //*-----------------------------------------------------------------------------------------------------------------

                //* Login Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        color: AppColors.tertiary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Roboto',
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
