import 'package:bh_finder/core/data/models/room_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RoomCard extends StatelessWidget {
  //* Room data to display.
  final RoomModel room;

  //* Called when the card is tapped.
  final VoidCallback onTap;

  const RoomCard({super.key, required this.room, required this.onTap});

  //============================================================================
  //! HELPERS
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

  @override
  Widget build(BuildContext context) {
    //============================================================================
    //! LOCAL VARIABLES
    //============================================================================

    //* Cache the status color so it isn't recalculated multiple times.
    final statusColor = _getStatusColor(room.status);

    return GestureDetector(
      //* Called when the user taps the room card.
      onTap: onTap,

      child: Container(
        //* Space between room cards.
        margin: const EdgeInsets.only(bottom: 12),

        //* Internal spacing.
        padding: const EdgeInsets.all(12),

        //* Card appearance.
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.tertiary.withOpacity(0.1),
            width: 0.5,
          ),
        ),

        child: Row(
          children: [
            //============================================================================
            //! ROOM IMAGE
            //============================================================================
            ClipRRect(
              //* Rounded image corners.
              borderRadius: BorderRadius.circular(16),

              child: Image.network(
                //* Room thumbnail.
                room.imageUrl,

                //* Image dimensions.
                width: 80,
                height: 80,

                //* Crop image to completely fill the container.
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 12),

            //============================================================================
            //! ROOM INFORMATION
            //============================================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* Room title.
                  Text(
                    room.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //* Monthly rental price.
                  Text(
                    '₱ ${room.price} / month',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 13),

                  //* Room details.
                  Row(
                    children: [
                      //* Gender icon.
                      const Icon(
                        Icons.person_outline,
                        size: 15,
                        color: AppColors.tertiary,
                      ),

                      const SizedBox(width: 6),

                      //* Gender rules.
                      Text(
                        room.genderRules,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.tertiary,
                        ),
                      ),

                      const SizedBox(width: 10),

                      //* Capacity icon.
                      const Icon(
                        Icons.group_outlined,
                        size: 15,
                        color: AppColors.tertiary,
                      ),

                      const SizedBox(width: 6),

                      //* Room capacity.
                      Text(
                        room.capacity,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //============================================================================
            //! STATUS BADGE
            //============================================================================
            Column(
              children: [
                //* Availability status.
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),

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
            ),
          ],
        ),
      ),
    );
  }
}
