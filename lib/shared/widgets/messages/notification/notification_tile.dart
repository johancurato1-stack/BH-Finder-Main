import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class NotificationTile extends StatelessWidget {
  //============================================================================
  //! CALLBACK
  //============================================================================

  final VoidCallback onTap;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const NotificationTile({super.key, required this.onTap});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),

      leading: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,

        children: [
          const CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primary,

            child: Icon(
              Icons.notifications_active_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),

          Positioned(
            right: -2,
            top: -2,

            child: Container(
              width: 18,
              height: 18,

              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
              ),

              child: const Center(
                child: Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          const Expanded(
            child: Text(
              "BH Finder",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.secondary,
                fontFamily: 'Roboto',
              ),
            ),
          ),

          const Text(
            "Now",
            style: TextStyle(
              fontSize: 11,
              color: AppColors.tertiary,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),

      subtitle: const Padding(
        padding: EdgeInsets.only(top: 1),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Official Notifications",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                fontFamily: 'Roboto',
              ),
            ),

            SizedBox(height: 2),

            Text(
              "You have 3 new notifications.",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.secondary,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),

      onTap: onTap,
    );
  }
}
