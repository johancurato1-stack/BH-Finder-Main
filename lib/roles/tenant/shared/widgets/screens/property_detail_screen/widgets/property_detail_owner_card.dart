import 'package:flutter/material.dart';

import 'package:bh_finder/core/data/models/landlord_model.dart';
import 'package:bh_finder/core/theme/app_colors.dart';

class PropertyOwnerCard extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyOwnerCard({super.key, required this.landlord});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final Landlord landlord;

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(landlord.imageUrl),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                landlord.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),

              Text(
                landlord.responseTime,
                style: const TextStyle(fontSize: 12, color: AppColors.tertiary),
              ),
            ],
          ),
        ),

        IconButton(
          icon: const Icon(Icons.phone, color: AppColors.primary),
          onPressed: () {
            // TODO: Call landlord
          },
        ),
      ],
    );
  }
}
