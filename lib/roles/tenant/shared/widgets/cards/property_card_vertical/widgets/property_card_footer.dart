import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD FOOTER
//============================================================================

class PropertyCardFooter extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardFooter({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData data;

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
    return Row(
      children: [
        const Spacer(),

        const Icon(Icons.person_outline, size: 12, color: AppColors.secondary),

        const SizedBox(width: 2),

        Text(
          _genderText,
          style: const TextStyle(
            fontSize: 9,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
