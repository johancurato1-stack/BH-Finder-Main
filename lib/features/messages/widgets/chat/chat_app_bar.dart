import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/messages/models/chat_model.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final ChatModel chat;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatAppBar({super.key, required this.chat});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: AppColors.tertiary.withValues(alpha: 0.12),
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
          Hero(
            tag: chat.id,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(chat.avatarUrl),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              chat.landlordName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
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
            // TODO: Conversation options
          },
          icon: const Icon(Icons.more_vert_rounded, color: AppColors.secondary),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
