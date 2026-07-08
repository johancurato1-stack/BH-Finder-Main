import 'package:flutter/material.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class RoomCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String title;
  final String distanceText;
  final String genderRules;
  final String availabilityCount;
  final bool isAvailable;

  const RoomCard({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.distanceText,
    required this.genderRules,
    required this.availabilityCount,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //!======================================================================================================================================== I M A G E  &  T E X T  S T A C K
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 140,
                    color: AppColors.tertiary.withValues(alpha: 0.2),
                    child: const Icon(
                      Icons.broken_image,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),
              //!======================================================================================================================================== S T A T U S  T A G
              if (isAvailable)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 3,
                          backgroundColor: AppColors.white,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Available',
                          style: TextStyle(
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
              //!======================================================================================================================================== P R I C I N G  T A G
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '₱ $price/mo',
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
          ),

          //!======================================================================================================================================== T I T L E
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                    fontFamily: 'Roboto',
                  ),
                ),

                const SizedBox(height: 3),

                //!======================================================================================================================================== D I S T A N C E
                Text(
                  distanceText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.tertiary,
                    fontFamily: 'Roboto',
                  ),
                ),

                const SizedBox(height: 5),

                //!======================================================================================================================================== D I V I D E R
                Divider(
                  color: AppColors.tertiary.withValues(alpha: 0.2),
                  height: 1,
                  thickness: 0.5,
                ),

                //!======================================================================================================================================== G E N D E R
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 14,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          genderRules,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    //!======================================================================================================================================== R O O M  C A P A C I T Y
                    Row(
                      children: [
                        const Icon(
                          Icons.group_outlined,
                          size: 14,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          availabilityCount,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
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
