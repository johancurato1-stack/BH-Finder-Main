import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/core/data/models/user_model.dart';

class GreetingSection extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const GreetingSection({super.key, required this.user});

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final UserModel user;

  //==========================================================================
  //! HELPERS
  //==========================================================================

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    }

    if (hour < 18) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  Color _verificationColor() {
    switch (user.verificationStatus) {
      case VerificationStatus.verified:
        return Colors.green;

      case VerificationStatus.pending:
        return Colors.amber;

      case VerificationStatus.unverified:
        return Colors.red;
    }
  }

  IconData _verificationIcon() {
    switch (user.verificationStatus) {
      case VerificationStatus.verified:
        return Icons.verified;

      case VerificationStatus.pending:
        return Icons.hourglass_top_rounded;

      case VerificationStatus.unverified:
        return Icons.error;
    }
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),

      child: Row(
        children: [
          //==============================================================
          //! GREETING
          //==============================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('${_getGreeting()},', style: AppTextStyles.subtitle),

                const SizedBox(height: AppSpacing.xs),

                Text(user.firstname + ' 👋', style: AppTextStyles.heading2),
              ],
            ),
          ),

          //==============================================================
          //! PROFILE
          //==============================================================
          Stack(
            clipBehavior: Clip.none,

            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.white,
                backgroundImage: user.avatarUrl.isNotEmpty
                    ? NetworkImage(user.avatarUrl)
                    : null,

                child: user.avatarUrl.isEmpty
                    ? const Icon(Icons.person, color: AppColors.tertiary)
                    : null,
              ),

              Positioned(
                right: -2,
                bottom: -2,

                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.white,

                  child: Icon(
                    _verificationIcon(),
                    size: 14,
                    color: _verificationColor(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
