import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyHeader({super.key, required this.boardingHouse});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final BoardingHouseModel boardingHouse;

  //============================================================================
  //! METHODS
  //============================================================================

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'occupied':
        return const Color(0xFFEF5350);

      case 'pending':
        return const Color(0xFFFFB300);

      case 'available':
      default:
        return const Color(0xFF00E676);
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==========================================================================
        //! STATUS
        //==========================================================================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _getStatusColor(boardingHouse.status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(radius: 4, backgroundColor: AppColors.white),

              const SizedBox(width: 6),

              Text(
                boardingHouse.status,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        //==========================================================================
        //! TITLE
        //==========================================================================
        Text(
          boardingHouse.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
            fontFamily: 'Roboto',
          ),
        ),

        const SizedBox(height: 5),

        //==========================================================================
        //! PRICE
        //==========================================================================
        Text(
          '₱ ${boardingHouse.price} / month',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontFamily: 'Roboto',
          ),
        ),

        const SizedBox(height: 6),

        //==========================================================================
        //! DISTANCE
        //==========================================================================
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: AppColors.tertiary),

            const SizedBox(width: 4),

            Expanded(
              child: Text(
                boardingHouse.distanceText,
                style: const TextStyle(fontSize: 13, color: AppColors.tertiary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
