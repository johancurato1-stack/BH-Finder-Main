import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

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
  //! PROPERTIES
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
        if (showAmenities) ...[
          PropertyCardAmenities(data: data),

          const SizedBox(height: 12),
        ],

        Row(
          children: [
            const SizedBox(width: 90),

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
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

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
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
