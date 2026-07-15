import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/messages/data/mock_notif.dart';

class NotificationChatScreen extends StatelessWidget {
  final VoidCallback? onRead;

  const NotificationChatScreen({super.key, this.onRead});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRead?.call();
    });

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: AppColors.tertiary.withValues(alpha: .12),
          ),
        ),

        leading: IconButton(
          onPressed: () => Navigator.pop(context),

          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondary,
            size: 20,
          ),
        ),

        titleSpacing: 0,

        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withValues(alpha: .10),

              child: const Icon(
                Icons.notifications_active_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Text(
                'BH Finder',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              // TODO: Notification options
            },

            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.secondary,
            ),
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        itemCount: notifications.length,

        itemBuilder: (context, index) {
          final notif = notifications[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .82,
                  ),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.white,

                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                      bottomLeft: Radius.circular(4),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),

                  child: Text(
                    notif['message']!,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,
                      height: 1.4,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                Padding(
                  padding: const EdgeInsets.only(left: 4),

                  child: Text(
                    notif['time']!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.tertiary,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
