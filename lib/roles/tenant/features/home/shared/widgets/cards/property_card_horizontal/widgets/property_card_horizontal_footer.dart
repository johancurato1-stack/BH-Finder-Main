import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD HORIZONTAL FOOTER
//============================================================================

class PropertyCardHorizontalFooter extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontalFooter({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData data;

  //============================================================================
  //! GENDER LABEL
  //============================================================================

  String _getGenderLabel() {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //======================================================================
        //! GENDER PREFERENCE
        //======================================================================
        Row(
          children: [
            const Icon(
              Icons.person_outline,
              size: 14,
              color: AppColors.secondary,
            ),

            const SizedBox(width: 4),

            Text(
              _getGenderLabel(),
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        //======================================================================
        //! FAVORITES
        //======================================================================
        Row(
          children: [
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
          ],
        ),
      ],
    );
  }
}
