import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class RoomCardVertical extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String distanceText;
  final String genderRules;
  final String availabilityCount;
  final String status;
  final double rating;
  final int reviewCount;
  final bool isSaved;
  final VoidCallback onHeartPressed;
  final List<String> amenities;

  const RoomCardVertical({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.distanceText,
    required this.genderRules,
    required this.availabilityCount,
    required this.status,
    required this.rating,
    required this.reviewCount,
    required this.isSaved,
    required this.onHeartPressed,
    required this.amenities,
  });

  Color _getStatusColor() {
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

  IconData _getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'aircon':
        return Icons.ac_unit;
      case 'own cr':
        return Icons.bathroom;
      case 'parking':
        return Icons.local_parking;
      case 'laundry':
        return Icons.local_laundry_service;
      case 'kitchen':
        return Icons.countertops;
      case 'study area':
        return Icons.menu_book;
      case 'cctv':
        return Icons.videocam;
      default:
        return Icons.star_border_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  imageUrl,
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

                  //* Title
                  children: [
                    Expanded(
                      child: Text(
                        title,
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
                    GestureDetector(
                      onTap: onHeartPressed,
                      child: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 2),

                //* Price Tag
                Text(
                  '₱ $price / month',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueAccent,
                    fontFamily: 'Roboto',
                  ),
                ),

                const SizedBox(height: 4),

                //* Distance
                Text(
                  distanceText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.tertiary,
                  ),
                ),

                const SizedBox(height: 6),

                //* Amenities
                Wrap(
                  spacing: 6,
                  runSpacing: 5,
                  children: amenities.map((amenity) {
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

                //* Gender
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 12,
                      color: AppColors.secondary,
                    ),

                    const SizedBox(width: 2),

                    Text(
                      genderRules,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(width: 8),

                    //* Capacity
                    const Icon(
                      Icons.group_outlined,
                      size: 12,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      availabilityCount,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    //* Rate
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(
                      '$rating ',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '($reviewCount)',
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
    );
  }
}
