import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD IMAGE
//============================================================================

class PropertyCardImage extends StatelessWidget {
  const PropertyCardImage({super.key, required this.data});

  final TenantPropertyCardData data;

  Color _getStatusColor() {
    switch (data.status) {
      case PropertyStatus.available:
        return const Color(0xFF00E676);

      case PropertyStatus.occupied:
        return const Color(0xFFEF5350);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          child: Image.network(
            data.coverImageUrl,
            width: 132,
            height: 128, // <- Match the card height
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          top: 8,
          left: 8,
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
