import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyCardImage extends StatelessWidget {
  final BoardingHouseModel boardingHouse;

  const PropertyCardImage({super.key, required this.boardingHouse});

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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            boardingHouse.imageUrl,
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
