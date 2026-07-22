import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

import 'package:bh_finder/core/data/mock/chat/mock_notif.dart';

class NotificationChatScreen extends StatelessWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final VoidCallback? onRead;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const NotificationChatScreen({super.key, this.onRead});

  //============================================================================
  //! METHODS
  //============================================================================

  void _markNotificationsAsRead() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onRead?.call();
    });
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    _markNotificationsAsRead();

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        //======================================================================
        //! BOTTOM DIVIDER
        //======================================================================
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            color: AppColors.tertiary.withValues(alpha: .12),
          ),
        ),

        //======================================================================
        //! BACK BUTTON
        //======================================================================
        leading: IconButton(
          onPressed: () => Navigator.pop(context),

          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondary,
            size: 20,
          ),
        ),

        titleSpacing: 0,

        //======================================================================
        //! HEADER
        //======================================================================
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

            const SizedBox(width: AppSpacing.md),

            Expanded(
              child: Text(
                'BH Finder',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyBold.copyWith(fontSize: 17),
              ),
            ),
          ],
        ),

        //======================================================================
        //! ACTIONS
        //======================================================================
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

      //========================================================================
      //! BODY
      //========================================================================
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),

        itemCount: notifications.length,

        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //==============================================================
                //! NOTIFICATION BUBBLE
                //==============================================================
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .82,
                  ),

                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
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
                    notification['message']!,
                    style: AppTextStyles.body.copyWith(height: 1.4),
                  ),
                ),

                //==============================================================
                //! TIMESTAMP
                //==============================================================
                const SizedBox(height: AppSpacing.xs),

                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.xs),

                  child: Text(
                    notification['time']!,
                    style: AppTextStyles.caption.copyWith(fontSize: 11),
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
