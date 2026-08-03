import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/shared/widgets/cards/property_card_vertical/widgets/property_card_amenities.dart';

//============================================================================
//! PROPERTY CARD FOOTER
//============================================================================

class PropertyCardFooter extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardFooter({
    super.key,
    required this.data,
    this.showAmenities = true,
  });

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TenantPropertyCardData data;

  final bool showAmenities;

  //============================================================================
  //! GENDER TEXT
  //============================================================================

  String get _genderText {
    switch (data.genderPreference) {
      case GenderPreference.male:
        return 'Male';

      case GenderPreference.female:
        return 'Female';

      case GenderPreference.mixed:
        return 'Mixed';
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //==============================================================
        //! AMENITIES
        //==============================================================
        if (showAmenities) ...[
          PropertyCardAmenities(data: data),

          const SizedBox(height: 12),
        ],

        //==============================================================
        //! FOOTER
        //==============================================================
        Row(
          children: [
            const Spacer(),

            //==========================================================
            //! FAVORITES
            //==========================================================
            Icon(
              Icons.favorite,
              size: 14,
              color: data.isFavorite ? Colors.red : AppColors.secondary,
            ),

            const SizedBox(width: 4),

            Text(
              data.favoriteCount.toString(),

              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                color: AppColors.secondary,
              ),
            ),

            const SizedBox(width: 16),

            //==========================================================
            //! GENDER
            //==========================================================
            const Icon(
              Icons.person_outline,
              size: 14,
              color: AppColors.secondary,
            ),

            const SizedBox(width: 4),

            Text(
              _genderText,

              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontFamily: 'Roboto',
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
