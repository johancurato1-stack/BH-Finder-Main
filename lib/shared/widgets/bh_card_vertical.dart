import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/shared/widgets/bh_detail_screen.dart';
import 'package:bh_finder/core/data/models/bh_model.dart';
import 'package:bh_finder/core/provider/bh_provider.dart';

class BhCardVertical extends StatelessWidget {
  final BhModel boardingHouse;

  // Removed onHeartPressed, as we now use context.read<BhProvider>()
  const BhCardVertical({super.key, required this.boardingHouse});

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

  IconData _getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'wi-fi':
        return Icons.wifi;
      case 'aircon':
        return Icons.ac_unit;
      case 'own cr':
        return Icons.bathroom;
      case 'kitchen':
        return Icons.countertops;
      case 'laundry':
        return Icons.local_laundry_service;
      case 'study area':
        return Icons.menu_book;
      case 'desk':
        return Icons.desk;
      case 'cabinet':
        return Icons.shelves;
      case 'cctv':
        return Icons.videocam;
      case 'security':
        return Icons.security;
      case 'parking':
        return Icons.directions_car;
      default:
        return Icons.star_border_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                BhDetailScreen(
                  boardingHouse: boardingHouse,
                ), // Fixed: Removed onSavedStatusChanged
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeOut;
                  var tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: curve));
                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          boardingHouse.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1F36),
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      // The heart icon now talks directly to the Provider
                      GestureDetector(
                        onTap: () => context.read<BhProvider>().toggleSaved(
                          boardingHouse,
                        ),
                        child: Icon(
                          boardingHouse.isSaved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          // Change color based on the saved state
                          color: boardingHouse.isSaved
                              ? Colors.red
                              : AppColors.tertiary,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₱ ${boardingHouse.price} / month',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueAccent,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    boardingHouse.distanceText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 5,
                    children: boardingHouse.amenities.map((amenity) {
                      return Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          _getAmenityIcon(amenity),
                          size: 11,
                          color: Colors.grey.shade600,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        boardingHouse.genderRules,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.group_outlined,
                        size: 12,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        boardingHouse.availabilityCount,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 12, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        '${boardingHouse.rating} ',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '(${boardingHouse.reviewCount})',
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
