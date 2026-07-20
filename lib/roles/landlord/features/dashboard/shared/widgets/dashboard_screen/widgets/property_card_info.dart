import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_spacing.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';
import 'package:bh_finder/core/view_models/landlord_property_card_data.dart';

class PropertyCardInfo extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardInfo({super.key, required this.data});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final LandlordPropertyCardData data;

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
          //! PROPERTY TITLE
          //==================================================================
          Text(
            data.title,
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
                  '${data.distance.toStringAsFixed(0)} m away',
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
