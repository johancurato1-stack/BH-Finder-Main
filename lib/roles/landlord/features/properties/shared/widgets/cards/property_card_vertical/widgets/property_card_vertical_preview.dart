import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/ui_models/landlord_property_card_data.dart';

import 'package:bh_finder/shared/widgets/images/app_network_image.dart';

//============================================================================
//! PROPERTY CARD VERTICAL PREVIEW
//============================================================================

class PropertyCardVerticalPreview extends StatelessWidget {
  //==========================================================================
  //! CONSTRUCTOR
  //==========================================================================

  const PropertyCardVerticalPreview({super.key, required this.data});

  //==========================================================================
  //! PROPERTIES
  //==========================================================================

  final LandlordPropertyCardData data;

  //==========================================================================
  //! HELPERS
  //==========================================================================

  Color _getStatusColor() {
    switch (data.status) {
      case PropertyStatus.occupied:
        return const Color(0xFFEF5350);

      case PropertyStatus.available:
        return const Color(0xFF00E676);
    }
  }

  //==========================================================================
  //! BUILD
  //==========================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //==============================================================
        //! PROPERTY IMAGE
        //==============================================================
        AppNetworkImage(
          imageUrl: data.coverImageUrl,
          width: 120,
          height: 110,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(10),
        ),

        //==============================================================
        //! STATUS INDICATOR
        //==============================================================
        Positioned(
          top: 6,
          left: 6,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: _getStatusColor(),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
