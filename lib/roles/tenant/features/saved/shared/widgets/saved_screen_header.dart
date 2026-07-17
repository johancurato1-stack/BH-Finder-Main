import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/roles/tenant/shared/widgets/filters/filter_bottom_sheet/filter_bottom_sheet.dart';

class SavedScreenHeader extends StatelessWidget {
  final VoidCallback onBackPressed;

  const SavedScreenHeader({super.key, required this.onBackPressed});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          //============================================================================
          //! BACK BUTTON
          //============================================================================
          IconButton(
            onPressed: onBackPressed,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.secondary,
              size: 24,
            ),
          ),

          //============================================================================
          //! TITLE
          //============================================================================
          const Text(
            'Saved',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              color: AppColors.secondary,
            ),
          ),

          //============================================================================
          //! FILTER BUTTON
          //============================================================================
          IconButton(
            onPressed: () => FilterBottomSheet.show(context),
            icon: const Icon(
              Icons.tune_rounded,
              color: AppColors.primary,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}
