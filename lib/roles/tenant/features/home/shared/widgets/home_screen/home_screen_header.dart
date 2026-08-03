import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/messages/screens/notification_chat_screen.dart';

//============================================================================
//! HOME SCREEN HEADER
//============================================================================

class HomeScreenHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreenHeader({
    super.key,
    required this.hasNotification,
    required this.onNotificationsRead,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final bool hasNotification;

  final VoidCallback onNotificationsRead;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        //======================================================================
        //! BRAND
        //======================================================================
        const _Brand(),

        //======================================================================
        //! NOTIFICATION BUTTON
        //======================================================================
        _NotificationButton(
          hasNotification: hasNotification,
          onNotificationsRead: onNotificationsRead,
        ),
      ],
    );
  }
}

//============================================================================
//! BRAND
//============================================================================

class _Brand extends StatelessWidget {
  const _Brand();

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    color: AppColors.primary,
  );

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.home_work_rounded, color: AppColors.primary, size: 25),

        SizedBox(width: 8),

        Text('BH Finder', style: _titleStyle),
      ],
    );
  }
}

//============================================================================
//! NOTIFICATION BUTTON
//============================================================================

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({
    required this.hasNotification,
    required this.onNotificationsRead,
  });

  final bool hasNotification;

  final VoidCallback onNotificationsRead;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,

      children: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.secondary,
            size: 28,
          ),

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationChatScreen()),
            );

            onNotificationsRead();
          },
        ),

        AnimatedScale(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          scale: hasNotification ? 1 : 0,

          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: hasNotification ? 1 : 0,

            child: Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.background, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
