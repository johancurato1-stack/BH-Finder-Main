import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';
import 'package:bh_finder/core/theme/app_colors.dart';
import 'package:bh_finder/core/view_models/property_detail_data.dart';

//============================================================================
//! PROPERTY HEADER
//============================================================================

class PropertyDetailHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailHeader({super.key, required this.data});

  //============================================================================
  //! PROPERTIES
  //============================================================================

  final PropertyDetailData data;

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  /// Returns the appropriate color for a property status.
  Color _getStatusColor(PropertyStatus status) {
    switch (status) {
      case PropertyStatus.available:
        return const Color(0xFF00E676);

      case PropertyStatus.occupied:
        return const Color(0xFFEF5350);
    }
  }

  //============================================================================
  //! STATUS LABEL
  //============================================================================

  /// Returns a readable property status.
  String _getStatusLabel(PropertyStatus status) {
    switch (status) {
      case PropertyStatus.available:
        return 'Available';

      case PropertyStatus.occupied:
        return 'Occupied';
    }
  }

  //============================================================================
  //! BUILD
  //============================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //======================================================================
        //! STATUS
        //======================================================================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _getStatusColor(data.status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(radius: 4, backgroundColor: AppColors.white),

              const SizedBox(width: 6),

              Text(
                _getStatusLabel(data.status),
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        //======================================================================
        //! TITLE
        //======================================================================
        Text(
          data.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
            fontFamily: 'Roboto',
          ),
        ),

        const SizedBox(height: 5),

        //======================================================================
        //! PRICE
        //======================================================================
        Text(
          '₱ ${data.minimumPrice} / month',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            fontFamily: 'Roboto',
          ),
        ),

        const SizedBox(height: 6),

        //======================================================================
        //! DISTANCE
        //======================================================================
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: AppColors.tertiary),

            const SizedBox(width: 4),

            Expanded(
              child: Text(
                '${data.distance.toStringAsFixed(1)} km away',
                style: const TextStyle(fontSize: 13, color: AppColors.tertiary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
