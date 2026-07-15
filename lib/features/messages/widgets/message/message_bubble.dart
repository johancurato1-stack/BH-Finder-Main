import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/features/messages/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  //============================================================================
  //! VARIABLES
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
        padding: const EdgeInsets.symmetric(vertical: 6),

        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,

          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 290),

              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.white,

                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),

                  bottomLeft: Radius.circular(isMe ? 18 : 4),

                  bottomRight: Radius.circular(isMe ? 4 : 18),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
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

            const SizedBox(height: 4),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.formattedTime,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.tertiary,
                    fontFamily: 'Roboto',
                  ),
                ),

                if (isMe) ...[
                  const SizedBox(width: 6),

                  Icon(
                    message.statusIcon,
                    size: 15,
                    color: message.statusColor,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
