import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/roles/tenant/features/messages/screens/notification_chat_screen.dart';

class HomeHeader extends StatelessWidget {
  final bool hasNotification;
  final VoidCallback onNotificationsRead;

  const HomeHeader({
    super.key,
    required this.hasNotification,
    required this.onNotificationsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //============================================================================
        //! BRAND
        //============================================================================
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

        //============================================================================
        //! NOTIFICATION BUTTON
        //============================================================================
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Opens the notifications screen.
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.secondary,
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationChatScreen(),
                  ),
                );

                onNotificationsRead();
              },
            ),

            // Display the unread notification indicator.
            if (hasNotification)
              Positioned(
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
          ],
        ),
      ],
    );
  }
}
