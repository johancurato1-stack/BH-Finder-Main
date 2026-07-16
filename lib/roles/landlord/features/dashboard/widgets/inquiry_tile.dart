import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class InquiryTile extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const InquiryTile({
    super.key,
    required this.name,
    required this.boardingHouse,
    required this.time,
    this.avatarUrl,
    this.onTap,
  });

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final String name;
  final String boardingHouse;
  final String time;
  final String? avatarUrl;
  final VoidCallback? onTap;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(16),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),

        child: Row(
          children: [
            //================================================================
            //! AVATAR
            //================================================================
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary.withValues(alpha: .10),

              backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                  ? NetworkImage(avatarUrl!)
                  : null,

              child: avatarUrl == null || avatarUrl!.isEmpty
                  ? const Icon(Icons.person, color: AppColors.primary)
                  : null,
            ),

            const SizedBox(width: AppSpacing.md),

            //================================================================
            //! INFORMATION
            //================================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    name,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    'Interested in $boardingHouse',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,

                    style: AppTextStyles.subtitle,
                  ),
                ],
              ),
            ),

            //================================================================
            //! TIME
            //================================================================
            Text(time, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}
