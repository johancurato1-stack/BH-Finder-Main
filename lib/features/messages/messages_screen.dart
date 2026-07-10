import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/messages/widgets/chat_tile.dart';
import 'package:bh_finder/features/messages/screens/notification_chat_screen.dart';
import 'package:bh_finder/features/messages/mock_data/mock_chat.dart';
import 'package:bh_finder/features/messages/screens/new_message_screen.dart';

class MessagesScreen extends StatelessWidget {
  final VoidCallback onBackPressed;

  const MessagesScreen({super.key, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Fixed Header (Doesn't Scroll)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onBackPressed,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                  ),
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewMessageScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.add_to_photos_outlined,
                      color: AppColors.primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),

            //* Fixed Search Bar (Doesn't Scroll)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.tertiary.withValues(alpha: 0.3),
                    width: 0.5,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: AppColors.tertiary, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search messages',
                          hintStyle: TextStyle(
                            color: AppColors.tertiary,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 1),

            //!======================================================================================================================================== S C R O L L A B L E  A R E A

            //* Only the items inside this Expanded will scroll
            Expanded(
              child: ListView.separated(
                // Add 1 extra count to layout the special Notifications Tile at the top
                itemCount: landlordConversations.length + 1,
                padding: const EdgeInsets.symmetric(vertical: 2),
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  color: AppColors.tertiary.withValues(alpha: 0.1),
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  // Index 0 is reserved exclusively for your read-only Notifications feed
                  if (index == 0) {
                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.1,
                            ),
                            child: const Icon(
                              Icons.notifications_active_rounded,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          ),
                          // The notification badge indicator dot
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: const Text(
                        'System Updates & Notifications',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      subtitle: const Text(
                        'Your application for Green Haven Boarding House has been approved!',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.secondary,
                          fontWeight:
                              FontWeight.bold, // Bold means unread status
                        ),
                      ),
                      trailing: const Text(
                        'Just now',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.tertiary,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationChatScreen(),
                          ),
                        );
                      },
                    );
                  }

                  // Standard landlord rows offset by -1 to adjust for our top tile position
                  final chatItem = landlordConversations[index - 1];
                  return ChatTile(
                    chat: chatItem,
                    onTap: () {
                      print("Opened regular chat ID: ${chatItem.id}");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
