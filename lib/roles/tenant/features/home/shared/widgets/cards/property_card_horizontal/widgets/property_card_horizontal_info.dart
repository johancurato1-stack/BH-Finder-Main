import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/widgets/property_card_horizontal_footer.dart';

class PropertyCardHorizontalInfo extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontalInfo({super.key, required this.boardingHouse});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final BoardingHouseModel boardingHouse;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //====================================================================
          //! TITLE
          //====================================================================
          Text(
            boardingHouse.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.secondary,
              fontFamily: 'Roboto',
            ),
          ),

          const SizedBox(height: 3),

          //====================================================================
          //! DISTANCE
          //====================================================================
          Text(
            boardingHouse.distanceText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.tertiary,
              fontFamily: 'Roboto',
            ),
          ),

          const SizedBox(height: 5),

          //====================================================================
          //! DIVIDER
          //====================================================================
          Divider(
            color: AppColors.tertiary.withValues(alpha: .2),
            height: 1,
            thickness: .5,
          ),

          const SizedBox(height: 8),

          //====================================================================
          //! FOOTER
          //====================================================================
          PropertyCardHorizontalFooter(boardingHouse: boardingHouse),
        ],
      ),
    );
  }
}
