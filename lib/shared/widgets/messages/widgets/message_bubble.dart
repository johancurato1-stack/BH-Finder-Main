import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/models/message_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! MESSAGE BUBBLE
//============================================================================

class MessageBubble extends StatelessWidget {
  //============================================================================
  //! FIELDS
  //============================================================================

  final MessageModel message;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const MessageBubble({super.key, required this.message});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

      child: Padding(
        padding: EdgeInsets.only(
          top: 3,
          bottom: 3,
          left: isMe ? 56 : 0,
          right: isMe ? 0 : 56,
        ),

        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,

          children: [
            //==================================================================
            //! MESSAGE
            //==================================================================
            Container(
              constraints: const BoxConstraints(maxWidth: 290),

              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.white,

                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),

                  bottomLeft: Radius.circular(isMe ? 18 : 5),

                  bottomRight: Radius.circular(isMe ? 5 : 18),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .035),
                    blurRadius: 6,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),

              child: Text(
                message.text,

                style: TextStyle(
                  color: isMe ? Colors.white : AppColors.secondary,
                  fontSize: 14,
                  height: 1.35,
                  fontFamily: 'Roboto',
                ),
              ),
            ),

            const SizedBox(height: 3),

            //==================================================================
            //! TIME + STATUS
            //==================================================================
            Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  message.formattedTime,

                  style: const TextStyle(
                    fontSize: 10.5,
                    color: AppColors.tertiary,
                    fontFamily: 'Roboto',
                  ),
                ),

                if (isMe) ...[
                  const SizedBox(width: 5),

                  Icon(
                    _getMessageStatusIcon(),
                    size: 14,
                    color: _getMessageStatusColor(),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  //============================================================================
  //! MESSAGE STATUS ICON
  //============================================================================

  IconData _getMessageStatusIcon() {
    switch (message.status) {
      case MessageStatus.sending:
        return Icons.access_time_rounded;

      case MessageStatus.sent:
        return Icons.check_rounded;

      case MessageStatus.delivered:
        return Icons.done_all_rounded;

      case MessageStatus.seen:
        return Icons.done_all_rounded;
    }
  }

  //============================================================================
  //! MESSAGE STATUS COLOR
  //============================================================================

  Color _getMessageStatusColor() {
    switch (message.status) {
      case MessageStatus.seen:
        return Colors.blue;

      case MessageStatus.sending:
      case MessageStatus.sent:
      case MessageStatus.delivered:
        return AppColors.tertiary;
    }
  }
}
