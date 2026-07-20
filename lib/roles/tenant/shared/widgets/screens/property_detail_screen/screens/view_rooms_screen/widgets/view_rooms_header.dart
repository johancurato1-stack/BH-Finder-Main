import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

class ViewRoomsHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const ViewRoomsHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onFilter,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final String title;
  final VoidCallback onBack;
  final VoidCallback onFilter;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          //====================================================================
          //! BACK BUTTON
          //====================================================================
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.secondary,
            iconSize: 24,
          ),

          //====================================================================
          //! TITLE
          //====================================================================
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          //====================================================================
          //! FILTER BUTTON
          //====================================================================
          IconButton(
            onPressed: onFilter,
            icon: const Icon(Icons.tune_rounded),
            color: AppColors.primary,
            iconSize: 26,
          ),
        ],
      ),
    );
  }
}
