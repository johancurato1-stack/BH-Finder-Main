import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/widgets/custom_text_field.dart';
import 'package:bh_finder/widgets/custom_button.dart';
import 'package:bh_finder/features/auth/register/signup_screen.dart';

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

                //* Welcome Text
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

                //* Login Text
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

                //* Subtitle Text
                const Text(
                  'Continue to manage your properties \nor find your perfect room.',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    color: AppColors.tertiary,
                  ),
                ),

                const SizedBox(height: 18),

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
                    isPasswordField:
                        true, // Hides the password input characters
                  ),
                ),

                const SizedBox(height: 40),

                //* Login button
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    print("Email: ${_emailController.text}");
                    print("Password: ${_passwordController.text}");
                  },
                ),

                const SizedBox(height: 30),

                //* Divider lines
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.tertiary.withOpacity(0.3),
                        thickness: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                          color: AppColors.tertiary,
                          fontSize: 13,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.tertiary.withOpacity(0.3),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                //* Google sign-in button
                CustomButton(
                  text: 'Sign in with Google',
                  isSecondary: true,
                  onPressed: () {
                    print("Google Login Tapped");
                  },
                ),

                const SizedBox(height: 50),

                //*Sign up button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Roboto',
                        color: AppColors.tertiary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
