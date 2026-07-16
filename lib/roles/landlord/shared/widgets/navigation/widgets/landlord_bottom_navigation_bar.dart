import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class LandlordBottomNavigationBar extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const LandlordBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.showMessagesBadge,
    required this.onTap,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final int currentIndex;
  final bool showMessagesBadge;
  final ValueChanged<int> onTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),

      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,

        type: BottomNavigationBarType.fixed,

        backgroundColor: AppColors.white,

        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.tertiary,

        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          fontFamily: 'Roboto',
        ),

        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          fontFamily: 'Roboto',
        ),

        elevation: 0,

        items: [
          //====================================================================
          //! DASHBOARD
          //====================================================================
          const BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),

          //====================================================================
          //! PROPERTIES
          //====================================================================
          const BottomNavigationBarItem(
            icon: Icon(Icons.apartment_outlined),
            activeIcon: Icon(Icons.apartment_rounded),
            label: 'Properties',
          ),

          //====================================================================
          //! MESSAGES
          //====================================================================
          BottomNavigationBarItem(
            icon: _MessagesIcon(showBadge: showMessagesBadge, filled: false),

            activeIcon: _MessagesIcon(
              showBadge: showMessagesBadge,
              filled: true,
            ),

            label: 'Messages',
          ),

          //====================================================================
          //! PROFILE
          //====================================================================
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

//============================================================================
//! MESSAGE ICON
//============================================================================

class _MessagesIcon extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const _MessagesIcon({required this.showBadge, required this.filled});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final bool showBadge;
  final bool filled;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [
        Icon(
          filled
              ? Icons.chat_bubble_rounded
              : Icons.chat_bubble_outline_rounded,
        ),

        if (showBadge)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              width: 9,
              height: 9,

              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,

                border: Border.all(color: AppColors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}
