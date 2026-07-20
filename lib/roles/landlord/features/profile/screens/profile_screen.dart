import 'package:bh_finder/roles/tenant/shared/widgets/navigation/screens/tenant_navigation_screen.dart';
import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/mock/user/mock_user.dart';
import 'package:bh_finder/core/models/user_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/shared/widgets/screens/settings_screen.dart';
import 'package:bh_finder/shared/widgets/profile/menu_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ProfileScreen({super.key});

  //============================================================================
  //! METHODS
  //============================================================================

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  Widget _buildVerificationBadge(VerificationStatus status) {
    IconData icon;
    String label;
    Color color;

    switch (status) {
      case VerificationStatus.verified:
        icon = Icons.verified;
        label = 'Verified';
        color = Colors.greenAccent;
        break;

      case VerificationStatus.pending:
        icon = Icons.hourglass_top_rounded;
        label = 'Pending';
        color = Colors.amberAccent;
        break;

      case VerificationStatus.unverified:
        icon = Icons.dangerous_rounded;
        label = 'Not Verified';
        color = Colors.redAccent;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),

        const SizedBox(width: AppSpacing.xs),

        Text(label, style: AppTextStyles.bodyMedium.copyWith(color: color)),
      ],
    );
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final user = mockUser;

    return Scaffold(
      backgroundColor: AppColors.primary,

      body: SafeArea(
        bottom: false,

        child: Column(
          children: [
            //==========================================================================
            //! HEADER
            //==========================================================================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
                vertical: AppSpacing.xl,
              ),

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  //==============================================================
                  //! PROFILE AVATAR
                  //==============================================================
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.white,

                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: AppColors.tertiary,
                    ),
                  ),

                  const SizedBox(width: AppSpacing.lg),

                  //==============================================================
                  //! USER INFORMATION
                  //==============================================================
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          user.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.white,
                            height: 1.1,
                          ),
                        ),

                        Text(
                          user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        _buildVerificationBadge(user.verificationStatus),
                      ],
                    ),
                  ),

                  //==============================================================
                  //! SETTINGS BUTTON
                  //==============================================================
                  IconButton(
                    onPressed: () => _openSettings(context),

                    icon: const Icon(
                      Icons.settings_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            //==========================================================================
            //! MENU
            //==========================================================================
            Expanded(
              child: Container(
                width: double.infinity,

                decoration: const BoxDecoration(
                  color: AppColors.background,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.xl),
                    topRight: Radius.circular(AppRadius.xl),
                  ),
                ),

                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                    vertical: 18,
                  ),

                  children: [
                    //==========================================================
                    //! SAVED
                    //==========================================================
                    MenuListTile(
                      icon: Icons.apartment,
                      title: 'My Properties',
                      subtitle: '0 Properties',

                      onTap: () {
                        // TODO: Navigate to Properties
                      },
                    ),

                    const Divider(height: 30, color: Colors.black12),

                    //==========================================================
                    //! BECOME TENANT
                    //==========================================================
                    MenuListTile(
                      icon: Icons.house,
                      title: 'Become A Tenant',

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TenantNavigationScreen(),
                          ),
                        );
                      },
                    ),

                    const Divider(height: 30, color: Colors.black12),

                    //==========================================================
                    //! HELP CENTER
                    //==========================================================
                    MenuListTile(
                      icon: Icons.help_center_rounded,
                      title: 'Help Center',

                      onTap: () {
                        // TODO: Navigate to Help Center
                      },
                    ),

                    //==========================================================
                    //! ABOUT BH FINDER
                    //==========================================================
                    MenuListTile(
                      icon: Icons.info_rounded,
                      title: 'About BH Finder',

                      onTap: () {
                        // TODO: Navigate to About Screen
                      },
                    ),

                    const Divider(height: 34, color: Colors.black12),

                    //==========================================================
                    //! LOG OUT
                    //==========================================================
                    MenuListTile(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      textColor: Colors.red,
                      iconColor: Colors.red,
                      hideArrow: true,

                      onTap: () {
                        // TODO: Implement Logout
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
