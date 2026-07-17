import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bh_finder/core/data/models/boarding_house_model.dart';
import 'package:bh_finder/core/providers/boarding_house_provider.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyCardInfo extends StatelessWidget {
  final BoardingHouseModel boardingHouse;

  const PropertyCardInfo({super.key, required this.boardingHouse});

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Boarding house title and save button.
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

            // Toggle saved state using Provider.
            GestureDetector(
              onTap: () => context.read<BoardingHouseProvider>().toggleSaved(
                boardingHouse,
              ),
              child: Icon(
                boardingHouse.isSaved ? Icons.favorite : Icons.favorite_border,
                color: boardingHouse.isSaved ? Colors.red : AppColors.tertiary,
                size: 18,
              ),
            ),
          ],
        ),

        const SizedBox(height: 2),

        // Monthly rental price.
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

        // Distance from the selected school/location.
        Text(
          boardingHouse.distanceText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
        ),
      ],
    );
  }
}
