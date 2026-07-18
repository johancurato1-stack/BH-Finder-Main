import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class PropertyInfo extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyInfo({super.key, required this.boardingHouse});

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final BoardingHouseModel boardingHouse;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //==================================================================
          //! BOARDING HOUSE NAME
          //==================================================================
          Text(
            boardingHouse.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,

            style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: AppSpacing.xs),

          //==================================================================
          //! DISTANCE
          //==================================================================
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.tertiary,
              ),

              const SizedBox(width: AppSpacing.xs),

              Expanded(
                child: Text(
                  boardingHouse.distanceText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: AppTextStyles.subtitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
