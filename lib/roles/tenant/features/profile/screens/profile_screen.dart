import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_radius.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/core/view_models/auth_view_model.dart';
import 'package:bh_finder/core/view_models/profile_view_model.dart';

import 'package:bh_finder/core/repositories/supabase/supabase_auth_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_profile_repository.dart';
import 'package:bh_finder/core/repositories/supabase/supabase_storage_repository.dart';

import 'package:bh_finder/shared/widgets/animations/animated_entrance.dart';

import 'package:bh_finder/shared/widgets/auth/auth_coordinator.dart';

import 'package:bh_finder/shared/widgets/profile/editable_profile_avatar.dart';
import 'package:bh_finder/shared/widgets/profile/menu_list_tile.dart';

import 'package:bh_finder/shared/widgets/screens/settings_screen.dart';

import 'package:bh_finder/shared/widgets/splash/screens/loading_screen.dart';

//============================================================================
//! PROFILE SCREEN
//============================================================================

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
  //! IMAGE PICKER
  //============================================================================

  final ImagePicker _imagePicker = ImagePicker();

  //============================================================================
  //! VIEW MODELS
  //============================================================================

  final ProfileViewModel _profileViewModel = ProfileViewModel(
    repository: SupabaseProfileRepository(),
    storageRepository: SupabaseStorageRepository(),
    authRepository: SupabaseAuthRepository(),
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
  //! PICK AVATAR
  //============================================================================

  Future<void> _pickAvatar() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) return;

    await _profileViewModel.updateAvatar(localPath: image.path);
  }

  //============================================================================
  //! LOGOUT
  //============================================================================

  Future<void> _logout() async {
    await _authViewModel.signOut();
  }

  //============================================================================
  //! SETTINGS
  //============================================================================

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  //============================================================================
  //! VERIFICATION STATUS
  //============================================================================

  UserVerificationStatus _getVerificationStatus() {
    // Temporary until verification_requests is connected.

    return UserVerificationStatus.unverified;
  }

  //============================================================================
  //! VERIFICATION BADGE
  //============================================================================

  Widget _buildVerificationBadge(UserVerificationStatus status) {
    IconData icon;
    String label;
    Color color;

    switch (status) {
      case UserVerificationStatus.verified:
        icon = Icons.verified;
        label = 'Verified';
        color = Colors.greenAccent;
        break;

      case UserVerificationStatus.pending:
        icon = Icons.hourglass_top_rounded;
        label = 'Pending';
        color = Colors.amberAccent;
        break;

      case UserVerificationStatus.unverified:
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
    return AnimatedBuilder(
      animation: _profileViewModel,
      builder: (context, _) {
        final profile = _profileViewModel.profile;

        if (_profileViewModel.isLoading || profile == null) {
          return const LoadingScreen();
        }

        return Scaffold(
          backgroundColor: AppColors.primary,

          body: SafeArea(
            bottom: false,

            child: Column(
              children: [
                //==============================================================
                //! HEADER
                //==============================================================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                    vertical: AppSpacing.xl,
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      //========================================================
                      //! PROFILE AVATAR
                      //========================================================
                      EditableProfileAvatar(
                        avatarUrl:
                            profile['avatar_path'] == null ||
                                (profile['avatar_path'] as String).isEmpty
                            ? null
                            : SupabaseStorageRepository().getPublicUrl(
                                'avatars',
                                (profile['avatar_path'] as String).replaceFirst(
                                  'avatars/',
                                  '',
                                ),
                              ),

                        editable: true,

                        onTap: _pickAvatar,
                      ),

                      const SizedBox(width: AppSpacing.lg),

                      //========================================================
                      //! USER INFORMATION
                      //========================================================
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

                      //========================================================
                      //! SETTINGS
                      //========================================================
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

                //==============================================================
                //! MENU
                //==============================================================
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
                        AnimatedEntrance(
                          order: 0,

                          child: MenuListTile(
                            icon: Icons.favorite_rounded,
                            title: 'My Favorites',
                            subtitle:
                                '${_profileViewModel.favoritesCount} properties',

                            onTap: () {
                              widget.onNavigateToTab(2);
                            },
                          ),
                        ),

                        AnimatedEntrance(
                          order: 1,

                          child: MenuListTile(
                            icon: Icons.email_rounded,
                            title: 'My Inquiries',
                            subtitle:
                                '${_profileViewModel.inquiriesCount} inquiries',

                            onTap: () {
                              widget.onNavigateToTab(3);
                            },
                          ),
                        ),

                        const Divider(height: 30, color: Colors.black12),

                        AnimatedEntrance(
                          order: 2,

                          child: MenuListTile(
                            icon: Icons.apartment,
                            title: 'Become A Landlord',

                            onTap: () async {
                              await _profileViewModel.updateLastActiveRole(
                                'landlord',
                              );

                              if (!context.mounted) return;

                              Navigator.pushAndRemoveUntil(
                                context,

                                MaterialPageRoute(
                                  builder: (_) => const AuthCoordinator(),
                                ),

                                (_) => false,
                              );
                            },
                          ),
                        ),

                        const Divider(height: 30, color: Colors.black12),

                        AnimatedEntrance(
                          order: 3,

                          child: MenuListTile(
                            icon: Icons.info_rounded,
                            title: 'About BH Finder',

                            onTap: () {},
                          ),
                        ),

                        const Divider(height: 34, color: Colors.black12),

                        AnimatedEntrance(
                          order: 4,

                          child: MenuListTile(
                            icon: Icons.logout_rounded,
                            title: 'Log Out',

                            textColor: Colors.red,
                            iconColor: Colors.red,

                            hideArrow: true,

                            onTap: () async {
                              await _logout();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
