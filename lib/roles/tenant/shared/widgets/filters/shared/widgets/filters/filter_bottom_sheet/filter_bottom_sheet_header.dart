import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class FilterBottomSheetHeader extends StatelessWidget {
  final VoidCallback onReset;

  const FilterBottomSheetHeader({super.key, required this.onReset});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          const Text(
            'Filter Listings',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.secondary,
              fontFamily: 'Roboto',
            ),
          ),

          TextButton(
            onPressed: onReset,

            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.primary,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
