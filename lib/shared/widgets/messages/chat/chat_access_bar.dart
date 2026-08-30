import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! CHAT ACCESS BAR
//============================================================================

class ChatAccessBar extends StatelessWidget {
  //============================================================================
  //! VARIABLES
  //============================================================================

  final String accessStatus;

  final VoidCallback? onBlock;

  final VoidCallback? onDelete;

  final VoidCallback? onAccept;

  final VoidCallback? onUnblock;

  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ChatAccessBar({
    super.key,
    required this.accessStatus,
    this.onBlock,
    this.onDelete,
    this.onAccept,
    this.onUnblock,
  });

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    switch (accessStatus) {
      case 'pending':
        return _buildPendingBar();

      case 'pending_sender':
        return _buildPendingSenderBar();

      case 'blocked':
        return _buildBlockedBar();

      case 'unlocked':
      case 'locked':
      default:
        return const SizedBox.shrink();
    }
  }

  //============================================================================
  //! PENDING BAR
  //============================================================================

  Widget _buildPendingBar() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),

      decoration: BoxDecoration(
        color: AppColors.white,

        border: Border(
          top: BorderSide(
            color: AppColors.tertiary.withValues(alpha: .12),
            width: .5,
          ),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          //====================================================================
          //! MESSAGE
          //====================================================================
          const Text(
            'This user wants to chat with you.',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),

          const SizedBox(height: 12),

          //====================================================================
          //! ACTIONS
          //====================================================================
          Row(
            children: [
              //================================================================
              //! BLOCK
              //================================================================
              Expanded(
                child: _buildActionButton(
                  label: 'Block',
                  onPressed: onBlock,
                  isDestructive: true,
                ),
              ),

              const SizedBox(width: 8),

              //================================================================
              //! DELETE
              //================================================================
              Expanded(
                child: _buildActionButton(label: 'Delete', onPressed: onDelete),
              ),

              const SizedBox(width: 8),

              //================================================================
              //! ACCEPT
              //================================================================
              Expanded(
                child: _buildActionButton(
                  label: 'Accept',
                  onPressed: onAccept,
                  isPrimary: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //============================================================================
  //! PENDING SENDER BAR
  //============================================================================

  Widget _buildPendingSenderBar() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),

      decoration: BoxDecoration(
        color: AppColors.white,

        border: Border(
          top: BorderSide(
            color: AppColors.tertiary.withValues(alpha: .12),
            width: .5,
          ),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          //====================================================================
          //! MESSAGE
          //====================================================================
          const Text(
            'Your inquiry is pending. You can message once the chat is unlocked.',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),

          const SizedBox(height: 12),

          //====================================================================
          //! DELETE
          //====================================================================
          SizedBox(
            width: double.infinity,

            child: _buildActionButton(label: 'Delete', onPressed: onDelete),
          ),
        ],
      ),
    );
  }

  //============================================================================
  //! BLOCKED BAR
  //============================================================================

  Widget _buildBlockedBar() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),

      decoration: BoxDecoration(
        color: AppColors.white,

        border: Border(
          top: BorderSide(
            color: AppColors.tertiary.withValues(alpha: .12),
            width: .5,
          ),
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          //====================================================================
          //! MESSAGE
          //====================================================================
          const Text(
            'You blocked this user.',
            textAlign: TextAlign.center,

            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),

          const SizedBox(height: 12),

          //====================================================================
          //! UNBLOCK
          //====================================================================
          SizedBox(
            width: double.infinity,

            child: _buildActionButton(label: 'Unblock', onPressed: onUnblock),
          ),
        ],
      ),
    );
  }

  //============================================================================
  //! ACTION BUTTON
  //============================================================================

  Widget _buildActionButton({
    required String label,
    required VoidCallback? onPressed,
    bool isPrimary = false,
    bool isDestructive = false,
  }) {
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;

    if (isPrimary) {
      backgroundColor = AppColors.primary;
      foregroundColor = AppColors.white;
      borderColor = AppColors.primary;
    } else if (isDestructive) {
      backgroundColor = AppColors.white;
      foregroundColor = Colors.red;
      borderColor = Colors.red.withValues(alpha: .35);
    } else {
      backgroundColor = AppColors.white;
      foregroundColor = AppColors.secondary;
      borderColor = AppColors.tertiary.withValues(alpha: .25);
    }

    return SizedBox(
      height: 42,

      child: OutlinedButton(
        onPressed: onPressed,

        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,

          foregroundColor: foregroundColor,

          side: BorderSide(color: borderColor, width: .8),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),

        child: Text(
          label,

          style: TextStyle(
            color: foregroundColor,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
