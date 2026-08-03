import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

//==========================================================================
//! DASHBOARD SCREEN HEADER
//==========================================================================

class DashboardScreenHeader extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const DashboardScreenHeader({super.key, required this.onNotificationPressed});

  //==========================================================================
  //! CALLBACKS
  //==========================================================================

  final VoidCallback onNotificationPressed;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.lg,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          //==============================================================
          //! APP TITLE
          //==============================================================
          const Row(
            children: [
              Icon(Icons.home_work_rounded, color: AppColors.primary, size: 25),

              SizedBox(width: 8),

              Text(
                'BH Finder',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          //==============================================================
          //! NOTIFICATIONS
          //==============================================================
          IconButton(
            onPressed: onNotificationPressed,

            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.secondary,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
