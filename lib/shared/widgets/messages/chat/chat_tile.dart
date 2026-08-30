import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/models/chat_model.dart';

//============================================================================
//! CHAT TILE
//============================================================================

class ChatTile extends StatelessWidget {
  //============================================================================
  //! FIELDS
  //============================================================================

  final ChatModel chat;

  final VoidCallback onTap;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatTile({super.key, required this.chat, required this.onTap});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),

      //============================================================================
      //! AVATAR
      //============================================================================
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 26,

            backgroundColor: AppColors.tertiary.withValues(alpha: 0.2),

            backgroundImage: chat.avatarUrl.isNotEmpty
                ? NetworkImage(chat.avatarUrl)
                : null,

            child: chat.avatarUrl.isEmpty
                ? const Icon(Icons.person, color: AppColors.secondary)
                : null,
          ),

          //======================================================================
          //! ONLINE INDICATOR
          //======================================================================
          if (chat.isOnline)
            Positioned(
              right: 0,
              bottom: 0,

              child: Container(
                width: 14,
                height: 14,

                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,

                  border: Border.all(color: AppColors.background, width: 2),
                ),
              ),
            ),
        ],
      ),

      //============================================================================
      //! CHAT INFORMATION
      //============================================================================
      title: Row(
        children: [
          Expanded(
            child: Text(
              chat.landlordName.isEmpty ? 'User' : chat.landlordName,

              maxLines: 1,

              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                fontWeight: chat.isUnread ? FontWeight.w700 : FontWeight.w600,
                fontSize: 15,
                color: AppColors.secondary,
                fontFamily: 'Roboto',
              ),
            ),
          ),

          //======================================================================
          //! MESSAGE TIME
          //======================================================================
          if (chat.lastMessageAt != null)
            Text(
              _formatMessageTime(chat.lastMessageAt!),

              style: TextStyle(
                fontSize: 11,
                color: chat.isUnread ? AppColors.primary : AppColors.tertiary,
                fontWeight: chat.isUnread ? FontWeight.w600 : FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
        ],
      ),

      //============================================================================
      //! LAST MESSAGE
      //============================================================================
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),

        child: Row(
          children: [
            Expanded(
              child: Text(
                _getSubtitle(),

                maxLines: 1,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: 13,
                  color: chat.isUnread
                      ? AppColors.secondary
                      : AppColors.tertiary,
                  fontWeight: chat.isUnread ? FontWeight.w600 : FontWeight.w400,
                  fontFamily: 'Roboto',
                ),
              ),
            ),

            //====================================================================
            //! UNREAD INDICATOR
            //====================================================================
            if (chat.isUnread)
              Container(
                width: 9,
                height: 9,

                margin: const EdgeInsets.only(left: 8),

                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),

      onTap: onTap,
    );
  }

  //============================================================================
  //! SUBTITLE
  //============================================================================

  String _getSubtitle() {
    if (!chat.isUnread) {
      return chat.lastMessage.isEmpty ? 'No messages yet' : chat.lastMessage;
    }

    if (chat.unreadCount >= 10) {
      return '9+ new messages';
    }

    if (chat.unreadCount == 1) {
      return 'New message';
    }

    return '${chat.unreadCount} new messages';
  }

  //============================================================================
  //! FORMAT MESSAGE TIME
  //============================================================================

  String _formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();

    final localDateTime = dateTime.toLocal();

    final difference = now.difference(localDateTime);

    //==========================================================================
    //! TODAY
    //==========================================================================

    if (now.year == localDateTime.year &&
        now.month == localDateTime.month &&
        now.day == localDateTime.day) {
      final hour = localDateTime.hour > 12
          ? localDateTime.hour - 12
          : localDateTime.hour == 0
          ? 12
          : localDateTime.hour;

      final minute = localDateTime.minute.toString().padLeft(2, '0');

      final period = localDateTime.hour >= 12 ? 'PM' : 'AM';

      return '$hour:$minute $period';
    }

    //==========================================================================
    //! YESTERDAY
    //==========================================================================

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    //==========================================================================
    //! WITHIN ONE WEEK
    //==========================================================================

    if (difference.inDays < 7) {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

      return days[localDateTime.weekday - 1];
    }

    //==========================================================================
    //! OLDER
    //==========================================================================

    return '${localDateTime.month}/${localDateTime.day}';
  }
}
