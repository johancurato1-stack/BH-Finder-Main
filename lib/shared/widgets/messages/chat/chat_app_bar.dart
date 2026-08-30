import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/models/chat_model.dart';

//============================================================================
//! CHAT APP BAR
//============================================================================

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final ChatModel chat;

  final VoidCallback? onOptionsPressed;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatAppBar({super.key, required this.chat, this.onOptionsPressed});

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
          //====================================================================
          //! AVATAR
          //====================================================================
          Stack(
            children: [
              Hero(
                tag: chat.id,

                child: CircleAvatar(
                  radius: 20,

                  backgroundColor: AppColors.tertiary.withValues(alpha: 0.15),

                  backgroundImage: chat.avatarUrl.isNotEmpty
                      ? NetworkImage(chat.avatarUrl)
                      : null,

                  child: chat.avatarUrl.isEmpty
                      ? const Icon(
                          Icons.person,
                          color: AppColors.secondary,
                          size: 22,
                        )
                      : null,
                ),
              ),

              //================================================================
              //! ONLINE INDICATOR
              //================================================================
              if (chat.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,

                  child: Container(
                    width: 12,
                    height: 12,

                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,

                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 10),

          //====================================================================
          //! USER INFORMATION
          //====================================================================
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //==============================================================
                //! NAME
                //==============================================================
                Text(
                  chat.landlordName.isEmpty ? 'User' : chat.landlordName,

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                  ),
                ),

                const SizedBox(height: 1),

                //==============================================================
                //! ACTIVITY STATUS
                //==============================================================
                Text(
                  _getActivityStatus(),

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: chat.isOnline ? Colors.green : AppColors.tertiary,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      actions: [
        if (onOptionsPressed != null)
          IconButton(
            onPressed: onOptionsPressed,

            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.secondary,
            ),
          ),
      ],
    );
  }

  //============================================================================
  //! GET ACTIVITY STATUS
  //============================================================================

  String _getActivityStatus() {
    if (chat.isOnline) {
      return 'Active now';
    }

    final lastSeenAt = chat.lastSeenAt;

    if (lastSeenAt == null) {
      return 'Active recently';
    }

    final now = DateTime.now().toUtc();

    final lastSeen = lastSeenAt.toUtc();

    final difference = now.difference(lastSeen);

    //==========================================================================
    //! JUST NOW
    //==========================================================================

    if (difference.inMinutes < 1) {
      return 'Active just now';
    }

    //==========================================================================
    //! MINUTES
    //==========================================================================

    if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;

      return 'Active $minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    }

    //==========================================================================
    //! HOURS
    //==========================================================================

    if (difference.inHours < 24) {
      final hours = difference.inHours;

      return 'Active $hours ${hours == 1 ? 'hour' : 'hours'} ago';
    }

    //==========================================================================
    //! YESTERDAY
    //==========================================================================

    if (difference.inDays == 1) {
      return 'Active yesterday';
    }

    //==========================================================================
    //! DAYS
    //==========================================================================

    if (difference.inDays < 7) {
      final days = difference.inDays;

      return 'Active $days ${days == 1 ? 'day' : 'days'} ago';
    }

    //==========================================================================
    //! WEEKS
    //==========================================================================

    if (difference.inDays < 30) {
      final weeks = difference.inDays ~/ 7;

      return 'Active $weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    }

    //==========================================================================
    //! MONTHS
    //==========================================================================

    if (difference.inDays < 365) {
      final months = difference.inDays ~/ 30;

      return 'Active $months ${months == 1 ? 'month' : 'months'} ago';
    }

    //==========================================================================
    //! YEARS
    //==========================================================================

    final years = difference.inDays ~/ 365;

    return 'Active $years ${years == 1 ? 'year' : 'years'} ago';
  }

  //============================================================================
  //! PREFERRED SIZE
  //============================================================================

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
