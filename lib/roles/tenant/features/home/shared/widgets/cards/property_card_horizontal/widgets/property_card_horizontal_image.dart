import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyCardHorizontalImage extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardHorizontalImage({super.key, required this.boardingHouse});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final BoardingHouseModel boardingHouse;

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  Color _getStatusColor() {
    switch (boardingHouse.status.toLowerCase()) {
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
    return Stack(
      children: [
        //======================================================================
        //! COVER IMAGE
        //======================================================================
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.network(
            boardingHouse.imageUrl,
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
                  boardingHouse.status,
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
              '₱ ${boardingHouse.price}/mo',
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
