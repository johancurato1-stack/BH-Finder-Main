import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD HORIZONTAL IMAGE
//============================================================================

class PropertyCardHorizontalImage extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontalImage({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final TenantPropertyCardData data;

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  Color _getStatusColor() {
    switch (data.status) {
      case PropertyStatus.occupied:
        return const Color(0xFFEF5350);

      case PropertyStatus.available:
        return const Color(0xFF00E676);
    }
  }

  //============================================================================
  //! STATUS LABEL
  //============================================================================

  String _getStatusLabel() {
    switch (data.status) {
      case PropertyStatus.available:
        return 'Available';

      case PropertyStatus.occupied:
        return 'Occupied';
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //======================================================================
        //! COVER IMAGE
        //======================================================================
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            data.coverImageUrl,
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        //======================================================================
        //! STATUS BADGE
        //======================================================================
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _getStatusColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 3, backgroundColor: AppColors.white),

                const SizedBox(width: 4),

                Text(
                  _getStatusLabel(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
        ),

        //======================================================================
        //! PRICE BADGE
        //======================================================================
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.black.withValues(alpha: .75),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '₱ ${data.minimumPrice.toStringAsFixed(0)}/mo',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
