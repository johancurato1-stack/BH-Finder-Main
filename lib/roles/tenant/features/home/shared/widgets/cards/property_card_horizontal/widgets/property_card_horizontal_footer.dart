import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyCardHorizontalFooter extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontalFooter({super.key, required this.boardingHouse});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final BoardingHouseModel boardingHouse;

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
              boardingHouse.genderRules,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        //======================================================================
        //! HEARTS
        //======================================================================
        Row(
          children: [
            const Icon(Icons.favorite, size: 14, color: Colors.red),

            const SizedBox(width: 4),

            Text(
              boardingHouse.availabilityCount,
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
