import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class EditableProfileAvatar extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const EditableProfileAvatar({
    super.key,
    this.avatarUrl,
    this.radius = 35,
    this.editable = false,
    this.onTap,
  });

  final String? avatarUrl;

  final double radius;

  final bool editable;

  final VoidCallback? onTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    final hasAvatar = avatarUrl != null && avatarUrl!.trim().isNotEmpty;

    return GestureDetector(
      onTap: editable ? onTap : null,

      child: Stack(
        clipBehavior: Clip.none,

        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.white,

            backgroundImage: hasAvatar ? NetworkImage(avatarUrl!) : null,

            child: hasAvatar
                ? null
                : const Icon(Icons.person, size: 45, color: AppColors.tertiary),
          ),

          if (editable)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit, size: 16, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
