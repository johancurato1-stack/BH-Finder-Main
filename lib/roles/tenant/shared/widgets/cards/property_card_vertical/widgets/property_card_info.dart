import 'package:flutter/material.dart';

import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/property_and_room_adding_updating/ui_models/tenant_property_card_data.dart';

//============================================================================
//! PROPERTY CARD INFO
//============================================================================

class PropertyCardInfo extends StatelessWidget {
  const PropertyCardInfo({super.key, required this.data});

  final TenantPropertyCardData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          data.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1F36),
          ),
        ),

        const SizedBox(height: 1),

        Text(
          '₱ ${data.minimumPrice.toStringAsFixed(0)} / month',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          '${data.address} km away',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10, color: AppColors.tertiary),
        ),
      ],
    );
  }
}
