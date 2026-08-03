import 'package:flutter/material.dart';

import 'package:bh_finder/core/enums/enums.dart';

import 'package:bh_finder/core/theme/app_colors.dart';

import 'package:bh_finder/core/ui_models/property_detail_data.dart';

//============================================================================
//! PROPERTY DETAIL HEADER
//============================================================================

class PropertyDetailHeader extends StatelessWidget {
  //============================================================================
  //! CONSTRUCTOR
  //============================================================================

  const PropertyDetailHeader({super.key, required this.data});

  //============================================================================
  //! VARIABLES
  //============================================================================

  final PropertyDetailData data;

  //============================================================================
  //! STATUS COLOR
  //============================================================================

  Color get _statusColor {
    switch (data.status) {
      case PropertyStatus.available:
        return const Color(0xFF00E676);

      case PropertyStatus.occupied:
        return const Color(0xFFEF5350);
    }
  }

  //============================================================================
  //! STATUS LABEL
  //============================================================================

  String get _statusLabel {
    switch (data.status) {
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
        //==============================================================
        //! STATUS
        //==============================================================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

          decoration: BoxDecoration(
            color: _statusColor,
            borderRadius: BorderRadius.circular(20),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              const CircleAvatar(radius: 4, backgroundColor: AppColors.white),

              const SizedBox(width: 6),

              Text(
                _statusLabel,

                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        //==============================================================
        //! TITLE
        //==============================================================
        Text(
          data.title,

          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
            color: AppColors.secondary,
          ),
        ),

        const SizedBox(height: 5),

        //==============================================================
        //! PRICE
        //==============================================================
        Text(
          '₱ ${data.minimumPrice.toStringAsFixed(0)} / month',

          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Roboto',
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: 6),

        //==============================================================
        //! ADDRESS
        //==============================================================
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Icon(
              Icons.location_on_rounded,
              size: 16,
              color: AppColors.tertiary,
            ),

            const SizedBox(width: 4),

            Expanded(
              child: Text(
                data.address,

                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Roboto',
                  color: AppColors.tertiary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
