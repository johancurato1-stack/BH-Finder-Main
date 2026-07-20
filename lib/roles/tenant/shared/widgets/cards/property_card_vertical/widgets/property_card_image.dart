import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD IMAGE
//============================================================================

class PropertyCardImage extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardImage({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData data;

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  Color _getStatusColor() {
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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            data.coverImageUrl,
            height: 110,
            width: 120,
            fit: BoxFit.cover,
          ),
        ),

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
