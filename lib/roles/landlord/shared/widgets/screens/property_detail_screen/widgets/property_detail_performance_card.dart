import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';

//============================================================================
//! PROPERTY PERFORMANCE CARD
//============================================================================

class PropertyDetailPerformanceCard extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyDetailPerformanceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final IconData icon;
  final String label;
  final String value;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 3,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //==========================================================================
          //! VALUE
          //==========================================================================
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),

          const SizedBox(height: 1),

          //==========================================================================
          //! LABEL
          //==========================================================================
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}
