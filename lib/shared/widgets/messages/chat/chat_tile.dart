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
      leading: CircleAvatar(
        radius: 26,

        backgroundColor: AppColors.tertiary.withValues(alpha: 0.2),

        backgroundImage: chat.avatarUrl.isNotEmpty
            ? NetworkImage(chat.avatarUrl)
            : null,

        child: chat.avatarUrl.isEmpty
            ? const Icon(Icons.person, color: AppColors.secondary)
            : null,
      ),

      //============================================================================
      //! CHAT INFORMATION
      //============================================================================
      title: Text(
        chat.landlordName,

        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: AppColors.secondary,
          fontFamily: 'Roboto',
        ),
      ),

      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),

        //============================================================================
        //! LAST MESSAGE
        //============================================================================
        child: Text(
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
      ),

      onTap: onTap,
    );
  }
}
