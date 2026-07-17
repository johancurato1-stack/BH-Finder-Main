import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class HomeScreenSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const HomeScreenSearchBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Open the search screen when the search bar is tapped.
      onTap: onTap,

      child: Container(
        height: 63,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [
            const SizedBox(width: 10),

            //============================================================================
            //! SEARCH ICON
            //============================================================================
            const Icon(
              Icons.search_rounded,
              color: AppColors.tertiary,
              size: 18,
            ),

            const SizedBox(width: 8),

            //============================================================================
            //! SEARCH PLACEHOLDER
            //============================================================================
            const Text(
              'Search by location, school,\nor area..',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
                color: AppColors.tertiary,
              ),
            ),

            const Spacer(),

            //============================================================================
            //! SEARCH ACTION BUTTON
            //============================================================================
            Center(
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
            ),

            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
