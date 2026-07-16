import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class FilterSectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const FilterSectionTitle({super.key, required this.title, this.trailing});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          //============================================================================
          //! SECTION TITLE
          //============================================================================
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: AppColors.secondary,
            ),
          ),

          //============================================================================
          //! OPTIONAL TRAILING WIDGET
          //============================================================================
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
