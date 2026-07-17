import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyRoomStatus extends StatelessWidget {
  //* Room data to display.
  final RoomModel room;

  const PropertyRoomStatus({super.key, required this.room});

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  //* Returns the appropriate color based on the room status.
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
    //* Cache the status color so it isn't recalculated multiple times.
    final statusColor = _getStatusColor(room.status);

    return Column(
      children: [
        //* Availability status.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            //* Display status in uppercase.
            room.status.toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 20),

        //* Indicates the card is tappable.
        const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.tertiary,
        ),
      ],
    );
  }
}
