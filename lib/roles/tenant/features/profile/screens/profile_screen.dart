import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/user_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/shared/widgets/screens/settings_screen.dart';
import 'package:bh_finder/shared/widgets/profile/menu_list_tile.dart';
import 'package:bh_finder/roles/landlord/shared/widgets/navigation/screens/landlord_navigation_screen.dart';
import 'package:bh_finder/shared/widgets/splash/screens/splash_screen.dart';

import 'package:bh_finder/core/view_models/auth_view_model.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';
import 'package:bh_finder/core/view_models/profile_view_model.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_profile_repository.dart';

class ProfileScreen extends StatefulWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ProfileScreen({super.key, required this.onNavigateToTab});

  final ValueChanged<int> onNavigateToTab;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //============================================================================
  //! VERIFICATION STATUS
  //============================================================================

  VerificationStatus _getVerificationStatus() {
    // Temporary until verification_requests is connected

    return VerificationStatus.unverified;
  }

  //============================================================================
  //! VIEW MODEL
  //============================================================================
  final ProfileViewModel _profileViewModel = ProfileViewModel(
    repository: SupabaseProfileRepository(),
  );

  final AuthViewModel _authViewModel = AuthViewModel(
    repository: SupabaseAuthRepository(),
  );

  //============================================================================
  //! LIFECYCLE
  //============================================================================

  @override
  void initState() {
    super.initState();

    _profileViewModel.loadProfile();
  }

  //============================================================================
  //! LOGOUT
  //============================================================================

  Future<void> _logout() async {
    await _authViewModel.signOut();
  }

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
    final profile = _profileViewModel.profile;

    if (profile == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                          '${profile['first_name']} ${profile['last_name']}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,

                          style: AppTextStyles.heading2.copyWith(
                            color: AppColors.white,
                            height: 1.1,
                          ),
                        ),

                        Text(
                          profile['email'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        _buildVerificationBadge(_getVerificationStatus()),
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
                    //! FAVORITES
                    //==========================================================
                    MenuListTile(
                      icon: Icons.favorite_rounded,
                      title: 'My Favorites',
                      subtitle: '${_profileViewModel.favoritesCount} listings',

                      onTap: () {
                        widget.onNavigateToTab(2);
                      },
                    ),

                    //==========================================================
                    //! MY INQUIRIES
                    //==========================================================
                    MenuListTile(
                      icon: Icons.email_rounded,
                      title: 'My Inquiries',
                      subtitle: '${_profileViewModel.inquiriesCount} inquiries',

                      onTap: () {
                        widget.onNavigateToTab(3);
                      },
                    ),

                    const Divider(height: 30, color: Colors.black12),

                    //==========================================================
                    //! BECOME LANDLORD
                    //==========================================================
                    MenuListTile(
                      icon: Icons.apartment,
                      title: 'Become A Landlord',

                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SplashScreen(
                              destination: LandlordNavigationScreen(),
                            ),
                          ),
                          (route) => false,
                        );
                      },
                    ),

                    const Divider(height: 30, color: Colors.black12),

                    //==========================================================
                    //! HELP CENTER (COMING SOON)
                    //==========================================================
                    //MenuListTile(
                    //icon: Icons.help_center_rounded,
                    //title: 'Help Center',

                    //onTap: () {
                    // TODO: Navigate to Help Center
                    //},
                    //),

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

                      onTap: () async {
                        await _logout();
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
