import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/roles/tenant/features/messages/models/chat_model.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;

  const ChatTile({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: AppColors.tertiary.withValues(alpha: 0.2),
        backgroundImage: NetworkImage(chat.avatarUrl),
      ),

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chat.landlordName,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColors.secondary,
              fontFamily: 'Roboto',
            ),
          ),

          Text(
            chat.timeStamp,
            style: TextStyle(
              fontSize: 11,
              color: chat.isUnread ? AppColors.primary : AppColors.tertiary,
              fontWeight: chat.isUnread ? FontWeight.w700 : FontWeight.w400,
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat.propertyTitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                fontFamily: 'Roboto',
              ),
            ),

            const SizedBox(height: 2),

            Text(
              chat.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: chat.isUnread ? AppColors.secondary : AppColors.tertiary,
                fontWeight: chat.isUnread ? FontWeight.w600 : FontWeight.w400,
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
