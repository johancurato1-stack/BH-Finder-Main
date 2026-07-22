import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class RoomDetailFloatingActions extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomDetailFloatingActions({
    super.key,
    required this.onBack,
    required this.onShare,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final VoidCallback onBack;
  final VoidCallback onShare;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 12,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FloatingButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: onBack,
          ),

          _FloatingButton(icon: Icons.share, onTap: onShare),
        ],
      ),
    );
  }
}

//============================================================================
//! FLOATING BUTTON
//============================================================================

class _FloatingButton extends StatelessWidget {
  const _FloatingButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: AppColors.secondary),
      ),
    );
  }
}
