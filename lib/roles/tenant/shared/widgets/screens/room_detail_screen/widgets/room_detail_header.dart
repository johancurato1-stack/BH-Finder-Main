import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class RoomHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const RoomHeader({super.key, required this.room});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final RoomModel room;

  //============================================================================
  //! METHODS
  //============================================================================

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'occupied':
        return const Color(0xFFEF5350);

      case 'reserved':
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
            color: _getStatusColor(room.status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            room.status.toUpperCase(),
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        //==========================================================================
        //! TITLE
        //==========================================================================
        Text(
          room.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
          ),
        ),

        //==========================================================================
        //! PRICE
        //==========================================================================
        Text(
          '₱ ${room.price} / month',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
