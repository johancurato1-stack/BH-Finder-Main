import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

class PageIndicator extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final int currentPage;
  final int pageCount;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: 2),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: List.generate(pageCount, (index) {
          final isSelected = index == currentPage;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),

            margin: const EdgeInsets.symmetric(horizontal: 4),

            height: 6,

            width: isSelected ? 22 : 8,

            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.tertiary.withValues(alpha: .25),

              borderRadius: BorderRadius.circular(20),
            ),
          );
        }),
      ),
    );
  }
}
