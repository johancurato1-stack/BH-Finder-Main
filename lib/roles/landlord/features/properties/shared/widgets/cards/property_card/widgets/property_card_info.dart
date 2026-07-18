import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/theme/app_text_styles.dart';

class PropertyCardInfo extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardInfo({super.key, required this.boardingHouse});

  //==========================================================================
  //! VARIABLES
  //==========================================================================

  final BoardingHouseModel boardingHouse;

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 110,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //==============================================================
            //! TITLE
            //==============================================================
            Text(
              boardingHouse.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.heading3.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            //==============================================================
            //! DISTANCE
            //==============================================================
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: AppColors.tertiary,
                ),

                const SizedBox(width: 3),

                Expanded(
                  child: Text(
                    boardingHouse.distanceText,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.caption,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            //==============================================================
            //! GENDER
            //==============================================================
            Row(
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 12,
                  color: AppColors.secondary,
                ),

                const SizedBox(width: 2),

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

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
