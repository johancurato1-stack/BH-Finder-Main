import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! LANDLORD BOTTOM NAVIGATION BAR
//============================================================================

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
  //! PROPERTIES
  //============================================================================

  final int currentIndex;

  final bool showMessagesBadge;

  final ValueChanged<int> onTap;

  static const _selectedLabelStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
  );

  static const _unselectedLabelStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
  );

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
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,

        enableFeedback: true,

        type: BottomNavigationBarType.fixed,

        elevation: 0,

        backgroundColor: AppColors.white,

        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.tertiary,

        selectedLabelStyle: _selectedLabelStyle,
        unselectedLabelStyle: _unselectedLabelStyle,

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
        Positioned(
          right: -2,
          top: -2,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            scale: showBadge ? 1 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: showBadge ? 1 : 0,
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
          ),
        ),
      ],
    );
  }
}
