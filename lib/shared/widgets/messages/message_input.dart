import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class MessageInput extends StatelessWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final TextEditingController controller;
  final VoidCallback onSend;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,

      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),

        decoration: BoxDecoration(
          color: AppColors.white,

          border: Border(
            top: BorderSide(color: AppColors.tertiary.withValues(alpha: .12)),
          ),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            IconButton(
              onPressed: () {},

              splashRadius: 22,

              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: AppColors.primary,
                size: 24,
              ),
            ),

            const SizedBox(width: 1),

            Expanded(
              child: TextField(
                controller: controller,

                minLines: 1,
                maxLines: 5,

                textCapitalization: TextCapitalization.sentences,

                decoration: InputDecoration(
                  hintText: 'Type a message...',

                  hintStyle: const TextStyle(
                    color: AppColors.tertiary,
                    fontFamily: 'Roboto',
                  ),

                  filled: true,
                  fillColor: const Color(0xFFF4F5F7),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide.none,
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 6),

            Material(
              color: AppColors.primary,
              shape: const CircleBorder(),

              child: InkWell(
                onTap: onSend,
                customBorder: const CircleBorder(),

                child: const Padding(
                  padding: EdgeInsets.all(9),

                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
