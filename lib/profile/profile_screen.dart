import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/profile/widgets/menu_list_tile.dart';
import 'package:bh_finder/core/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildVerificationBadge(VerificationStatus status) {
    IconData icon;
    String label;
    Color color;

    //* Verification Properties
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
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = mockUser;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            //!======================================================================================================================================== H E A D E R
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,

                //* Circle Avatar
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: AppColors.tertiary,
                    ),
                  ),

                  const SizedBox(width: 16),

                  //* User Info Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 6),

                        //* Verification Status
                        _buildVerificationBadge(user.verificationStatus),
                      ],
                    ),
                  ),

                  //* Settings Icon
                  IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      print("Settings Gear Clicked");
                    },
                  ),
                ],
              ),
            ),

            //!======================================================================================================================================== M E N U  B O D Y
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),

                  children: [
                    //* My Favorites
                    MenuListTile(
                      icon: Icons.favorite_rounded,
                      title: 'My Favorites',
                      subtitle: '${user.favoritesCount} listings',
                      onTap: () {
                        print("Favorites Tile Tapped");
                      },
                    ),

                    //* Recently Viewed
                    MenuListTile(
                      icon: Icons.history_rounded,
                      title: 'Recently Viewed',
                      subtitle: '${user.recentlyViewedCount} listings',
                      onTap: () {
                        print("Recently Viewed Tile Tapped");
                      },
                    ),

                    //* My Inquires
                    MenuListTile(
                      icon: Icons.email_rounded,
                      title: 'My Inquiries',
                      subtitle: '${user.inquiriesCount} Inquiries',
                      onTap: () {
                        print("Inquiries Tile Tapped");
                      },
                    ),

                    //* Divider
                    const Divider(height: 30, color: Colors.black12),

                    //* Account Settings
                    MenuListTile(
                      icon: Icons.person_rounded,
                      title: 'Account Settings',
                      onTap: () {
                        print("Account Settings Tapped");
                      },
                    ),

                    //* Help Center
                    MenuListTile(
                      icon: Icons.help_center_rounded,
                      title: 'Help Center',
                      onTap: () {
                        print("Help Center Tapped");
                      },
                    ),

                    //* About the App
                    MenuListTile(
                      icon: Icons.info_rounded,
                      title: 'About the App',
                      onTap: () {
                        print("About App Tapped");
                      },
                    ),

                    //* Divider
                    const Divider(height: 34, color: Colors.black12),

                    //* Logout
                    MenuListTile(
                      icon: Icons.logout_rounded,
                      title: 'Log Out',
                      textColor: Colors.red,
                      iconColor: Colors.red,
                      hideArrow: true,
                      onTap: () {
                        print("Log Out Action Dispatched");
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
