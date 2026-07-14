import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/data/models/room_model.dart';

class RoomCard extends StatelessWidget {
  final RoomModel room;
  final VoidCallback onTap;

  const RoomCard({super.key, required this.room, required this.onTap});

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
    return GestureDetector(
      onTap: onTap, // Directly calling the function passed from the parent
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
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
            // Room Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                room.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            // Room Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "₱ ${room.price} / month",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 15,
                        color: AppColors.tertiary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        room.genderRules,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.tertiary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.group_outlined,
                        size: 15,
                        color: AppColors.tertiary,
                      ),
                      const SizedBox(width: 6),
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
            // Status Tag & Arrow
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(room.status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    room.status.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
