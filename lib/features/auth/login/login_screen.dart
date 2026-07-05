import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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

                // Welcome Text
                const Text(
                  'Welcome Back! 👋',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 10),

                // Login Text
                const Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle Text
                const Text(
                  'Continue to manage your properties \nor find your perfect room.',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: AppColors.tertiary,
                  ),
                ),

                const SizedBox(height: 30),

                // Email or Phone Number Label
                const Text(
                  'Email or Phone Number',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 10),

                // Email or Phone Number Text Field
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email or Phone Number',
                  hintText: 'Enter your email or phone number',
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                // Password Label
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),

                const SizedBox(height: 10),

                // Password Text Field
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  isPasswordField: true, // Hides the password input characters
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
