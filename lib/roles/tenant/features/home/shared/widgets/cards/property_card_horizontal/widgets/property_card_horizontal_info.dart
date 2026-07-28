import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/roles/tenant/features/home/shared/widgets/cards/property_card_horizontal/widgets/property_card_horizontal_footer.dart';

//============================================================================
//! PROPERTY CARD HORIZONTAL INFO
//============================================================================

class PropertyCardHorizontalInfo extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontalInfo({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData data;

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
            data.title,
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
            '${data.address} km away',
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
          PropertyCardHorizontalFooter(data: data),
        ],
      ),
    );
  }
}
