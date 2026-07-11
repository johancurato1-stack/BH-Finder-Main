import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/messages/mock_data/mock_notif.dart';

class NotificationChatScreen extends StatelessWidget {
  final VoidCallback? onRead;

  const NotificationChatScreen({super.key, this.onRead});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (onRead != null) onRead!();
    });

    return Scaffold(
      backgroundColor: const Color(
        0xFFF7F8FA,
      ), // Light grey chat canvas background
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(
                Icons.notifications_active_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'System Updates',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Automated Assistant',
                  style: TextStyle(color: AppColors.tertiary, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. The Scrollable Chat Bubbles
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse:
                  false, // Shows newest system alerts at the bottom like standard text threads
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                // Reverse indexing so the array reads in chronologically natural order
                final notif = notifications[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Chat Bubble box styling
                      Container(
                        // Wrap constraints in a BoxConstraints object to fix the red line
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                            bottomLeft: Radius.circular(4),
                          ),
                          border: Border.all(
                            color: AppColors.tertiary.withOpacity(0.1),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          notif['message']!,
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: AppColors.secondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Message timestamp marker
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          notif['time']!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.tertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // 2. Disabled Input Banner Area (Messenger style read-only look)
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(
                  color: AppColors.tertiary.withOpacity(0.15),
                  width: 0.5,
                ),
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'You cannot reply to this official channel.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
