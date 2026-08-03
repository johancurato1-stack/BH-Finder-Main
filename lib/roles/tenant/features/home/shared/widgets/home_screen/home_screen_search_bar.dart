import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

//============================================================================
//! HOME SCREEN SEARCH BAR
//============================================================================

class HomeScreenSearchBar extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const HomeScreenSearchBar({super.key, required this.onTap});

  //============================================================================
  //! CALLBACKS
  //============================================================================

  final VoidCallback onTap;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 63,

        decoration: BoxDecoration(
          color: AppColors.white,

          borderRadius: BorderRadius.circular(12),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: const Row(
          children: [
            SizedBox(width: 10),

            //==============================================================
            //! SEARCH ICON
            //==============================================================
            Icon(Icons.search_rounded, color: AppColors.tertiary, size: 18),

            SizedBox(width: 8),

            //==============================================================
            //! PLACEHOLDER
            //==============================================================
            Expanded(
              child: Text(
                'Search by location, school,\nor area..',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                  color: AppColors.tertiary,
                ),
              ),
            ),

            //==============================================================
            //! ACTION BUTTON
            //==============================================================
            _SearchButton(),

            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

//============================================================================
//! SEARCH BUTTON
//============================================================================

class _SearchButton extends StatelessWidget {
  const _SearchButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,

      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),

      child: const Icon(Icons.search_rounded, color: AppColors.white, size: 22),
    );
  }
}
