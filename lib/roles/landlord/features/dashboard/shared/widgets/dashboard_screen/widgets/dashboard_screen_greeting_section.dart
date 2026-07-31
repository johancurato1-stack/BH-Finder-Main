import 'package:flutter/material.dart';

import 'package:bh_finder/core/models/user_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class DashboardScreenGreetingSection extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const DashboardScreenGreetingSection({
    super.key,
    required this.firstName,
    this.avatarUrl,
  });

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final String firstName;

  final String? avatarUrl;

  static const VerificationStatus _verificationStatus =
      VerificationStatus.unverified;

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

  Color _verificationColor(VerificationStatus status) {
    switch (status) {
      case VerificationStatus.verified:
        return Colors.green;

      case VerificationStatus.pending:
        return Colors.amber;

      case VerificationStatus.unverified:
        return Colors.red;
    }
  }

  IconData _verificationIcon(VerificationStatus status) {
    switch (status) {
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

                Text('$firstName 👋', style: AppTextStyles.heading2),
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
                backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null || avatarUrl!.isEmpty
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
                    _verificationIcon(_verificationStatus),
                    size: 14,
                    color: _verificationColor(_verificationStatus),
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
