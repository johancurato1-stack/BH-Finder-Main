import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

import 'package:bh_finder/roles/tenant/features/profile/widgets/menu_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const SettingsScreen({super.key});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            //========================================================================
            //! HEADER
            //========================================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),

                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.xs),

                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),

            //========================================================================
            //! BODY
            //========================================================================
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 4,
                ),

                children: [
                  const Text(
                    "Manage your account and preferences.",
                    style: TextStyle(
                      color: AppColors.tertiary,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                    ),
                  ),

                  const SizedBox(height: 28),

                  //==============================================================
                  //! ACCOUNT
                  //==============================================================
                  const Text(
                    "Account",
                    style: TextStyle(
                      color: AppColors.tertiary,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  MenuListTile(
                    icon: Icons.lock_outline_rounded,
                    title: "Change Password",
                    onTap: () {},
                  ),

                  MenuListTile(
                    icon: Icons.email_outlined,
                    title: "Email Address",
                    onTap: () {},
                  ),

                  MenuListTile(
                    icon: Icons.phone_outlined,
                    title: "Phone Number",
                    onTap: () {},
                  ),

                  const Divider(height: AppSpacing.xxxl, color: Colors.black12),

                  //==============================================================
                  //! PREFERENCES
                  //==============================================================
                  const Text(
                    "Preferences",
                    style: TextStyle(
                      color: AppColors.tertiary,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  MenuListTile(
                    icon: Icons.notifications_none_rounded,
                    title: "Notifications",
                    onTap: () {},
                  ),

                  MenuListTile(
                    icon: Icons.language_rounded,
                    title: "Language",
                    onTap: () {},
                  ),

                  const Divider(height: AppSpacing.xxxl, color: Colors.black12),

                  //==============================================================
                  //! LEGAL
                  //==============================================================
                  const Text(
                    "Legal",
                    style: TextStyle(
                      color: AppColors.tertiary,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                      letterSpacing: 1,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  MenuListTile(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    onTap: () {},
                  ),

                  MenuListTile(
                    icon: Icons.description_outlined,
                    title: "Terms & Conditions",
                    onTap: () {},
                  ),

                  const SizedBox(height: AppSpacing.huge),

                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "BH Finder",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                            fontSize: 15,
                          ),
                        ),

                        SizedBox(height: AppSpacing.xs),

                        Text(
                          "Version 1.0.0",
                          style: TextStyle(
                            color: AppColors.tertiary,
                            fontSize: 12,
                          ),
                        ),

                        Text(
                          "Made for students",
                          style: TextStyle(
                            color: AppColors.tertiary,
                            fontSize: 12,
                          ),
                        ),

                        SizedBox(height: AppSpacing.xxl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
