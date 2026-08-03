import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/tenant_property_card_data.dart';

import 'package:bh_finder/shared/widgets/images/app_network_image.dart';

//============================================================================
//! PROPERTY CARD IMAGE
//============================================================================

class PropertyCardImage extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardImage({super.key, required this.data});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final TenantPropertyCardData data;

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  Color get _statusColor {
    switch (data.status) {
      case PropertyStatus.available:
        return const Color(0xFF00E676);

      case PropertyStatus.occupied:
        return const Color(0xFFEF5350);
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //==============================================================
        //! COVER IMAGE
        //==============================================================
        Hero(
          tag: data.id,

          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),

            child: SizedBox(
              width: 132,
              height: 128,

              child: AppNetworkImage(
                imageUrl: data.coverImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        //==============================================================
        //! STATUS INDICATOR
        //==============================================================
        Positioned(
          top: 8,
          left: 8,

          child: Container(
            width: 14,
            height: 14,

            decoration: BoxDecoration(
              color: _statusColor,
              shape: BoxShape.circle,

              border: Border.all(color: AppColors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
