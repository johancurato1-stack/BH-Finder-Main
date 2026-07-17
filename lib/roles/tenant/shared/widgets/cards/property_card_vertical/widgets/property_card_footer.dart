import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyCardFooter extends StatelessWidget {
  final BoardingHouseModel boardingHouse;

  const PropertyCardFooter({super.key, required this.boardingHouse});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Gender preference.
        const Icon(Icons.person_outline, size: 12, color: AppColors.secondary),

        const SizedBox(width: 2),

        Text(
          boardingHouse.genderRules,
          style: const TextStyle(
            fontSize: 9,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(width: 8),

        // Available room count.
        const Icon(Icons.group_outlined, size: 12, color: AppColors.secondary),

        const SizedBox(width: 2),

        Text(
          boardingHouse.availabilityCount,
          style: const TextStyle(
            fontSize: 9,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),

        // Boarding house rating.
        const Icon(Icons.star, size: 12, color: Colors.amber),

        const SizedBox(width: 2),

        Text(
          '${boardingHouse.rating} ',
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),

        // Number of reviews.
        Text(
          '(${boardingHouse.reviewCount})',
          style: const TextStyle(fontSize: 9, color: AppColors.tertiary),
        ),
      ],
    );
  }
}
