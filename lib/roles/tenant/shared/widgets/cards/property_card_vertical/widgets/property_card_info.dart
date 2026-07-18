import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/property_card_data.dart';

//============================================================================
//! PROPERTY CARD INFO
//============================================================================

class PropertyCardInfo extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyCardInfo({
    super.key,
    required this.data,
    required this.onFavoritePressed,
  });

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final PropertyCardData data;

  final VoidCallback onFavoritePressed;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //==========================================================================
        //! TITLE & FAVORITE
        //==========================================================================
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                data.title,
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
              onTap: onFavoritePressed,
              child: Icon(
                data.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: data.isFavorite ? Colors.red : AppColors.tertiary,
                size: 18,
              ),
            ),
          ],
        ),

        const SizedBox(height: 2),

        //==========================================================================
        //! PRICE
        //==========================================================================
        Text(
          '₱ ${data.minimumPrice.toStringAsFixed(0)} / month',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.blueAccent,
            fontFamily: 'Roboto',
          ),
        ),

        const SizedBox(height: 4),

        //==========================================================================
        //! DISTANCE
        //==========================================================================
        Text(
          '${data.distance.toStringAsFixed(1)} km away',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
        ),
      ],
    );
  }
}
