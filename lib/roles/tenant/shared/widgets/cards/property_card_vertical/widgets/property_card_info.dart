import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD INFO
//============================================================================

class PropertyCardInfo extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardInfo({super.key, required this.data});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TenantPropertyCardData data;

  //============================================================================
  //! TEXT STYLES
  //============================================================================

  static const TextStyle _titleStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.secondary,
    fontFamily: 'Roboto',
  );

  static const TextStyle _priceStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    fontFamily: 'Roboto',
  );

  static const TextStyle _addressStyle = TextStyle(
    fontSize: 10,
    color: AppColors.tertiary,
    fontFamily: 'Roboto',
  );

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        //==============================================================
        //! TITLE
        //==============================================================
        Text(
          data.title,

          maxLines: 2,
          overflow: TextOverflow.ellipsis,

          style: _titleStyle,
        ),

        const SizedBox(height: 2),

        //==============================================================
        //! PRICE
        //==============================================================
        Text(
          '₱ ${data.minimumPrice.toStringAsFixed(0)} / month',
          style: _priceStyle,
        ),

        const SizedBox(height: 4),

        //==============================================================
        //! ADDRESS
        //==============================================================
        Text(
          '${data.address} km away',

          maxLines: 1,
          overflow: TextOverflow.ellipsis,

          style: _addressStyle,
        ),
      ],
    );
  }
}
